import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:sutt_task2/train_list.dart';

class Schedule {
  Schedule({
    required this.status,
    required this.message,
    required this.timestamp,
    required this.data,
  });

  bool status;
  String message;
  int timestamp;
  Data data;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        status: json["status"],
        message: json["message"],
        timestamp: json["timestamp"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "timestamp": timestamp,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.dataClass,
    required this.quota,
    required this.route,
  });

  List<Class> dataClass;
  List<Class> quota;
  List<Route> route;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        dataClass:
            List<Class>.from(json["class"].map((x) => Class.fromJson(x))),
        quota: List<Class>.from(json["quota"].map((x) => Class.fromJson(x))),
        route: List<Route>.from(json["route"].map((x) => Route.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "class": List<dynamic>.from(dataClass.map((x) => x.toJson())),
        "quota": List<dynamic>.from(quota.map((x) => x.toJson())),
        "route": List<dynamic>.from(route.map((x) => x.toJson())),
      };
}

class Class {
  Class({
    required this.value,
    required this.name,
  });

  String value;
  String name;

  factory Class.fromJson(Map<String, dynamic> json) => Class(
        value: json["value"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "name": name,
      };
}

class Route {
  Route({
    required this.dDay,
    required this.day,
    required this.distanceFromSource,
    required this.platformNumber,
    required this.staMin,
    required this.stationCode,
    required this.stationName,
    required this.stdMin,
    required this.stop,
    required this.sta,
    required this.todaySta,
  });

  int dDay;
  int day;
  String distanceFromSource;
  String? lat;
  String? lng;
  int platformNumber;
  int staMin;

  String stationCode;
  String stationName;
  int stdMin;
  bool stop;

  int sta;
  int todaySta;

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        dDay: json["d_day"],
        day: json["day"],
        distanceFromSource: json["distance_from_source"],
        platformNumber: json["platform_number"],
        staMin: json["sta_min"],
        stationCode: json["station_code"],
        stationName: json["station_name"],
        stdMin: json["std_min"],
        stop: json["stop"],
        sta: json["sta"],
        todaySta: json["today_sta"],
      );

  Map<String, dynamic> toJson() => {
        "d_day": dDay,
        "day": day,
        "distance_from_source": distanceFromSource,
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
        "platform_number": platformNumber,
        "sta_min": staMin,
        "station_code": stationCode,
        "station_name": stationName,
        "std_min": stdMin,
        "stop": stop,
        "sta": sta,
        "today_sta": todaySta,
      };
}

Future<Schedule> getSchedule() async {
  final response2 = await http.get(
    Uri.parse(
        'https://irctc1.p.rapidapi.com/api/v1/getTrainSchedule?trainNo=$train_number'),
    headers: {
      'X-RapidAPI-Key': 'd88ac8db63mshfe87f7dbcde4865p1eda07jsn7f1da97e9ef8',
      'X-RapidAPI-Host': 'irctc1.p.rapidapi.com'
    },
  );
  return Schedule.fromJson(jsonDecode(response2.body));
}
