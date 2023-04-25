import 'dart:core';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

/// [location] Name of the city
/// [flag] URL to the image of the flag of the country to which the city belongs
/// [url] API endpoint for the respective location or city
/// [time] Local time of the city
/// [isDay] Whether its day or night at the location

class AsiaTime {
  late String location;
  late String flag;
  late String url;
  late String? time;
  late bool? isDay;

  AsiaTime(this.location, this.flag, this.url);

  /// Fetches the time data for the specific location
  /// Sets the time variable with it
  Future<void> getTime() async {
    try {
      /// Sending the HTTP request to the API
      var uri = Uri.parse('https://worldtimeapi.org/api/timezone/$url');
      Response res = await get(uri);

      /// Parsing the json to a Map from which we can use the data
      Map data = jsonDecode(res.body);

      /// Converting UTC datetime string to datetime object
      DateTime now = DateTime.parse(data['utc_datetime']);

      /// Adding the offset to UTC time to get the local time
      int offsetH = int.parse(data['utc_offset'].substring(1,3));
      int offsetM = int.parse(data['utc_offset'].substring(4,6));
      now = now.add(Duration(hours: offsetH, minutes: offsetM));

      /// Checking if it is day or night
      isDay = (now.hour >= 5 && now.hour < 19);

      /// Formatting the time in a more user readable way
      /// From 24 hours format to 12 hours format
      time = DateFormat.jm().format(now);
    }catch(e){
      print("Error");
    }
  }
}

/// [asiaLocations] List of all the locations and there information
List<AsiaTime> asiaLocations = [
  AsiaTime("Bangkok", "thailand.png", "Asia/Bangkok"),
  AsiaTime("Dhaka", "bangladesh.png", "Asia/Dhaka"),
  AsiaTime("Dubai", "uae.png", "Asia/Dubai"),
  AsiaTime("Kolkata", "india.png", "Asia/Kolkata"),
  AsiaTime("Hong Kong", "china.png", "Asia/Hong_Kong"),
  AsiaTime("Singapore", "indonesia.png", "Asia/Singapore"),
  AsiaTime("Tokyo", "japan.png", "Asia/Tokyo"),
  AsiaTime("Seoul", "korea.png", "Asia/Seoul"),
  AsiaTime("Baghdad", "iraq.png", "Asia/Baghdad"),
  AsiaTime("Kabul", "afghanistan.png", "Asia/Kabul"),
];
