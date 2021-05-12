import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  InfoPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    TextStyle paragraph = new TextStyle(fontSize: 16);
    TextStyle header = new TextStyle(fontSize: 28, fontWeight: FontWeight.bold);
    TextStyle tableInfo =
        new TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    TextStyle tableDark = new TextStyle(color: Colors.white, fontSize: 16);
    TextStyle link = new TextStyle(fontSize: 16, color: Colors.blue);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        backgroundColor: Color.fromRGBO(248, 248, 255, 1),
        body: Padding(
            padding: EdgeInsets.all(25),
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "What is AQI?",
                      style: header,
                    )),
                Text(
                  '''Air Quality Index (AQI) is the Environmental Protection Agency's (EPA) standard metric of rating the quality of air based on the quantity of the Five Major Pollutants within a given volume. Simply put, it is a grade for how healthy it is to the breathe the air in a certain area. Just like in golf, the lower the number, the better the score.''',
                  style: paragraph,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "Five Major Pollutants",
                      style: header,
                    )),
                Text(
                  '''EPA establishes an AQI for five major air pollutants regulated by the Clean Air Act. Each of these pollutants has a national air quality standard set by EPA to protect public health:

•    ground-level ozone
•    particle pollution (also known as particulate matter, including PM2.5 and PM10)
•    carbon monoxide
•    sulfur dioxide
•    nitrogen dioxide
                  ''',
                  style: paragraph,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "AQI Basics for Ozone and Particle Pollution",
                      style: header,
                    )),
                Table(
                  border: TableBorder.all(),
                  columnWidths: const <int, TableColumnWidth>{
                    0: IntrinsicColumnWidth(),
                    1: IntrinsicColumnWidth(),
                    2: IntrinsicColumnWidth(),
                    3: IntrinsicColumnWidth()
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: <TableRow>[
                    TableRow(
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(235, 245, 255, 1),
                      ),
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text("Daily AQI Color", style: tableInfo),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text("Levels of Concern", style: tableInfo),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text("Values of Index", style: tableInfo),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text("Description", style: tableInfo),
                        ),
                      ],
                    ),
                    TableRow(
                      decoration: const BoxDecoration(
                        color: Colors.green,
                      ),
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Green",
                            style: tableInfo,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Good",
                            style: tableInfo,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "0 - 50",
                            style: tableInfo,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Air quality is safe. Little to no risk in air pollution.",
                            style: tableInfo,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                      ),
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Yellow",
                            style: tableInfo,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Moderate",
                            style: tableInfo,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "51 - 100",
                            style: tableInfo,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Air quality is acceptable. However, there is some risk for those who are unusually sensitive to air pollution.",
                            style: tableInfo,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      decoration: const BoxDecoration(color: Colors.orange),
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Orange",
                            style: tableInfo,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "High",
                            style: tableInfo,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "101 - 150",
                            style: tableInfo,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "General public is unlikely to be affected, however sensitive groups may experience health effects.",
                            style: tableInfo,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      decoration: const BoxDecoration(
                        color: Colors.red,
                      ),
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Red",
                            style: tableInfo,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Unhealthy",
                            style: tableInfo,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "151 - 200",
                            style: tableInfo,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Some in the general public may experience health effects; sensitive groups may experience serious health effects.",
                            style: tableInfo,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      decoration: const BoxDecoration(
                        color: Colors.purple,
                      ),
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Purple",
                            style: tableDark,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Very Unhealthy",
                            style: tableDark,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "201 - 300",
                            style: tableDark,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Health alert: The risk of health effects is increased for everyone.",
                            style: tableDark,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(128, 0, 0, 1),
                      ),
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Maroon",
                            style: tableDark,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Hazardous",
                            style: tableDark,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "301+",
                            style: tableDark,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Health warning of emergency conditions: everyone is more likely to be affected.",
                            style: tableDark,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "NET Lab and AQI",
                      style: header,
                    )),
                Text(
                  '''At the core of any good air quality monitoring system are the fundamentals of Internet of Things (IoT). The NET Lab pushes the bounds of technology by finding diverse implementations and opportunities to research and serve.''',
                  style: paragraph,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "Related Links and Sources",
                      style: header,
                    )),
                InkWell(
                  child: Text(
                    '''AirNow Gov AQI Info''',
                    style: link,
                  ),
                  onTap: () async {
                    final url =
                        "https://www.airnow.gov/aqi/aqi-basics/#:~:text=Think%20of%20the%20AQI%20as,300%20represents%20hazardous%20air%20quality.";
                    if (await canLaunch(url)) {
                      await launch(url, forceSafariVC: false);
                    }
                  },
                ),
                InkWell(
                  child: Text(
                    '''NET Lab Projects''',
                    style: link,
                  ),
                  onTap: () async {
                    final url = "https://netlab.byu.edu/projects/";
                    if (await canLaunch(url)) {
                      await launch(url, forceSafariVC: false);
                    }
                  },
                ),
              ],
            ))) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
