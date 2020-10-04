import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:telex/data/models/exchange.dart';
import 'package:telex/data/models/weather.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:telex/utils/format.dart';
import 'package:intl/intl.dart';

class InfoView extends StatelessWidget {
  final DateFormat _dateFormat = DateFormat('yyyy. MM. dd. hh:mm');
  final WeatherInfo weather;
  final List<Exchange> exchanges;
  InfoView({Key key, this.weather, this.exchanges}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
        child: Container(
          padding: EdgeInsets.only(top: 10.0),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.75),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14.0),
              topRight: Radius.circular(14.0),
            ),
          ),
          child: DefaultTabController(
            length: 2,
            child: Container(
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: TabBar(tabs: [
                    Tab(
                      child: Text(
                        "Időjárás",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.headline5.color,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Árfolyamok",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.headline5.color,
                        ),
                      ),
                    ),
                  ]),
                ),
                Expanded(
                  child: TabBarView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Image.network(
                                      "https://openweathermap.org/img/wn/${weather.icon}@4x.png",
                                      width: 170,
                                      height: 100,
                                      fit: BoxFit.fitWidth,
                                    ),
                                    Text(capital(weather.description)),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "${weather.temperature}°",
                                      style: TextStyle(
                                        fontSize: 64.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 42.0),
                                      child: Text(
                                          "Valójában ${weather.feelsLike}°"),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 42.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Icon(FeatherIcons.droplet),
                                      SizedBox(height: 2.0),
                                      Text(weather.humidity.toString() + "%"),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Icon(FeatherIcons.eye),
                                      SizedBox(height: 2.0),
                                      Text((weather.visibility / 1000)
                                              .toString() +
                                          " km"),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Icon(FeatherIcons.wind),
                                      SizedBox(height: 2.0),
                                      Text(weather.windSpeed.toString() +
                                          " km/h"),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Icon([
                                        FeatherIcons.arrowUp,
                                        FeatherIcons.arrowUpRight,
                                        FeatherIcons.arrowRight,
                                        FeatherIcons.arrowDownRight,
                                        FeatherIcons.arrowDown,
                                        FeatherIcons.arrowDownLeft,
                                        FeatherIcons.arrowLeft,
                                        FeatherIcons.arrowUpLeft,
                                        FeatherIcons.arrowUp,
                                      ][(weather.windDirection / 45).round()]),
                                      SizedBox(height: 2.0),
                                      Text(weather.windDirection.toString() +
                                          "°")
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(bottom: 12.0),
                              child: Text(
                                "Frissítve: " +
                                    _dateFormat.format(weather.created),
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${exchanges[0].currency} ',
                                    style: TextStyle(
                                      fontFamily: 'monospace',
                                      fontSize: 24.0,
                                      color: Color(0xFF00916B),
                                    ),
                                  ),
                                  Icon(
                                      exchanges[0].up
                                          ? Icons.arrow_upward
                                          : Icons.arrow_downward,
                                      color: exchanges[0].up
                                          ? Colors.green
                                          : Colors.red),
                                  Text(
                                    ' ${exchanges[0].rate} Ft',
                                    style: TextStyle(fontSize: 32.0),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${exchanges[1].currency} ',
                                    style: TextStyle(
                                      fontFamily: 'monospace',
                                      fontSize: 24.0,
                                      color: Color(0xFF00916B),
                                    ),
                                  ),
                                  Icon(
                                      exchanges[1].up
                                          ? Icons.arrow_upward
                                          : Icons.arrow_downward,
                                      color: exchanges[1].up
                                          ? Colors.green
                                          : Colors.red),
                                  Text(
                                    ' ${exchanges[1].rate} Ft',
                                    style: TextStyle(fontSize: 32.0),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(bottom: 12.0),
                              child: Text(
                                "Frissítve: " +
                                    _dateFormat.format(exchanges[0].date),
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
