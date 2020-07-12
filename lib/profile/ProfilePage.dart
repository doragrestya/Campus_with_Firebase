import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final LatLng poli = LatLng(-0.9137822, 100.4640162);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(children: <Widget>[
          MyMap(
            poli: poli,
            title: 'Politeknik Negeri Padang',
          )
        ]),
      ),
    );
  }
}

class MyMap extends StatelessWidget {
  const MyMap({Key key, @required this.poli, this.title}) : super(key: key);
  final LatLng poli;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 100),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Image.asset('images/poli.jpg', width: MediaQuery.of(context).size.width, height: 250,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text('Visi :', style: TextStyle(fontSize: 15, color: Colors.deepOrange),),
            ),
            Text('“Pada tahun 2025 Menjadi institusi pendidikan vokasional terbaik di Asia Tenggara, bermartabat, dan berwawasan internasional.”', textAlign: TextAlign.justify,),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text('Misi :', style: TextStyle(fontSize: 15, color: Colors.deepOrange),),
            ),
            Text('1. Menyelenggarakan pendidikan vokasional yang sesuai dengan perkembangan ilmu pengetahuan dan teknologi yang berwawasan internasioanal;', textAlign: TextAlign.justify,),
            Text('2. Menyelenggarakan penelitian yang inovatif dan adaptif untuk pengembangan ilmu pengetahuan dan teknologi;', textAlign: TextAlign.justify,),
            Text('3. Menerapkan ilmu pengetahuan dan teknologi dalam rangka memecahkan masalah dan meningkatkan taraf hidup masyarakat;', textAlign: TextAlign.justify,),
            Text('4. Menjalin kerjasama yang produktif dan berkelanjutan dengan lembaga pendidikan, pemerintah, dan dunia usaha ditingkat nasional dan internasional.', textAlign: TextAlign.justify,),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                'Lokasi Kampus',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange),
              ),
            ),
           Padding(
             padding: const EdgeInsets.only(top: 10),
             child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 350,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: poli,
                      zoom: 11.0,
                    ),
                    markers: Set<Marker>.of(
                      <Marker>[
                        Marker(
                            markerId: MarkerId(title),
                            position: poli,
                            infoWindow:
                                InfoWindow(title: 'Politeknik Negeri Padang'))
                      ].toSet(),
                    ),
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                      Factory<OneSequenceGestureRecognizer>(
                        () => ScaleGestureRecognizer(),
                      )
                    ].toSet(),
                  ),
                ),
           ),
          ],
        ),
    );
  }
}
