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
  bool deger = false;
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
      _falseTexts = falseTexts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         
          body: Column(
            children: [
              SizedBox(height: 5,),
              Text("Bugün Tamamlandı",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              Flexible(
                child: _texts != null ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.black)),
                    child: ListView.builder(shrinkWrap: true,
                      itemCount: _texts.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            title: Text(_texts[index]['text']),
                        subtitle: Text(DateFormat("dd-MM-yyyy").format(DateTime.fromMillisecondsSinceEpoch(_texts[index]['tarih']))+"--"+(_texts[index]['saat']/60).toInt().toString()+":"+(_texts[index]['saat']%60).toString())
                        ,trailing: InkWell(child: Icon(Icons.clear)),
                        leading: Checkbox(value:_texts[index]["completed"]==1,onChanged: (value){

                        setState(() {
                        var newText = Map.of(_texts[index]);
                        newText["completed"] = value;
                        _dbHelper.update(newText, _texts[index]["id"]);
                        _loadTexts();
                        });
                        },
                        )
                        ,
                        );

                      },
                    ),
                  ),
                ) : Column(
                  children: [
                    Center(
                      child: Container(child: CircularProgressIndicator()),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Text("Bekleyen Görevler",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: ListView.builder(shrinkWrap: true,
                      itemCount: _falseTexts.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: ListTile(
                            title: Text(_falseTexts[index]['text']),
                            subtitle: Text(DateFormat("dd-MM-yyyy").format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    _falseTexts[index]['tarih'])))
                            , trailing: Text((_falseTexts[index]['saat'] / 60)
                              .toInt()
                              .toString() + ":" +
                              (_falseTexts[index]['saat'] % 60).toString()),
                            leading: Checkbox(
                              value: _falseTexts[index]["completed"] == 1,
                              onChanged: (value) {
                                setState(() {
                                  var newText = Map.of(_falseTexts[index]);
                                  newText["completed"] = value;
                                  _dbHelper.update(
                                      newText, _falseTexts[index]["id"]);
                                  _loadTexts();
                                });
                              },
                            ),
                          ), onTap: () {
                          print("basıldı");
                        },
                        );
                      },
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.black)),
                  ),
                ),
              ),

            ],
          )

      ),
    );
  }
}