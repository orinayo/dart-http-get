import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(new MaterialApp(
      home: new HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = "https://swapi.dev/api/people";
  List data;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http.get(
        // Encode the URL
        Uri.encodeFull(url),
        // Only accept json respons
        headers: {"Accept": "application/json"});

    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data = convertDataToJson['results'];
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Retrieve JSON via HTTP Get"),
        ),
        body: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return new Container(
                child: new Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Card(
                      child: new Container(
                          child: new Text(data[index]['name']),
                          padding: const EdgeInsets.all(20.0)))
                ],
              ),
            ));
          },
        ));
  }
}
