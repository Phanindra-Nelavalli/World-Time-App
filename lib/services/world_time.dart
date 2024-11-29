import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String time = "";
  String location;
  String flag;
  String url;
  bool isDayTime = false;

  WorldTime({required this.url, required this.location, required this.flag});

  Future<void> getData() async {
    try {
      http.Response response = await http
          .get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String utcOffset = data['utc_offset'];

      String offsetSign = utcOffset.substring(0, 1);
      int offsetHours = int.parse(utcOffset.substring(1, 3));
      int offsetMinutes = int.parse(utcOffset.substring(4, 6));

      DateTime now = DateTime.parse(datetime);

      Duration offsetDuration = Duration(
        hours: offsetSign == "+" ? offsetHours : -offsetHours,
        minutes: offsetSign == "+" ? offsetMinutes : -offsetMinutes,
      );
      now = now.add(offsetDuration);

      isDayTime = now.hour > 5 && now.hour < 19 ? true : false;

      time = DateFormat.jm().format(now);
      print(time);
    } catch (e) {
      print("Error - $e");
      time = "Could not get Time Currently";
    }
  }
}
