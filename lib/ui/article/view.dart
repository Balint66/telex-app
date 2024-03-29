import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:share/share.dart';
import 'package:telex/data/models/article_content.dart';
import 'package:telex/data/context/app.dart';
import 'package:telex/ui/image.dart';
import 'package:telex/ui/article/photo.dart';
import 'package:telex/ui/article/tag.dart';
import 'package:telex/utils/format.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

class ArticleView extends StatelessWidget {
  const ArticleView({Key key, @required this.article, this.fontFamily})
      : super(key: key);

  final String article;
  final String fontFamily;

  void handleLink(String url) {
    if (url.startsWith("/")) url = "https://telex.hu$url";

    launch(url, customTabsOption: CustomTabsOption(
      animation: CustomTabsSystemAnimation.slideIn(),
      enableInstantApps: false,
      toolbarColor: Color(0xFF022A53),
      enableUrlBarHiding: true,
      enableDefaultShare: true,
      showPageTitle: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: api.getArticleContent(article),
      builder: (context, AsyncSnapshot<ArticleContent> data) {
        List<Widget> tags = [];
        List<Widget> authors = [];
        List<Widget> recommended = [];

        if (data.hasData) {
          data.data.tags.forEach((tag) {
            tags.add(ArticleTag(
              text: "#" + tag.name,
            ));
          });

          data.data.authors.forEach((author) {
            authors.add(ListTile(
              leading: ClipOval(
                child: Image.network(
                  "https://telex.hu" + author.avatar,
                  width: 42.0,
                ),
              ),
              title: Text(author.name),
            ));
          });

          data.data.recommended.forEach((r) {
            recommended.add(ListTile(
              title:
                  Text(r.title, style: TextStyle(fontFamily: app.fontFamily)),
              subtitle: Text(r.tag.name),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ArticleView(article: r.slug)),
              ),
            ));
          });
        }

        return Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, _) => [
              SliverAppBar(
                expandedHeight:
                    data.hasData && data.data.heroImage != "" ? 200.0 : 0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: data.hasData && data.data.heroImage != ""
                      ? TelexImage(data.data.heroImage)
                      : null,
                  title: Text(
                    data.hasData && data.data.tag.name != ""
                        ? data.data.tag.name
                        : "",
                    style: TextStyle(color: Colors.white),
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                  centerTitle: true,
                ),
                backgroundColor: Color(0xFF022A53),
                actions: [
                  IconButton(
                    icon: Icon(FeatherIcons.share2),
                    color: Colors.white,
                    onPressed: () {
                      String month =
                          data.data.date.month.toString().padLeft(2, '0');
                      String day =
                          data.data.date.day.toString().padLeft(2, '0');

                      Share.share(
                          "https://telex.hu/${data.data.tag.slug}/${data.data.date.year}/$month/$day/${data.data.slug}");
                    },
                  )
                ],
              )
            ],
            body: Container(
              child: data.hasData
                  ? ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 14.0,
                            right: 14.0,
                            bottom: 8.0,
                          ),
                          child: SelectableText(
                            data.data.title,
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: app.fontFamily,
                            ),
                          ),
                        ),
                        data.data.date != null
                            ? Padding(
                                padding: EdgeInsets.only(
                                  bottom: 12.0,
                                  left: 14.0,
                                  top: 4.0,
                                ),
                                child: Row(
                                  children: [
                                    Icon(FeatherIcons.clock,
                                        size: 14.0, color: Color(0xFF00916B)),
                                    SizedBox(width: 8.0),
                                    Text(
                                      formatDate(data.data.date),
                                      style: TextStyle(
                                        fontFamily: "monospace",
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : null,
                        // Tags
                        Padding(
                          padding: EdgeInsets.only(
                            left: 12.0,
                            right: 12.0,
                            bottom: 12.0,
                          ),
                          child: Wrap(children: tags),
                        ),

                        // Lead
                        data.data.lead != null && data.data.lead != ""
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14.0,
                                  vertical: 16.0,
                                ),
                                child: SelectableText(data.data.lead,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17.0,
                                        fontFamily: app.fontFamily)),
                              )
                            : Container(),

                        // Content
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: Html(
                              onImageTap: (img, ctx, a, b) => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Photo(image: img)),
                                  ),
                              style: {
                                "*": Style(fontFamily: app.fontFamily),
                                "p": Style(
                                  fontSize: FontSize(16.0),
                                  textAlign: TextAlign.left,
                                ),
                                "figure": Style(margin: EdgeInsets.zero),
                                "figcaption": Style(
                                  fontSize: FontSize(14.0),
                                  padding: EdgeInsets.all(8.0),
                                  margin: EdgeInsets.only(top: 4.0),
                                  textAlign: TextAlign.center,
                                ),
                                "a": Style(
                                  color: Color(0xFF00916B),
                                  textDecoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                                "blockquote": Style(
                                  margin: EdgeInsets.zero,
                                  padding:
                                      EdgeInsets.only(left: 12.0, right: 6.0),
                                  border: Border(
                                    left: BorderSide(
                                      color: Color(0xFF00916B),
                                      width: 6.0,
                                    ),
                                  ),
                                  fontStyle: FontStyle.italic,
                                ),
                                "h1": Style(fontSize: FontSize(22.0)),
                                "li": Style(
                                  fontSize: FontSize(16.0),
                                  margin: EdgeInsets.only(bottom: 6.0),
                                ),
                              },
                              data: data.data.content.replaceAll(
                                  "/uploads/", "https://telex.hu/uploads/"),
                              onLinkTap: (url, ctx, a, b) => handleLink(url)),
                        ),

                        // Authors
                        data.data.authors.length > 0
                            ? Padding(
                                padding: EdgeInsets.only(
                                  left: 14.0,
                                  right: 14.0,
                                  top: 16.0,
                                ),
                                child: Text(
                                  "Szerkesztők",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24.0,
                                    fontFamily: app.fontFamily,
                                  ),
                                ),
                              )
                            : Container(),
                        Column(children: authors),

                        // Recommended
                        data.data.recommended.length > 0
                            ? Padding(
                                padding: EdgeInsets.only(
                                  left: 14.0,
                                  right: 14.0,
                                  top: 16.0,
                                  bottom: 4.0,
                                ),
                                child: Text(
                                  "Ajánlott",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24.0,
                                    fontFamily: app.fontFamily,
                                  ),
                                ),
                              )
                            : Container(),
                        Column(children: recommended),
                      ],
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                          child: SpinKitThreeBounce(
                              size: 42.0,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.grey[300]
                                  : Colors.grey[700])),
                    ),
            ),
          ),
        );
      },
    );
  }
}
