import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:internshala_assignment/global_data/customization_data/customizing_data.dart';
import 'package:internshala_assignment/http_error_handling/error_handling.dart';
import 'package:internshala_assignment/models/driver.dart';
import 'package:internshala_assignment/providers/user_provider.dart';
import 'package:internshala_assignment/widgets/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeService {
  Future<List<Driver>> fetchAllDrivers(BuildContext context) async {
    final List<Driver> drivers = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/get-drivers"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "x-auth-token": userProvider.user.token
        },
      );
      httpErrorHandle(
          response: res,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              drivers
                  .add(Driver.fromJson(jsonEncode((jsonDecode(res.body)[i]))));
            }
          },
          context: context);
    } catch (e) {
      showSnackBar(context: context, message: e.toString());
    }

    return drivers;
  }
}
