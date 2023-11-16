import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:report_247/Widget/appbar.dart';
import 'package:report_247/units/colors.dart';

class RActiveReportScreen extends StatefulWidget {
  const RActiveReportScreen({Key? key}) : super(key: key);

  @override
  _RActiveReportScreenState createState() => _RActiveReportScreenState();
}

class _RActiveReportScreenState extends State<RActiveReportScreen> {
  final postRef = FirebaseFirestore.instance
      .collection('Reports')
      .where('Submit to', isEqualTo: 'Rescue 1122')
      .where('Status', isEqualTo: 'Active');
  final FirebaseAuth auth = FirebaseAuth.instance;

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
                                // height: 400,
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
                                        Container(
                                          child: Text(data['Status']),
                                        ),
                                        // GestureDetector(
                                        //   onTap: () {
                                        //     showDialog(
                                        //         context: context,
                                        //         builder:
                                        //             (BuildContext context) {
                                        //           // return object of type Dialog
                                        //           return AlertDialog(
                                        //               content: Container(
                                        //             child: Column(
                                        //               mainAxisSize:
                                        //                   MainAxisSize.min,
                                        //               children: [
                                        //                 Text('Select'),
                                        //                 SizedBox(height: 10),
                                        //                 DropdownButton(
                                        //                   hint: Text(
                                        //                       'Please choose '), // Not necessary for Option 1
                                        //                   value:
                                        //                       _selectedDepartment,
                                        //                   onChanged:
                                        //                       (newValue) {
                                        //                     setState(() {
                                        //                       _selectedDepartment =
                                        //                           newValue
                                        //                               as String?;
                                        //                       // nameController.text = _selectedLocation!;
                                        //                       print(
                                        //                           _selectedDepartment);
                                        //                     });
                                        //                   },
                                        //                   items: _locations
                                        //                       .map(
                                        //                           (location) {
                                        //                     return DropdownMenuItem(
                                        //                       child: new Text(
                                        //                         location,
                                        //                         style: TextStyle(
                                        //                             color: Colors
                                        //                                 .black87),
                                        //                       ),
                                        //                       value: location,
                                        //                     );
                                        //                   }).toList(),
                                        //                 ),
                                        //                 SizedBox(height: 10),
                                        //                 ElevatedButton(
                                        //                     onPressed:
                                        //                         () async {
                                        //                       await postRef
                                        //                           .doc(data[
                                        //                               "id"])
                                        //                           .update({
                                        //                         'Status':
                                        //                             _selectedDepartment
                                        //                       }).then((value) {
                                        //                         Navigator.pop(
                                        //                             context);
                                        //                       });
                                        //                     },
                                        //                     child: Text(
                                        //                         'UPDATE'))
                                        //               ],
                                        //             ),
                                        //           ));
                                        //         });
                                        //   },
                                        //   child: Text(data['Status']),
                                        // )
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
                  ]
                      ),
                );
              }).toList(),
            );
          }),
    );
  }
}
