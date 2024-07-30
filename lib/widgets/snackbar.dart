import 'package:flutter/material.dart';

void showSnackBar({required context, required message}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
