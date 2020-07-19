import 'package:campusapp/jurusan/ListJurusan.dart';
import 'package:campusapp/network/NetworkProvider.dart';
import 'package:campusapp/profile/ProfilePage.dart';
import 'file:///D:/FlutterProject/campus_app/lib/home/HomePage.dart';
import 'package:campusapp/screen/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _signOut() async {
    await _googleSignIn.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  BaseEndPoint network = NetworkProvider();
  int _selectedIndex = 0;
  onSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  var listPage = [HomeScreen(), ProfilePage(), ListJurusan()];

  final _bottomNavItem = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('Home'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text('Profile'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.list),
      title: Text('List'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.red,
                size: 30,
              ),
              onPressed: () {
                _signOut();
              }),
        ],
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 4, right: 4),
                alignment: Alignment.center,
                height: 25,
                width: 25,
                color: Colors.red,
                child: Text(
                  'P',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 4, right: 4),
                alignment: Alignment.center,
                height: 25,
                width: 25,
                color: Colors.red,
                child: Text(
                  'N',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 4, right: 4),
                alignment: Alignment.center,
                height: 25,
                width: 25,
                color: Colors.red,
                child: Text(
                  'P',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Text(
                'APPS',
                style: TextStyle(
                    color: Colors.deepOrange, letterSpacing: 3, fontSize: 26),
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: listPage[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.deepOrange,
        items: _bottomNavItem,
        currentIndex: _selectedIndex,
        onTap: onSelected,
      ),
    );
  }
}
