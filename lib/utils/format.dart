import 'package:intl/intl.dart';

String capital(String text) => text != null && text.length > 1
    ? text.substring(0, 1).toUpperCase() + text.substring(1)
    : "";

String formatDate(DateTime date) => date != null
    ? date.hour + date.minute != 0
        ? DateFormat("y. m. d. H:m").format(date)
        : DateFormat("y. m. d.").format(date)
    : null;
