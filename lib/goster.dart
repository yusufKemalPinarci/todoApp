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
  bool deger=false;
  late DatabaseHelper _dbHelper;
  List<Map<String, dynamic>> _texts = [];
  List<Map<String, dynamic>> _falseTexts = [];


  @override
  void initState() {
    super.initState();
    _dbHelper = DatabaseHelper.instance;
    _loadTexts();
  }

  _loadTexts() async {
    final texts = await _dbHelper.queryTrue();
    final falseTexts = await _dbHelper.queryFalse();

    setState(() {
      _texts = texts;
      _falseTexts=falseTexts;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text List'),
      ),
      body: Column(
        children: [
          Text("Tamamlananlar",style:TextStyle(fontSize: 30) ),
          Flexible(
            child: _texts != null ? ListView.builder(shrinkWrap: true,
              itemCount: _texts.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: ListTile(
                    title: Text(_texts[index]['text'] ),
                    subtitle: Text(DateFormat("dd-MM-yyyy").format(DateTime.fromMillisecondsSinceEpoch(_texts[index]['tarih'])))
                    ,trailing: Text((_texts[index]['saat']/60).toInt().toString()+":"+(_texts[index]['saat']%60).toString()),
                    leading: Checkbox(value:_texts[index]["completed"]==1,onChanged: (value){

                     setState(() {
                       var newText = Map.of(_texts[index]);
                       newText["completed"] = value;
                       _dbHelper.update(newText, _texts[index]["id"]);
                       _loadTexts();
                     });
                    },
                    ),
                  ),onTap: (){
                    print("basıldı");


                },
                );
              },
            ):Column(
              children: [
                Center(
                  child: Container(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),SizedBox(height: 50,), Text("Tamamlanacaklar",style:TextStyle(fontSize: 30) ),
          Flexible(
            child: ListView.builder(shrinkWrap: true,
              itemCount: _falseTexts.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: ListTile(
                    title: Text(_falseTexts[index]['text'] ),
                    subtitle: Text(DateFormat("dd-MM-yyyy").format(DateTime.fromMillisecondsSinceEpoch(_falseTexts[index]['tarih'])))
                    ,trailing: Text((_falseTexts[index]['saat']/60).toInt().toString()+":"+(_falseTexts[index]['saat']%60).toString()),
                    leading: Checkbox(value:_falseTexts[index]["completed"]==1,onChanged: (value){

                      setState(() {
                        var newText = Map.of(_falseTexts[index]);
                        newText["completed"] = value;
                        _dbHelper.update(newText, _falseTexts[index]["id"]);
                        _loadTexts();
                      });
                    },
                    ),
                  ),onTap: (){
                  print("basıldı");


                },
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

    );
  }
}