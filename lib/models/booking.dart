// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:internshala_assignment/models/driver.dart';

class Booking {
  final String status;
  final String estimatedArrivalTime;
  final String? rideId;
  final Driver? driver;

  Booking(
      {required this.status,
      required this.estimatedArrivalTime,
      this.rideId,
      this.driver});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'estimatedArrivalTime': estimatedArrivalTime,
      'rideId': rideId,
      'driver': driver?.toMap(),
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      status: map['status'] as String,
      estimatedArrivalTime: map['estimatedArrivalTime'] as String,
      rideId: map['_id'] != null ? map['rideId'] as String : null,
      driver: map['driver'] != null
          ? Driver.fromMap(map['driver'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source) =>
      Booking.fromMap(json.decode(source) as Map<String, dynamic>);
}
