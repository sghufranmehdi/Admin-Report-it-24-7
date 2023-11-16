import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:report_247/Screens/1122%20Report%20Screen/r_evidence_screen.dart';
import 'package:report_247/Screens/Other%20Report%20Screen/o_evidence_screen.dart';
import 'package:report_247/Screens/Police%20Reports%20Screen/p_evidence_screen.dart';
import 'package:report_247/Screens/evidence_screen.dart';
import 'package:report_247/Screens/report_status.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  final titles = [
    "Report",
    "Evidence",
  ];
  final screens = [
    ReportsScreen(),
    EvidenceScreen(),
  ];
  final police = [
    ReportsScreen(),
    PEvidenceScreen(),
  ];
  final rescue = [
    ReportsScreen(),
    REvidenceScreen(),
  ];
  final others = [
    ReportsScreen(),
    OEvidenceScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                      } else if (_auth.currentUser!.email == '1122@email.com') {
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
        });
  }
}
