import 'package:timeago/src/messages/lookupmessages.dart'; // ignore: implementation_imports

class HuMessages implements LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'épp most';
  @override
  String aboutAMinute(int minutes) => 'egy perce';
  @override
  String minutes(int minutes) => '$minutes perce';
  @override
  String aboutAnHour(int minutes) => 'egy órája';
  @override
  String hours(int hours) => '$hours órája';
  @override
  String aDay(int hours) => 'egy napja';
  @override
  String days(int days) => '$days napja';
  @override
  String aboutAMonth(int days) => 'egy hónapja';
  @override
  String months(int months) => '$months hónapja';
  @override
  String aboutAYear(int year) => 'egy éve';
  @override
  String years(int years) => '$years éve';
  @override
  String wordSeparator() => ' ';
}
