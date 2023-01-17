import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp2/savetextpage.dart';
import 'package:intl/intl.dart';
import 'databasehelper.dart';

class TextListPage extends StatefulWidget {
  @override
  _TextListPageState createState() => _TextListPageState();
}

class _TextListPageState extends State<TextListPage> {
  late DatabaseHelper _dbHelper;
  List<Map<String, dynamic>> _texts = [];
  @override
  void initState() {
    super.initState();
    _dbHelper = DatabaseHelper.instance;
    _loadTexts();
  }

  _loadTexts() async {
    final texts = await _dbHelper.queryAll();
    setState(() {
      _texts = texts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text List'),
      ),
      body:


      _texts != null
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _texts.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_texts[index]['text'] ),
                      subtitle: Text(DateFormat("dd-MM-yyyy").format(DateTime.fromMillisecondsSinceEpoch(_texts[index]['tarih'])))
                          ,trailing: Text((_texts[index]['saat']/60).toInt().toString()+":"+(_texts[index]['saat']%60).toString()),

                      );
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      child: Text("Button"),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SaveTextPage()));

                        // button press action
                      },
                    ),
                  ),
                )
              ],
            )
          : Column(
              children: [
                Center(
                  child: Container(child: CircularProgressIndicator()),
                ),
              ],
            ),
    );
  }
}
