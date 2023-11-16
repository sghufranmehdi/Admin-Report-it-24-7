import 'package:flutter/material.dart';
import 'package:report_247/Screens/dashboard_screen.dart';
import 'package:report_247/Screens/login_screen.dart';
import 'package:report_247/Screens/profile_screen.dart';
import 'package:report_247/Service/auth.dart';
import 'package:report_247/units/colors.dart';
import 'package:report_247/units/const.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  var color;
  List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      color = alphaColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: Text(appName),
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              Auth().signOut(context).then((value) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              });
            },
            child: Container(
              padding: EdgeInsets.only(right: 15),
              child: Icon(Icons.logout),
            ),
          )
        ],
      ),
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: alphaColor,
        unselectedItemColor: Colors.black54,
        onTap: _onItemTapped,
      ),
    );
  }
}
