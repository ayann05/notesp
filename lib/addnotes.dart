import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notesp/notesscreen.dart';
import 'package:notesp/working.dart';
import 'package:shared_preferences/shared_preferences.dart';

class addnotes extends StatefulWidget {
  const addnotes({super.key});

  @override
  State<addnotes> createState() => _addnotesState();
}

class _addnotesState extends State<addnotes> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

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
        title: Text("Add"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 80),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                margin:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color.fromARGB(
                      255,
                      120,
                      43,
                      197,
                    ),
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    //for the title of the note
                    TextField(
                      controller: title,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        hintText: "Title",
                      ),
                    ),

                    //for the description part of the note app
                    TextField(
                      controller: description,
                      maxLines: 9,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                          hintText: "Description", border: InputBorder.none),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  list.insert(0,
                      Notes(title: title.text, description: description.text));
                  List<String> stringList =
                      list.map((item) => json.encode(item.toMap())).toList();
                  sharedPreferences.setStringList("list", stringList);

                  Navigator.pop(context, "LoadData");
                },
                child: SingleChildScrollView(
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 100),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text("SAVE"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
