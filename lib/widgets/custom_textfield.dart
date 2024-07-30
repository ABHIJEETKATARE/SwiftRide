import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxilines;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.maxilines = 1});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxilines,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your $hintText";
        }

        return null;
      },
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                // style: BorderStyle.solid,
                // width: 50,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black, //style: BorderStyle.solid, width: 5
          ))),
    );
  }
}
