import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/Pojo.dart';
import 'package:http/http.dart' as http;

/*
* https://medium.com/@DakshHub/flutter-displaying-dynamic-contents-using-listview-builder-f2cedb1a19fb
* */


Future<List<Pojo>> fetchPost() async {
  final response =
  await http.get('https://jsonplaceholder.typicode.com/users');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Pojo.fromJsonList(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Test extends StatelessWidget {
  List<Pojo> data;
  Test(this.data);

  void onCardTapped(int index) {
    Fluttertoast.showToast(
        msg: "Clicked $index",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Card(
            child: Text(data[index].name),
          ),
          onTap: () => onCardTapped(index)
        );
      });
  }
}

void main() => runApp(MyApp(post: fetchPost()));

class MyApp extends StatelessWidget {
  final Future<List<Pojo>> post;

  MyApp({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Rest api'),
        ),
        body: Center(
          child: FutureBuilder<List<Pojo>>(
            future: post,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Test(snapshot.data);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}