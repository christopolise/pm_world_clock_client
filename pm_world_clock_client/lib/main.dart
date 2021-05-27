import 'package:flutter/material.dart';
import 'package:pm_world_clock_client/info.dart';
import 'package:pm_world_clock_client/maps.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NET Lab - WAQI',
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
      ),
      home: MyHomePage(title: 'NET Lab - WAQI'),
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
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              backgroundColor: Color.fromRGBO(70, 70, 70, 1),
              icon: Icon(Icons.bug_report),
              label: Text("Report an Issue"),
              onPressed: () async {
                final url =
                    "https://github.com/christopolise/pm_world_clock_client/issues/new";
                if (await canLaunch(url)) {
                  await launch(url, forceSafariVC: false);
                }
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndTop,
            backgroundColor: Colors.black87,
            appBar: AppBar(
              toolbarHeight: 110,
              backgroundColor: Colors.white30,
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Image.asset(
                  'NET_Lab_Logo_v4.png',
                  scale: 6,
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                    child: Text(
                      widget.title,
                      style: TextStyle(color: Colors.white, fontSize: 45),
                    )),
              ]),
            ),
            bottomNavigationBar: TabBar(
              indicatorColor: Colors.amber,
              tabs: [
                Tab(icon: Icon(Icons.info)),
                Tab(icon: Icon(Icons.map)),
              ],
            ),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                InfoPage(),
                MapsPage(),
              ],
            ) // This trailing comma makes auto-formatting nicer for build methods.
            ));
  }
}
