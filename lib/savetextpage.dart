import 'package:flutter/material.dart';
import 'package:todoapp2/goster.dart';
import 'package:todoapp2/databasehelper.dart';

class SaveTextPage extends StatefulWidget {
  @override
  _SaveTextPageState createState() => _SaveTextPageState();
}

class _SaveTextPageState extends State<SaveTextPage> {
  final _formKey = GlobalKey<FormState>();
  late String _textToSave;
  late DatabaseHelper _dbHelper;
  late TimeOfDay saat;
  late DateTime tarih;
  late int dateInMilliseconds;

  @override
  void initState() {
    super.initState();
    _dbHelper = DatabaseHelper.instance;
  }

  _saveText() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
// Insert the text to the database
      var row = {
        'name': 'Text',
        'text': _textToSave,
        'saat': saat.hour * 60 + saat.minute,
        'tarih': dateInMilliseconds,
        'completed':0
      };
      final id = await _dbHelper.insert(row);
      print('inserted row id: $id');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save Text'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Text to save'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) => _textToSave = value!,
              ),
              ElevatedButton(
                  onPressed: () {
                    TimeOfDay saatgecici = TimeOfDay.now();
                    showTimePicker(
                      context: context,
                      initialTime: saatgecici,
                      // initialTime: TimeOfDay.now(),
                      // initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                    ).then((value) {
                      print(value);
                      print(value!.format(context));
                      print("${value!.hour}:${value.minute}");
                      saat = value;
                    });
                  },
                  child: Text("Saat Seç")),
              ElevatedButton(
                  onPressed: () {
                    tarih = DateTime.now();
                    showDatePicker(
                      context: context,
                      initialDate: tarih,
                      firstDate: tarih,
                      lastDate: DateTime(2050),
                    ).then((value) {
                      print(value!);
                      print("${value.day}:${value.month}:${value.year}");
                      tarih = value;
                    });
                  },
                  child: Text("Tarih Seç")),
              ElevatedButton(
                child: Text('Save'),
                onPressed: () {
                  dateInMilliseconds = tarih.millisecondsSinceEpoch;
                  _saveText();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => TextListPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
