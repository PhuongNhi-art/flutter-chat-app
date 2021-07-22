import 'package:intl/intl.dart';

class Utils {
  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return time;
  }

  static String readHourAndMinute(int timestamp) {
    // var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    // var diff = now.difference(date);
    var time = '';
    time = format.format(date);
    return time;
  }

  static String readDate(int timestamp) {
    var now = DateTime.now();
    // var format = DateFormat('HH:mm a');

    var format1 = DateFormat.EEEE();
    var format2 = DateFormat.yMMMMd();
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = now.difference(date);
    var time = '';
    if (diff.inDays >= 0 && diff.inDays < 7) {
      //show th date ex: Monday
      time = format1.format(date);
    } else {
      //show date ex: 22 July
      time = format2.format(date);
    }

    return time;
  }
}
