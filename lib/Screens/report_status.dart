import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:report_247/Screens/1122%20Report%20Screen/r_active_report_screen.dart';
import 'package:report_247/Screens/1122%20Report%20Screen/r_all_report_screen.dart';
import 'package:report_247/Screens/1122%20Report%20Screen/r_close_report_screen.dart';
import 'package:report_247/Screens/1122%20Report%20Screen/r_instant_report_screen.dart';
import 'package:report_247/Screens/1122%20Report%20Screen/r_pending_reports_screen.dart';
import 'package:report_247/Screens/Other%20Report%20Screen/o_active_report_screen.dart';
import 'package:report_247/Screens/Other%20Report%20Screen/o_all_report_screen.dart';
import 'package:report_247/Screens/Other%20Report%20Screen/o_close_report_screen_.dart';
import 'package:report_247/Screens/Other%20Report%20Screen/o_instant_report_screen.dart';
import 'package:report_247/Screens/Other%20Report%20Screen/o_pending_report_screen.dart';
import 'package:report_247/Screens/Police%20Reports%20Screen/instant_report_screen.dart';
import 'package:report_247/Screens/Police%20Reports%20Screen/pAllReports.dart';
import 'package:report_247/Screens/Police%20Reports%20Screen/p_active_report_screen.dart';
import 'package:report_247/Screens/Police%20Reports%20Screen/p_close_report_screen.dart';
import 'package:report_247/Screens/Police%20Reports%20Screen/p_pending_report_screen.dart';
import 'package:report_247/Screens/active_reports.dart';
import 'package:report_247/Screens/all_instant_report_screen.dart';
import 'package:report_247/Screens/all_reports.dart';
import 'package:report_247/Screens/close_reports.dart';
import 'package:report_247/Screens/pending_reports.dart';
import 'package:report_247/Widget/appbar.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  final titles = [
    "All Reports",
    "Active Reports",
    "Pending Report",
    "Close Report",
    "Instant Report"
  ];
  final screens = [
    AllReportScreen(),
    ActiveReportScreen(),
    PendingReportScreen(),
    CloseReportScreen(),
    SInstantReportScreen(),
  ];
  final police = [
    PAllReportScreen(),
    PActiveReportScreen(),
    PPendingReportScreen(),
    PCloseReportScreen(),
    PInstantReportScreen()
  ];
  final rescue = [
    RAllReportScreen(),
    RActiveReportScreen(),
    RPendingReportScreen(),
    RCloseReportScreen(),
    RInstantReportScreen(),
  ];
  final others = [
    OAllReportScreen(),
    OActiveReportScreen(),
    OPendingReportScreen(),
    OCloseReportScreen(),
    OInstantReportScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context),
      body: ListView.builder(
          itemCount: titles.length,
          itemBuilder: (context, index) {
            return Container(
              height: 100,
              child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Center(
                    child: ListTile(
                      onTap: () {
                        if (_auth.currentUser!.email == 'police@email.com') {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => police[index]));
                        } else if (_auth.currentUser!.email ==
                            '1122@email.com') {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => rescue[index]));
                        } else if (_auth.currentUser!.email ==
                            'others@email.com') {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => others[index]));
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => screens[index]));
                        }
                      },
                      title: Text(
                        titles[index],
                        style: TextStyle(fontSize: 20),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(
                          'Images/splh.png',
                        ),
                      ),
                    ),
                  )),
            );
          }),
    );
  }
}
