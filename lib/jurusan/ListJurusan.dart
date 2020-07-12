import 'dart:async';
import 'package:campusapp/jurusan/ModelJurusan.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ListJurusan extends StatefulWidget {
  @override
  _ListJurusanState createState() => _ListJurusanState();
}

class _ListJurusanState extends State<ListJurusan> {
  List<Jurusan> _jurList = List();
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  DatabaseReference _jurRef;

  final _jurController = TextEditingController();
  StreamSubscription<Event> _onJurAddedSubscription;
  StreamSubscription<Event> _onJurChangedSubscription;

  @override
  void initState() {
    // TODO: implement initState
    _jurRef = _database.reference().child("jurs");
    _onJurAddedSubscription = _jurRef.onChildAdded.listen(_onNewJur);
    _onJurChangedSubscription = _jurRef.onChildChanged.listen(_onChangedJur);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onJurAddedSubscription.cancel();
    _onJurChangedSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange  ,
      body: Container(
        child: _showJurList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialogJurForm();
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.deepOrange,
      ),
    );
  }

  //FORM
  Widget _showJurList() {
    if (_jurList.length > 0) {
      return ListView.builder(
          itemCount: _jurList.length,
          itemBuilder: (context, index) {
            Jurusan jurusan = _jurList[index];
            return Dismissible(
              key: Key(jurusan.key),
              background: Container(
                color: Colors.blue,
              ),
              onDismissed: (direction) async {
                _deleteJur(jurusan.key, index);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
                child: Card(
                  child: ListTile(
                    title: Text(
                      jurusan.name,
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    trailing: IconButton(
                      icon: (jurusan.completed)
                          ? Icon(
                              Icons.done_outline,
                              color: Colors.green,
                              size: 20.0,
                            )
                          : Icon(
                              Icons.done,
                              color: Colors.grey,
                              size: 20,
                            ),
                      onPressed: () {
                        _updateJur(jurusan);
                      },
                    ),
                  ),
                ),
              ),
            );
          });
    } else {
      return Center(
        child: Text('Empty', style: TextStyle(color: Colors.white),),
      );
    }
  }

  void _showDialogJurForm() {
    _jurController.clear();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _jurController,
                    autocorrect: true,
                    decoration: InputDecoration(labelText: 'Add Jurusan'),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              FlatButton(
                onPressed: () {
                  _addJur(_jurController.text);
                  Navigator.pop(context);
                },
                child: Text('Save'),
              )
            ],
          );
        });
  }

  //listeners
  void _onNewJur(Event event) {
    setState(() {
      _jurList.add(Jurusan.fromSnapshot(event.snapshot));
    });
  }

  void _onChangedJur(Event event) {
    var oldEntry = _jurList.singleWhere((jurusan) {
      return jurusan.key == event.snapshot.key;
    });
    setState(() {
      _jurList[_jurList.indexOf(oldEntry)] =
          Jurusan.fromSnapshot(event.snapshot);
    });
  }

  //CRUD
  Future<void> _addJur(String jurName) async {
    if (jurName.length > 0) {
      Jurusan jurusan = Jurusan(name: jurName, completed: false);

      await _jurRef.push().set(jurusan.toJson());
    }
  }

  Future<void> _deleteJur(String key, int index) async {
    await _jurRef.child(key).remove();
    setState(() {
      _jurList.removeAt(index);
    });
  }

  Future<void> _updateJur(Jurusan jurusan) async {
    jurusan.completed = !jurusan.completed;
    await _jurRef.child(jurusan.key).set(jurusan.toJson());
  }
}
