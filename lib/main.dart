import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  Map _data = await getJSON();

  runApp(
      MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Quakes"),
              backgroundColor: Colors.redAccent,
            ),
            body: ListView.builder(
                padding: EdgeInsets.all(8.0),
                itemCount: _data["features"].length,
                itemBuilder: (BuildContext context, int position) {
                  return Column(
                    children: <Widget>[
                      Divider(height: 3.4),
                      ListTile(
                        title: Text(_data["features"][position]["properties"]["title"],
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        subtitle: Text(_data["features"][position]["properties"]["place"]),
                        leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.lightGreenAccent,
                            child: Text(_data["features"][position]["properties"]["mag"].toString())
                        ),

                        onTap: () => showTapMessage(context, _data["features"][position]["properties"]["place"]),
                      )
                    ],
                  );
                }
            ),
          )
      )
  );
}

void showTapMessage(BuildContext context, message) {
  var alertDialog = AlertDialog(
    title: Text(message),
    actions: <Widget>[
      FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("OK")
      )
    ],
  );

  showDialog(context: context, builder: (context) {
    return alertDialog;
  });
}

Future<Map> getJSON() async {
  String apiUrl = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson";

  http.Response response = await http.get(apiUrl);

  return jsonDecode(response.body);
}