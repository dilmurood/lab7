import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lab_7/users_model.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  //place the url
  get url_ => 'https://randomuser.me/api/?results=20';

  //save the users from url to users list
  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('List of users'),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Card(
              color: Colors.amberAccent,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.pictureURL,
                      scale: 1.0), // Load image from the URL
                ),
                title: Text(
                  '${user.firstName} ${user.lastName}',
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(user.email),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          fetch();
        },
        hoverColor: Colors.blue,
      ),
    );
  }

  void fetch() async {
    final uri = Uri.parse(url_);
    final response = await http.get(uri);

    //if successfull
    if (response.statusCode == 200) {
      //print(body);

      final json_data = jsonDecode(response.body);

      final results = json_data['results'] as List<dynamic>;
      final converted = results.map((user) => Users.fromJson(user)).toList();

      setState(() {
        users = converted;
      });
    }
  }
}
