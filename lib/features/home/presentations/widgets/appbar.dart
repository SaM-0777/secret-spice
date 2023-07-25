import 'package:flutter/material.dart';

import 'package:secret_spice/core/constants/colors.dart';


AppBar buildAppbar() {

  return AppBar(
    elevation: 0,
    backgroundColor: kBackground,
    centerTitle: true,
    title: const Text(
      "Secret Spices",
      style: TextStyle(
        color: Color(0XFF000000),
        fontSize: 22.0,
        fontFamily: "Mulish",
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
