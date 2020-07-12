import 'package:campusapp/home/itemListHorizontal.dart';
import 'package:campusapp/home/itemListVertical.dart';
import 'package:campusapp/network/NetworkProvider.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BaseEndPoint network = NetworkProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Container(
                  height: 250,
                  child: Carousel(
                    autoplay: true,
                    images: [
                      AssetImage('images/adm.jpg'),
                      AssetImage('images/akun.jpg'),
                      AssetImage('images/bi.jpg'),
                      AssetImage('images/elektro.jpg'),
                      AssetImage('images/mesin.jpg'),
                      AssetImage('images/sipil.jpg'),
                      AssetImage('images/ti.jpg'),
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(color: Colors.pink,
            height: 1,
            thickness: 2,),
          FutureBuilder(
            future: network.getNews(""),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? itemListVertical(
                list: snapshot.data,
              )
                  : Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }
}
