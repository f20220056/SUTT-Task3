import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:sutt_task2/home_page.dart';

class Train {
  Train({
    required this.status,
    required this.message,
    required this.timestamp,
    required this.data,
  });

  bool status;
  String message;
  int timestamp;
  List<Details> data;

  factory Train.fromJson(Map<String, dynamic> json) => Train(
        status: json["status"],
        message: json["message"],
        timestamp: json["timestamp"],
        data: List<Details>.from(json["data"].map((x) => Details.fromJson(x))),
      );
  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "timestamp": timestamp,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Details {
  Details({
    required this.trainNumber,
    required this.trainName,
    required this.trainType,
    required this.runDays,
    required this.trainOriginStation,
    required this.trainOriginStationCode,
    required this.trainDestinationStation,
    required this.trainDestinationStationCode,
    required this.departTime,
    required this.arrivalTime,
    required this.distance,
    required this.classType,
    required this.dayOfJourney,
  });

  String trainNumber;
  String trainName;
  String trainType;
  List<String> runDays;
  String trainOriginStation;

  String trainOriginStationCode;
  String trainDestinationStation;
  String trainDestinationStationCode;
  String departTime;
  String arrivalTime;
  String distance;
  List<String> classType;
  int dayOfJourney;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        trainNumber: json["train_number"],
        trainName: json["train_name"],
        trainType: json["train_type"],
        runDays: List<String>.from(json["run_days"].map((x) => x)),
        trainOriginStation: json["train_origin_station"],
        trainOriginStationCode: json["train_origin_station_code"],
        trainDestinationStation: json["train_destination_station"],
        trainDestinationStationCode: json["train_destination_station_code"],
        departTime: json["depart_time"],
        arrivalTime: json["arrival_time"],
        distance: json["distance"],
        classType: List<String>.from(json["class_type"].map((x) => x)),
        dayOfJourney: json["day_of_journey"],
      );

  Map<String, dynamic> toJson() => {
        "train_number": trainNumber,
        "train_name": trainName,
        "train_type": trainType,
        "run_days": List<dynamic>.from(runDays.map((x) => x)),
        "train_origin_station": trainOriginStation,
        "train_origin_station_code": trainOriginStationCode,
        "train_destination_station": trainDestinationStation,
        "train_destination_station_code": trainDestinationStationCode,
        "depart_time": departTime,
        "arrival_time": arrivalTime,
        "distance": distance,
        "class_type": List<dynamic>.from(classType.map((x) => x)),
        "day_of_journey": dayOfJourney,
      };
}

Future<Train> getTrain() async {
    final response = await http.get(
        Uri.parse(
            'https://irctc1.p.rapidapi.com/api/v2/trainBetweenStations?fromStationCode=$from&toStationCode=$to'),
        headers: {
          'X-RapidAPI-Key':
              'd88ac8db63mshfe87f7dbcde4865p1eda07jsn7f1da97e9ef8',
          'X-RapidAPI-Host': 'irctc1.p.rapidapi.com'
        });
    return Train.fromJson(jsonDecode(response.body));
  }

