import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:internshala_assignment/widgets/snackbar.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle(
    {required http.Response response,
    required VoidCallback onSuccess,
    required BuildContext context}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(
          context: context, message: json.decode(response.body)["message"]);
      break;
    case 500:
      showSnackBar(
          context: context, message: json.decode(response.body)["error"]);
      break;
    default:
      showSnackBar(context: context, message: (response.body));
      break;
  }
}
