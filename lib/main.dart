import 'package:flutter/material.dart';
import 'package:voice_assistant_sample/Constants.dart';
import 'package:wit_ai/wit_ai.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Chatbot '),
    );
  }
}

callWit(String text) async {
  final wit = Wit(accessToken: Constants.token);

  dynamic response = await wit.message(text);
  var entities = response['entities'];
  try{
    var messages= entities["infos_sonepar:infos_sonepar"][0];
    return (messages["value"]);
  }on Exception catch (_) {
  }
  return ("I don't have response");
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _messages = <String>[];
  TextEditingController _textController = new TextEditingController();

  void _incrementCounter(String text) {
    _textController.clear();
    setState(() {
      _messages.add(text);
    });
    callWit(text).then((value) => setState(() => _messages.add(value)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
            child: Column(
          children: [
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _messages.length,
                itemBuilder: (BuildContext context, int index) => Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8, right: 8, left: 8),
                        child:(index%2 ==0)? Align(
                              alignment: Alignment.topLeft,
                              child: Text(_messages[index])) : Align(
                              alignment: Alignment.topRight,
                   child: Text(_messages[index])),
                          ),
                      ],
                    )),
            Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: <Widget>[
                    new Flexible(
                      child: new TextField(
                        controller: _textController,
                        onSubmitted: _incrementCounter,
                        decoration: new InputDecoration.collapsed(
                            hintText: "Send a message"),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.symmetric(horizontal: 4.0),
                      child: new IconButton(
                          icon: new Icon(Icons.send),
                          onPressed: () =>
                              _incrementCounter(_textController.text)),
                    ),
                  ],
                )),
          ],
        )));
  }
}
