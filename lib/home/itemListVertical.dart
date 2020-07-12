import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:campusapp/constant/ConstantFile.dart';
import 'package:campusapp/model/ModelNews.dart';
import 'package:campusapp/network/NetworkProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class itemListVertical extends StatefulWidget {
  List list;
  itemListVertical({this.list});
  @override
  _itemListVerticalState createState() => _itemListVerticalState();
}

class _itemListVerticalState extends State<itemListVertical> {
  BaseEndPoint network = NetworkProvider();
  var dateFormat;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.list.length,
      itemBuilder: (BuildContext context, int index) {
        Article data = widget.list[index];
        dateFormat = DateFormat("dd-MM-yyyy").format(data.dateNews);
        return Padding(
          padding: const EdgeInsets.only(left: 16, right: 2, bottom: 8, top: 10),
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 120,
                      width: 120,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            ConstantFile().imageUrl + data.imageNews,
                            fit: BoxFit.fill,
                          )),
                    ),
                    Flexible(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                          Text(
                                data.titleNews,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                                maxLines: 2,
                              ),
                            Text(data.descriptionNews,
                            style: TextStyle(fontSize: 14), softWrap: true, maxLines: 3,),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.access_time),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(dateFormat),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "| PNP",
                                        style: TextStyle(color: Colors.red),
                                      )
                                    ],
                                  ),
                                ]),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Divider(
                color: Colors.pink,
                height: 1,
                thickness: 2,
              ),
            ],
          ),
        );
      },
    );
  }
}
