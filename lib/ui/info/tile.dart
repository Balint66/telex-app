import 'package:flutter/material.dart';
import 'package:telex/data/models/weather.dart';
import 'package:telex/data/models/exchange.dart';
import 'package:telex/ui/feed/tile.dart';
import 'package:telex/ui/info/view.dart';
import 'package:telex/utils/format.dart';


class InfoTile extends Tile {
  const InfoTile({Key key, this.weather, this.exchanges}) : super(key: key);
  
  final WeatherInfo weather;
  final List<Exchange> exchanges;
  final String type = "info";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8.0)],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          highlightColor: Colors.transparent,
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 8.0, right: 14.0),
            leading: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey[400]
                    : Colors.grey[900],
              ),
              child: Image.network(
                  'https://openweathermap.org/img/wn/${weather.icon}@4x.png'),
            ),
            title: Text('${weather.temperature} °C'),
            subtitle: Text(capital(weather.description)),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      exchanges[0].currency,
                      style: TextStyle(
                          fontFamily: 'monospace', color: Color(0xFF00916B)),
                    ),
                    Text(" ${exchanges[0].rate} Ft"),
                  ],
                ),
                SizedBox(height: 4.0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      exchanges[1].currency,
                      style: TextStyle(
                          fontFamily: 'monospace', color: Color(0xFF00916B)),
                    ),
                    Text(" ${exchanges[1].rate} Ft"),
                  ],
                ),
              ],
            ),
          ),
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => InfoView(
                weather: weather,
                exchanges: exchanges,
              ),
              backgroundColor: Colors.transparent,
            );
          },
        ),
      ),
    );
  }
}
