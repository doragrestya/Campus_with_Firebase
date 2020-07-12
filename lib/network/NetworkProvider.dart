import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:campusapp/DashboardPage.dart';
import 'package:campusapp/constant/ConstantFile.dart';
import 'package:campusapp/model/ModelNews.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class BaseEndPoint {
  Future<List> getNews(String myId);
}

class NetworkProvider extends BaseEndPoint {
  @override
  Future<List> getNews(String id) async{
    // TODO: implement getNews
    final response = await http.post(ConstantFile().baseUrl + "getNews", body: {
      'iduser' : id
    });

    ModelNews listData = modelNewsFromJson(response.body);

    return listData.article;
  }


}