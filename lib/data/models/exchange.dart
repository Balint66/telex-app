class Exchange {
  String currency;
  double rate;
  bool up;
  DateTime date;

  Exchange(this.currency, this.rate, this.up, this. date);

  factory Exchange.fromJson(Map json) {
    String currency = json['currency'];
    double rate = json['rate'];
    bool up = json['updown'] == 'UP';
    DateTime date = DateTime.parse(json['date']['date']).toLocal();
    return Exchange(currency, rate, up, date);
  }
}