import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:internshala_assignment/global_data/customization_data/customizing_data.dart';
import 'package:internshala_assignment/http_error_handling/error_handling.dart';
import 'package:internshala_assignment/models/booking.dart';
import 'package:internshala_assignment/models/location.dart';
import 'package:internshala_assignment/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:internshala_assignment/providers/user_provider.dart';
import 'package:internshala_assignment/widgets/snackbar.dart';
import 'package:provider/provider.dart';

class RideBookingService {
  void bookRide({
    required BuildContext context,
    required User user,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse("$uri/api/book-ride/"),
          headers: <String, String>{
            'Content-Type': "application/json; charset=UTF-8",
            'x-auth-token': userProvider.user.token
          },
          body: json.encode({'id': userProvider.user.id}));
      Booking userBookedRide =
          Booking(status: "failure", estimatedArrivalTime: "");
      httpErrorHandle(
          response: res,
          onSuccess: () {
            userBookedRide = Booking.fromJson(res.body);
          },
          context: context);
      if (userBookedRide.status == 'success') {
        showSnackBar(
            context: context,
            message:
                "Booking Successful\nDrivers Name:${userBookedRide.driver!.name}\n Car Model:${userBookedRide.driver!.carModel}\n Rating:${userBookedRide.driver!.rating}\n location:${userBookedRide.driver!.location!.latitude} ${userBookedRide.driver!.location!.longitude}");
      }
    } catch (e) {
      showSnackBar(context: context, message: e.toString());
    }
  }
}
