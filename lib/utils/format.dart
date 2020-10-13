import 'package:intl/intl.dart';

String capital(String text) => text != null && text.length > 1
    ? text.substring(0, 1).toUpperCase() + text.substring(1)
    : "";

String formatDate(DateTime date) => date != null
    ? date.hour + date.minute != 0
        ? DateFormat("y. M. d. H:mm").format(date)
        : DateFormat("y. M. d.").format(date)
    : null;
