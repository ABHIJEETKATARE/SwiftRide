// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class Rating {
  final double rating;
  final String userId;
  Rating({required this.userId, required this.rating});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rating': rating,
      'userId': userId,
    };
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      rating: map['rating']?.toDouble() ?? 0.0,
      userId: map['userId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Rating.fromJson(String source) =>
      Rating.fromMap(json.decode(source) as Map<String, dynamic>);
}
