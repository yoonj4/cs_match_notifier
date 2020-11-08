import 'dart:convert';

import 'package:cs_match_notifier/match.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String _appName = 'Counterstrike Match Notifier';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appName,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: _appName),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Match> _matches = new List(0);
  List<Match> _favoritedMatches;

  @override
  void initState() {
    super.initState();

    final Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': '*/*',
      'Accept-Encoding': 'gzip',
    };
    const body = {
      'apikey': '172edrW4KxLIfk1SMsvLLLzdx6ugmT8anucDNe1QkkRUh7p3hcUQRzA6EcQmaqPuCA5y22mExEPVTmVWpt9NDgysDBlBWXv3PopI79A6DgS8QXBUgEcyaDhdKXlry6b5',
      'wiki': 'counterstrike',
    };

    Future<Response> matches = http.post('https://api.liquipedia.net/api/v1/match', headers: headers, body: body);
    matches.then((value) {
      if (value.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(value.body);
        final List matches = body['result'];
        setState(() {
          _matches = List.from(matches.map((e) {
            final Match match = Match.fromJson(e);
            return match;
          }));
        });
      } else {
        _matches = new List(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final Match match = _matches[index];
                  final DateTime matchTime = match.date;

                  String day;
                  final String matchDay = DateFormat('yyyyMMdd').format(matchTime);
                  final DateTime now = DateTime.now();
                  final String today = DateFormat('yyyyMMdd').format(now);

                  if (matchDay == today) {
                    day = ' today';
                  } else if (matchDay.substring(0, matchDay.length - 1) == today.substring(0, today.length - 1)
                             && matchDay.substring(matchDay.length - 1) == today.substring(today.length - 1)) {
                    day = ' tomorrow';
                  } else {
                    day = ' ' + DateFormat('MMMM d, yyyy').format(matchTime);
                  }

                  return Card(
                      child: ListTile(
                        title: Text(match.opponent1 + " vs " + match.opponent2, style: TextStyle(fontWeight: FontWeight.bold),),
                        subtitle: Text(DateFormat('jm').format(matchTime) + day),
                      )
                  );
                },
                itemCount: _matches.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
