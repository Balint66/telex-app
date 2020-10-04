import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:telex/ui/feed/builder.dart';
import 'package:telex/ui/settings/page.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeFeed extends StatefulWidget {
  HomeFeed({Key key}) : super(key: key);

  final FeedBuilder feedBuilder = FeedBuilder();

  @override
  _HomeFeedState createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.feedBuilder.build(),
      builder: (BuildContext context, data) => Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, _) => [
            SliverAppBar(
              floating: true,
              pinned: false,
              snap: false,
              leading: Padding(
                padding: EdgeInsets.all(10.0),
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: Colors.yellow,
                    padding: EdgeInsets.zero,
                    child: Center(
                        child:
                            Icon(FeatherIcons.dollarSign, color: Colors.black)),
                    onPressed: () => launch("https://tamogatas.telex.hu/")),
              ),
              centerTitle: true,
              title: Container(
                alignment: Alignment.center,
                child: Image.asset('assets/logo.png'),
                height: 24.0,
              ),
              actions: [
                IconButton(
                  icon: Icon(FeatherIcons.settings),
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SettingsPage())),
                ),
              ],
              backgroundColor: Color(0xFF022A53),
            ),
          ],
          body: RefreshIndicator(
            key: _refreshKey,
            onRefresh: () async {
              await widget.feedBuilder.build();
              setState(() {});
            },
            child: CupertinoScrollbar(
              child: ListView(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                padding: EdgeInsets.only(top: 12.0),
                children: data.hasData
                    ? widget.feedBuilder.tiles
                    : [
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Center(child: CircularProgressIndicator()),
                        )
                      ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
