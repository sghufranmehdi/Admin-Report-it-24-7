import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final user = FirebaseAuth.instance.currentUser;

// Main theme
// const alphaColor = Color(0xff3ea339);
final alphaColor = user!.email == 'sadmin@email.com'
    ? Color(0xff3ea339)
    : user!.email == 'police@email.com'
        ? Color(0xff08068f)
        : user!.email == '1122@email.com'
            ? Colors.lightGreen
            : Colors.red;

// Splash Screen
const gammaColor = Colors.white;
