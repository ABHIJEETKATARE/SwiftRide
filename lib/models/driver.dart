// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:internshala_assignment/models/location.dart';
import 'package:internshala_assignment/models/rating.dart';

class Driver {
  final String name;
  final String carModel;
  final String? id;
  final double? rating;
  final Location? location;
  final bool? availability;

  Driver(
      {required this.name,
      required this.carModel,
      required this.id,
      required this.rating,
      required this.location,
      required this.availability});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'carModel': carModel,
      'id': id,
      'rating': rating,
      'location': location?.toMap(),
      'availability': availability,
    };
  }

  factory Driver.fromMap(Map<String, dynamic> map) {
    return Driver(
      name: map['name'] != null ? map['name'] as String : "",
      carModel: map['carModel'] != null ? map['carModel'] as String : "",
      id: map['_id'] != null ? map['_id'] as String : "",
      rating: map['rating'] != null ? map['rating'] as double : 0,
      location: map['location'] != null
          ? Location.fromMap(map['location'] as Map<String, dynamic>)
          : Location(latitude: 0, longitude: 0),
      availability:
          map['availability'] != null ? map['availability'] as bool : false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Driver.fromJson(String source) =>
      Driver.fromMap(json.decode(source) as Map<String, dynamic>);
}
