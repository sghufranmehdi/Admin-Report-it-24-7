import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:report_247/Screens/main_screen.dart';
import 'package:report_247/units/colors.dart';
import 'package:report_247/units/styles.dart';

class MakeProfile extends StatefulWidget {
  const MakeProfile({Key? key}) : super(key: key);

  @override
  _MakeProfileState createState() => _MakeProfileState();
}

class _MakeProfileState extends State<MakeProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  final postRef = FirebaseFirestore.instance.collection('Profile');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  User? user = FirebaseAuth.instance.currentUser;

  void setData() async {
    dynamic time = DateFormat('yyyy-MM-dd hh:mm:ss:S').format(DateTime.now());

    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref('Images / $time');
    UploadTask uploadTask = ref.putFile(image!);
    await Future.value(uploadTask);
    var imageUrl = await ref.getDownloadURL();
    try {
      postRef.add({
        'Name': nameController.text,
        'Username': usernameController.text,
        'Number': numberController.text,
        'Image': imageUrl,
        'Email': user!.email,
        'Uid': user!.uid,
      }).then((value) {});
    } catch (e) {
      print(e);
    }
  }

  File? image;
  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(
      source: source,
      imageQuality: 50,
    );
    if (image != null) {
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: Text(
                      '  Edit Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: alphaColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            border: Border.all(width: 4, color: alphaColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, 0))
                            ],
                            shape: BoxShape.circle,
                            image: image == null
                                ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('Images/camera1.png'))
                                : DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(image!.absolute)),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color: Colors.white,
                                ),
                                color: alphaColor,
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.camera_enhance,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      // return object of type Dialog
                                      return AlertDialog(
                                          content: Container(
                                        height: 115,
                                        child: Column(
                                          children: [
                                            TextButton(
                                                onPressed: () {
                                                  pickImage(ImageSource.camera)
                                                      .then((value) {
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: Text(
                                                  'Camera',
                                                  style: TextStyle(
                                                      color: Color(0xff9f7d24)),
                                                )),
                                            Divider(),
                                            TextButton(
                                                onPressed: () {
                                                  pickImage(ImageSource.gallery)
                                                      .then((value) {
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: Text('Gallery',
                                                    style: TextStyle(
                                                        color: Color(
                                                            0xff9f7d24)))),
                                          ],
                                        ),
                                      ));
                                    },
                                  );
                                },
                              ),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 35.0,
                      left: 20.0,
                      right: 20.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: nameController,
                          validator: (username) {
                            if (username == null || username.isEmpty) {
                              return 'Required';
                            }
                          },
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          cursorColor: alphaColor,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff9f7d24)),
                            ),
                            labelText: 'NAME',
                            labelStyle: kLabelText,
                          ),
                          autofocus: false,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: usernameController,
                          validator: (username) {
                            if (username == null || username.isEmpty) {
                              return 'Required';
                            } else if (username.length <= 5) {
                              return 'username too short';
                            }
                          },
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          cursorColor: alphaColor,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff9f7d24)),
                            ),
                            labelText: 'USERNAME',
                            labelStyle: kLabelText,
                          ),
                          autofocus: false,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: numberController,
                          validator: (number) {
                            if (number == null || number.isEmpty) {
                              return 'Required';
                            } else if (number.length != 11) {
                              return 'Number must be contain 11 digits';
                            }
                          },
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          cursorColor: alphaColor,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff9f7d24)),
                            ),
                            labelText: 'PHONE NUMBER',
                            labelStyle: kLabelText,
                          ),
                          autofocus: false,
                        ),
                        SizedBox(
                          height: 60.0,
                        ),
                        Container(
                          height: 50.0,
                          width: 280,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: alphaColor,
                            shadowColor: Colors.white,
                            elevation: 5.0,
                            child: GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  setData();
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => MainScreen()));
                                }
                              },
                              child: Center(
                                child: Text(
                                  'NEXT',
                                  style: kLoginSignUpButton,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
