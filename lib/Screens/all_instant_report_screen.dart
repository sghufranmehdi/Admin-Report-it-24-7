import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:report_247/Widget/appbar.dart';
import 'package:report_247/units/colors.dart';

class SInstantReportScreen extends StatefulWidget {
  const SInstantReportScreen({Key? key}) : super(key: key);

  @override
  _SInstantReportScreenState createState() => _SInstantReportScreenState();
}

class _SInstantReportScreenState extends State<SInstantReportScreen> {
  final postRef = FirebaseFirestore.instance.collection('Instant Reports');
  final FirebaseAuth auth = FirebaseAuth.instance;

  AudioPlayer? audioPlayer;
  // late FlutterAudioRecorder2 _audioRecorder;
  //
  // void initState() {
  //   _startPlaying();
  // }
  //
  // Future<void> _startPlaying() async {
  //   final bool? hasRecordingPermission =
  //       await FlutterAudioRecorder2.hasPermissions;
  //
  //   if (hasRecordingPermission ?? false) {
  //     Directory directory = await getApplicationDocumentsDirectory();
  //     String filepath = directory.path +
  //         '/' +
  //         DateTime.now().millisecondsSinceEpoch.toString() +
  //         '.aac';
  //     _audioRecorder =
  //         FlutterAudioRecorder2(filepath, audioFormat: AudioFormat.AAC);
  //     await _audioRecorder.initialized;
  //     // _audioRecorder.start();
  //     // _audioRecorder.start();
  //     // _filePath = filepath;
  //     setState(() {});
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Center(child: Text('Please enable recording permission'))));
  //   }
  // }

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
                                              'Submited: ',
                                              style: TextStyle(
                                                color: alphaColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                data['Submit to'] ??
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
                                        SizedBox(
                                          height: 5,
                                        ),
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
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              child: ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.only(
                                                      left: 8, top: 5, bottom: 5),
                                                  side: BorderSide(
                                                    color: Colors.orange,
                                                    width: 3.0,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(10),
                                                  ),
                                                  primary: Colors.white,
                                                  elevation: 5.0,
                                                ),
                                                onPressed: () async {
                                                  await audioPlayer!
                                                      .play(data['Audio']);
                                                },
                                                icon: Icon(
                                                  Icons.play_arrow,
                                                  color: Colors.red,
                                                  size: 35.0,
                                                ),
                                                label: Text(''),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 50,
                                            ),
                                            Container(
                                              child: ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.only(
                                                      left: 8, top: 5, bottom: 5),
                                                  side: BorderSide(
                                                    color: Colors.orange,
                                                    width: 3.0,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(10),
                                                  ),
                                                  primary: Colors.white,
                                                  elevation: 5.0,
                                                ),
                                                onPressed: () async {
                                                  await audioPlayer!.pause();
                                                },
                                                icon: Icon(
                                                  Icons.pause,
                                                  color: Colors.red,
                                                  size: 35.0,
                                                ),
                                                label: Text(''),
                                              ),
                                            )
                                          ],
                                        )
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
                                            'Submited: ',
                                            style: TextStyle(
                                              color: alphaColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              data['Submit to'] ??
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
                                        height: 5,
                                      ),
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
