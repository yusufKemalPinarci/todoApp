import 'package:flutter/material.dart';

import 'databasehelper.dart';

class ProfilimPage extends StatefulWidget {
  const ProfilimPage({Key? key}) : super(key: key);

  @override
  State<ProfilimPage> createState() => _ProfilimPageState();
}


class _ProfilimPageState extends State<ProfilimPage> {
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
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Row(
            children: [
              Expanded(
                  child: Card(margin: EdgeInsetsDirectional.all(10),
                child: SizedBox(
                    width: 200,
                    height: 250,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("tamamlanan görevler",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),), Text(_texts.length.toString(),style:TextStyle(fontSize: 30))],
                      ),
                    )),
              )),
              Expanded(
                child: Card(margin: EdgeInsetsDirectional.all(10),
                  color: Colors.blue,
                  child: SizedBox(
                      width: 200,
                      height: 250,
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Bekleyen görevler"),
                          SizedBox(height: 5,),
                          Text(_falseTexts.length.toString(),style:TextStyle(fontSize: 30))
                        ],
                      )),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
