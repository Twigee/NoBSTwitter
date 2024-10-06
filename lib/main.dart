import 'package:flutter/material.dart';

import 'package:http/http.dart';

import 'package:twitter_api_v2/twitter_api_v2.dart' as v2;

void main() {
  runApp(const MyApp());
}

final TextEditingController fieldCont = TextEditingController();

String myAuthToken = "";
String myAuthSecretToken = "";

Future login() async {
  final twitter = v2.TwitterApi(
      bearerToken: "",
      oauthTokens: v2.OAuthTokens(
          consumerKey: "",
          consumerSecret: "",
          accessToken: "",
          accessTokenSecret: ""));

  await twitter.tweets.createTweet(text: fieldCont.text);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TwitterAlt',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 183, 146, 247)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Twitter Alt'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
    List<Widget> pages = <Widget>[
      const Test(),
      const Settings(),
    ];

    return Scaffold(
      body: Center(
        child: pages.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Settings extends StatelessWidget {
  const Settings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Row(
        children: <Widget>[
          Icon(Icons.info_outline),
          Text("    Created By Twig"),
        ],
      ),
    ));
  }
}

class Test extends StatelessWidget {
  const Test({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 100),
            height: 300,
            child: Column(
              children: [
                Expanded(
                  child: TextField(
                    controller: fieldCont,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(), labelText: "Tweet"),
                    maxLines: null,
                    maxLength: 280,
                    expands: true,
                  ),
                ),
              ],
            ),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await login();
        },
        tooltip: "Tweet",
        shape: const CircleBorder(),
        child: const Icon(Icons.upload_rounded),
      ),
    );
  }
}
