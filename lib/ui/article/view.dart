import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:share/share.dart';
import 'package:telex/data/models/article_content.dart';
import 'package:telex/data/context/app.dart';
import 'package:telex/ui/article/photo.dart';
import 'package:telex/ui/article/tag.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleView extends StatelessWidget {
  final String article;
  const ArticleView({Key key, @required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: api.getArticleContent(article),
      builder: (context, AsyncSnapshot<ArticleContent> data) {
        List<Widget> tags = [];

        if (data.hasData) {
          data.data.tags.forEach((tag) {
            tags.add(ArticleTag(
              text: tag.name,
            ));
          });
        }

        return Scaffold(
          appBar: AppBar(
            leading:
                BackButton(color: Theme.of(context).textTheme.headline5.color),
            title: Text(
              data.hasData ? data.data.tag.name : "",
              style:
                  TextStyle(color: Theme.of(context).textTheme.headline5.color),
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            actions: [
              IconButton(
                icon: Icon(FeatherIcons.share2),
                color: Colors.black,
                onPressed: () {
                  String month =
                      data.data.date.month.toString().padLeft(2, '0');
                  String day = data.data.date.day.toString().padLeft(2, '0');

                  Share.share(
                      "https://telex.hu/${data.data.tag.slug}/${data.data.date.year}/$month/$day/${data.data.slug}");
                },
              )
            ],
          ),
          body: Container(
            child: data.hasData
                ? CupertinoScrollbar(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.0,
                            vertical: 15.0,
                          ),
                          child: Text(
                            data.data.title,
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 12.0,
                            right: 12.0,
                            bottom: 12.0,
                          ),
                          child: Wrap(children: tags),
                        ),
                        data.data.heroImage != null
                            ? Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: GestureDetector(
                                    child: Image.network(
                                      "https://telex.hu" + data.data.heroImage,
                                      loadingBuilder: (context, widget, event) {
                                        return event == null
                                            ? widget
                                            : Padding(
                                                padding: EdgeInsets.all(12.0),
                                                child: LinearProgressIndicator(),
                                              );
                                      },
                                    ),
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        child: Photo(
                                            image: "https://telex.hu" +
                                                data.data.heroImage),
                                      );
                                    }),
                              )
                            : Container(),
                        data.data.lead != null && data.data.lead != ""
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14.0,
                                  vertical: 16.0,
                                ),
                                child: Text(
                                  data.data.lead,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17.0),
                                ),
                              )
                            : Container(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: Html(
                            onImageTap: (img) => showDialog(
                                context: context, child: Photo(image: img)),
                            style: {
                              "p": Style(fontSize: FontSize(16.0)),
                              "figcaption": Style(
                                padding: EdgeInsets.all(4.0),
                                textAlign: TextAlign.center,
                              ),
                              "a": Style(
                                color: Color(0xFF00916B),
                                textDecoration: TextDecoration.none,
                              ),
                              "blockquote": Style(
                                margin: EdgeInsets.zero,
                                padding: EdgeInsets.only(left: 12.0),
                                border: Border(
                                  left: BorderSide(
                                    color: Color(0xFF00916B),
                                    width: 4.0,
                                  ),
                                ),
                              ),
                              "h1": Style(fontSize: FontSize(22.0)),
                              "li": Style(padding: EdgeInsets.zero, markerContent: "."),
                              
                            },
                            data: data.data.content.replaceAll(
                                "/uploads/", "https://telex.hu/uploads/"),
                            onLinkTap: (url) => launch(url),
                          ),
                        ),
                      ],
                    ),
                )
                : Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
