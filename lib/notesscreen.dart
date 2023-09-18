import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notesp/addnotes.dart';
import 'package:notesp/working.dart';
import 'package:shared_preferences/shared_preferences.dart';

class notesscreen extends StatefulWidget {
  const notesscreen({super.key});

  @override
  State<notesscreen> createState() => _notesscreenState();
}

class _notesscreenState extends State<notesscreen> {
  List<Notes> list = [];
  late SharedPreferences sharedPreferences;

  getData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    List<String>? stringList = sharedPreferences.getStringList("list");

    if (stringList != null) {
      list =
          stringList.map((item) => Notes.fromMap(json.decode(item))).toList();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
            child: Text(
          "Notes Screen",
        )),
      ),
      body: list.isEmpty
          ? Center(
              child: Text("Empty"),
            )
          : ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text("$index"),
                  ),
                  title: Text(list[index].title),
                  subtitle: Text(list[index].description),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete_forever_outlined,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        list.remove(list[index]);
                        List<String> stringList = list
                            .map((item) => json.encode(item.toMap()))
                            .toList();
                        sharedPreferences.setStringList("list", stringList);
                      });
                    },
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
        onPressed: () async {
          String refresh = await Navigator.push(
              context, MaterialPageRoute(builder: (context) => addnotes()));

          if (refresh == "LoadData") {
            setState(() {
              getData();
            });
          }
        },
      ),
    );
  }
}
