import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:report_247/units/colors.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

AppBar header(
  context,
) {
  return AppBar(
    automaticallyImplyLeading: true,
    // centerTitle: true,
    backgroundColor: alphaColor,

    title: Text(
      'ReportIt247',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
