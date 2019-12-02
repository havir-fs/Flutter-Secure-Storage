import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const String SECURE_NOTE_KEY = "SECURE_NOTE_KEY";

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Secure Storage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Secure Storage'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController secureNoteController;

  @override
  void initState() {
    super.initState();
    secureNoteController = TextEditingController();
  }

  @override
  void dispose() {
    secureNoteController.dispose();
    super.dispose();
  }

  void _saveSecureNote() async {
    //write to the secure storage
    final storage = FlutterSecureStorage();
    await storage.write(key: SECURE_NOTE_KEY, value: secureNoteController.text);

    //read from the secure storage
    String value = await storage.read(key: SECURE_NOTE_KEY);

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Alert"),
          content: Text("\"$value\" securely saved!"),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 64, right: 64),
              child: TextField(
                decoration:
                    InputDecoration(hintText: 'Write down your secure note'),
                controller: secureNoteController,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (secureNoteController.text.trim() != "" &&
              secureNoteController.text != null) _saveSecureNote();
        },
        tooltip: 'Save',
        child: Icon(Icons.save),
      ),
    );
  }
}
