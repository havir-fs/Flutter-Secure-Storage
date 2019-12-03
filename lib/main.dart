import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
      home: MyHomePage(
        title: "Flutter Secure Storage",
      ),
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
  FlutterSecureStorage storage;

  String _encryptionTime;
  String _decryptionTime;

  String _sampleToken =
      "bqLSrt16%sE&P#nDi7ij4mjMRvUy9I9p0DtQn7crgf^BV21kJ6mu6NwE7ZESdOBDOdt1w%q6kAYsAHymtkXoDRr!zz0OA7#vxqOx";

  @override
  void initState() {
    super.initState();
    storage = FlutterSecureStorage();
  }

  @override
  void dispose() {
    super.dispose();
    storage = null;
  }

  void _encrypt() async {
    Stopwatch stopwatch = new Stopwatch()..start();

    //write to the secure storage
    await storage.write(key: SECURE_NOTE_KEY, value: _sampleToken);

    print('****** encrypting and saving executed in ${stopwatch.elapsed}');
    print(
        '****** encrypting and saving executed in (mili) ${stopwatch.elapsedMilliseconds}');

    Fluttertoast.showToast(msg: "Token succesfully stored and encrypted!");
  }

  void _decrypt() async {
    Stopwatch stopwatch2 = new Stopwatch()..start();

    //read from the secure storage
    String value = await storage.read(key: SECURE_NOTE_KEY);

    print('&&&&&&&& decrypting and reading executed in ${stopwatch2.elapsed}');
    print(
        '&&&&&&&& decrypting and reading executed in ${stopwatch2.elapsedMilliseconds}');

    Fluttertoast.showToast(msg: "Decrypted Token is:\n$value");
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
                padding: EdgeInsets.all(10),
                child: SelectableText("Token:\n\n$_sampleToken")),
            SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text("Encrypt"),
                  onPressed: () {
                    _encrypt();
                  },
                ),
                SizedBox(
                  width: 32,
                ),
                RaisedButton(
                  child: Text("Decrypt"),
                  onPressed: () {
                    _decrypt();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
