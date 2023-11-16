import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:report_247/Screens/all_reports.dart';
import 'package:report_247/Widget/appbar.dart';
import 'package:report_247/units/colors.dart';

class PAllReportScreen extends StatefulWidget {
  const PAllReportScreen({Key? key}) : super(key: key);

  @override
  _PAllReportScreenState createState() => _PAllReportScreenState();
}

class _PAllReportScreenState extends State<PAllReportScreen> {
  final postRef = FirebaseFirestore.instance
      .collection('Reports')
      .where('Submit to', isEqualTo: 'Police Department');
  final FirebaseAuth auth = FirebaseAuth.instance;

  String? _selectedDepartment;
  List<String> _locations = [
    'Active',
    'Pending',
    'Close',
  ];

  @override
  void dispose() {
    feedbackController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context),
      body: StreamBuilder<QuerySnapshot>(
          stream: postRef.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: alphaColor,
                ),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

                return ListTile(
                  title: Column(children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of type Dialog
                            return AlertDialog(
                                content: SingleChildScrollView(
                              child: Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          child: Text(
                                            'Status',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  // return object of type Dialog
                                                  return AlertDialog(
                                                      content: Container(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text('Select'),
                                                        SizedBox(height: 10),
                                                        DropdownButton(
                                                          hint: Text(
                                                              'Please choose '),
                                                          value:
                                                              _selectedDepartment,
                                                          onChanged:
                                                              (newValue) {
                                                            setState(() {
                                                              _selectedDepartment =
                                                                  newValue
                                                                      as String?;
                                                              print(
                                                                  _selectedDepartment);
                                                            });
                                                          },
                                                          items: _locations
                                                              .map((location) {
                                                            return DropdownMenuItem(
                                                              child: new Text(
                                                                location,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black87),
                                                              ),
                                                              value: location,
                                                            );
                                                          }).toList(),
                                                        ),
                                                        SizedBox(height: 10),
                                                        ElevatedButton(
                                                            onPressed:
                                                                () async {
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'Reports')
                                                                  .doc(data[
                                                                      "id"])
                                                                  .update({
                                                                'Status':
                                                                    _selectedDepartment
                                                              }).then((value) {
                                                                Navigator.pop(
                                                                    context);
                                                              });
                                                            },
                                                            child:
                                                                Text('UPDATE'))
                                                      ],
                                                    ),
                                                  ));
                                                });
                                          },
                                          child: Text(data['Status']),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Name: ',
                                          style: TextStyle(
                                            color: alphaColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            data['Name'] ??
                                                'Error Fetching Name...',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Cause: ',
                                          style: TextStyle(
                                            color: alphaColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            data['Department'] ??
                                                'Error Fetching Name...',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Description: ',
                                          style: TextStyle(
                                            color: alphaColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            data['Description'] ??
                                                'Error Fetching Location...',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Location: ',
                                          style: TextStyle(
                                            color: alphaColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            data['Location'] ??
                                                'Error Fetching Location...',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CachedNetworkImage(
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(
                                        color: alphaColor,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          new Icon(Icons.error),
                                      imageUrl: data['Image'] ??
                                          AssetImage('images/add.png'),
                                      fit: BoxFit.scaleDown,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          child: Text(
                                            data['Time'],
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Feedback: ',
                                          style: TextStyle(
                                            color: alphaColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            data['Feedback'] ??
                                                'No Feedback yet',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextField(
                                      controller: feedbackController,
                                      maxLines: 3,
                                      cursorColor: alphaColor,
                                      decoration: new InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: alphaColor, width: 4.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 3.0),
                                        ),
                                        hintText: 'Guides',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: alphaColor,
                                        ),
                                        onPressed: () async {
                                          await FirebaseFirestore.instance
                                              .collection('Reports')
                                              .doc(data['id'])
                                              .set(
                                            {
                                              'Feedback':
                                                  feedbackController.text,
                                            },
                                            SetOptions(merge: true),
                                          ).then((value) {
                                            dispose();
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Text('Add'))
                                  ],
                                ),
                              ),
                            ));
                          },
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: alphaColor.withOpacity(0.9),
                                  spreadRadius: 1,
                                  offset: Offset(0, 5)
                                  // blurRadius: 10,
                                  )
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Name: ',
                                            style: TextStyle(
                                              color: alphaColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              data['Name'] ??
                                                  'Error Fetching Name...',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Cause: ',
                                            style: TextStyle(
                                              color: alphaColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              data['Department'] ??
                                                  'Error Fetching Location...',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Location: ',
                                            style: TextStyle(
                                              color: alphaColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              data['Location'] ??
                                                  'Error Fetching Location...',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            child: Text(
                                              data['Time'],
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Container(
                                            child: data['Status'] == 'Active'
                                                ? Icon(
                                                    Icons.circle,
                                                    color: Colors.green,
                                                  )
                                                : data['Status'] == 'Pending'
                                                    ? Icon(
                                                        Icons
                                                            .hourglass_full_sharp,
                                                        color: Colors.orange,
                                                      )
                                                    : Icon(
                                                        Icons.album_sharp,
                                                        color: Colors.red,
                                                      ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                );
              }).toList(),
            );
          }),
    );
  }
}
