import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:telex/ui/feed/builder.dart';
import 'package:telex/ui/settings/page.dart';

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
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
            SliverAppBar(
              leading: IconButton(
                  icon: Icon(FeatherIcons.dollarSign), onPressed: () {}),
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
              //magic
            },

            // Message Tiles
            child: CupertinoScrollbar(
              child: ListView(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                padding: EdgeInsets.only(top: 12.0),
                children: data.hasData
                    ? widget.feedBuilder.tiles
                    : [Center(child: CircularProgressIndicator())],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
