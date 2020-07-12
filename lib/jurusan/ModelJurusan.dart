import 'package:firebase_database/firebase_database.dart';

class Jurusan {
  final String key;
  String name;
  bool completed;

  Jurusan({this.key, this.name, this.completed});

  Jurusan.fromSnapshot(DataSnapshot snapshot)
         : key = snapshot.key,
  name = snapshot.value['name'],
  completed = snapshot.value['completed'];

  Map<String, dynamic> toJson(){
    return{"name": name, "completed": completed};
  }



}