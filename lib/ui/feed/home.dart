import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:telex/ui/feed/builder.dart';
import 'package:telex/ui/feed/tile.dart';
import 'package:telex/ui/section.dart';
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
  final animationKey = GlobalKey<AnimatedListState>();

  List<Tile> buffer = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.feedBuilder.build(),
      builder: (BuildContext context, data) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          for (int index = 0;
              index < widget.feedBuilder.tiles.length;
              index++) {
            Tile tile = widget.feedBuilder.tiles[index];
            if ((tile.weather != null && buffer.length == 0) ||
                tile.article != null &&
                    (!buffer
                        .map((t) => t.article != null ? t.article.id : -1)
                        .contains(tile.article.id))) {
              if (buffer.length > 0 &&
                  tile.type != buffer.last.type &&
                  buffer.last.type != "section") buffer.add(Section());
              buffer.add(tile);
              animationKey.currentState.insertItem(buffer.length,
                  duration: const Duration(milliseconds: 1000));
            }
          }
        });

        return Scaffold(
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
                          child: Icon(FeatherIcons.dollarSign,
                              color: Colors.black)),
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
                        MaterialPageRoute(
                            builder: (context) => SettingsPage())),
                  ),
                ],
                backgroundColor: Color(0xFF022A53),
              ),
            ],
            body: RefreshIndicator(
              key: _refreshKey,
              onRefresh: () async {
                await widget.feedBuilder.build();
                buffer = [];
                setState(() {});
              },
              child: CupertinoScrollbar(
                child: data.hasData
                    ? AnimatedList(
                        key: animationKey,
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        padding: EdgeInsets.only(top: 12.0),
                        initialItemCount: 1,
                        itemBuilder:
                            (BuildContext context, int index, animation) =>
                                articleItem(context, index, animation))
                    : SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                            child: SpinKitThreeBounce(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.grey[300]
                                    : Colors.grey[700])),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget articleItem(BuildContext context, int index, animation) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Interval(0.5, 1.0)),
      child: SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animation, curve: Interval(0.0, 1.0)),
        axisAlignment: 0.0,
        key: ValueKey<int>(index),
        axis: Axis.vertical,
        child: buffer.length > index ? buffer[index] : Container(),
      ),
    );
  }
}
