import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:pm_world_clock_client/main.dart';
import 'package:http/http.dart' as http;
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_client.dart';

String waqiAPIKey = "510c278e7faabc1d3b7624d63860cad35acab3f1";

class MapsPage extends StatefulWidget {
  MapsPage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  Completer<GoogleMapController> _controller = Completer();
  MqttServerClient client;
  MqttConnectionState connectionState;
  Future mqttFuture;
  String locationListStr = "";

  onConnected() {
    print("HOLY CRAP THIS CONNECTED");
  }

  onDisconnected() {
    print("WTF IT DISCONNECTED");
  }

  onSubscribed(String sub) {
    print("We are subscribed to $sub");
  }

  onMsg(String username, String password) {}

  _getMqtt() async {
    MqttServerClient client = await connect();
    return client;
  }

  Future<MqttServerClient> connect() async {
    MqttServerClient client =
        MqttServerClient('tcp://postman.cloudmqtt.com', 'yello');
    client.port = 17408;
    client.logging(on: false);
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    // client.onUnsubscribed = onUnsubscribed;
    client.onSubscribed = onSubscribed;
    // client.onSubscribeFail = onSubscribeFail;
    // client.pongCallback = pong;
    // client.on

    final connMessage = MqttConnectMessage();
    // .authenticateAs('username', 'password')
    // .keepAliveFor(60)
    // .withWillTopic('willtopic')
    // .withWillMessage('Will message')
    // .startClean()
    // .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;

    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }

    client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage message = c[0].payload;

      // final builder = MqttClientPayloadBuilder();
      // builder.addString("");

      // client.publishMessage(
      //     'aq_display/location_list', MqttQos.exactlyOnce, builder.payload);

      final payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);

      locationListStr = payload;

      print('Received message: $payload from topic: ${c[0].topic}>');
    });

    return client;
  }

  String style = '''
  [
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ebe3cd"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#523735"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f1e6"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#c9b2a6"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#dcd2be"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#ae9e90"
      }
    ]
  },
  {
    "featureType": "landscape.natural",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#93817c"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#a5b076"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#447530"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f1e6"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#fdfcf8"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f8c967"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#e9bc62"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e98d58"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#db8555"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#806b63"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8f7d77"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#ebe3cd"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#b9d3c2"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#92998d"
      }
    ]
  }
]
  ''';

  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  String _searchText = "";
  List names = new List();
  List filteredNames = new List();
  Icon _searchIcon = new Icon(Icons.search);

  List<Marker> myMarker = <Marker>[];
  LatLng selectedPosition = LatLng(40.24626993238064, -111.64780855178833);

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(40.24626993238064, -111.64780855178833),
    zoom: 18,
  );

  @override
  void initState() {
    super.initState();

    mqttFuture = _getMqtt();
    mqttFuture.then((value) async =>
        await value.subscribe('aq_display/location_list', MqttQos.atLeastOnce));
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
      backgroundColor: Colors.black87,
      body: FutureBuilder(
          future: mqttFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text("Wut");
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Padding(
                          padding: EdgeInsets.all(25),
                          child: Icon(
                            Icons.settings_ethernet_outlined,
                            color: Colors.white70,
                            size: 60,
                          ))
                    ]),
                    Text(
                      "Connecting to the NET Lab",
                      style: TextStyle(color: Colors.white70, fontSize: 24),
                    ),
                  ],
                );
              case ConnectionState.done:
                return Stack(
                  children: <Widget>[
                    // Replace this container with your Map widget
                    GoogleMap(
                      markers: Set.from(myMarker),
                      onTap: _banana,
                      // mapType: MapType.hybrid,
                      initialCameraPosition: _kGooglePlex,
                      onMapCreated: (controller) {
                        controller.setMapStyle(style);
                        _controller.complete(controller);
                      },
                    ),
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  // color: Colors.black,
                                  color: Color.fromRGBO(255, 255, 255, .85),
                                ),
                                // color: Color.fromRGBO(255, 255, 255, .85),
                                child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Text(
                                      "Tap on the map to choose a location",
                                      style: TextStyle(fontSize: 20),
                                    )))))
                  ],
                );
            }
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _submitLocation,
        label: Text('Add to Screen'),
        icon: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerFloat, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _banana(LatLng loc) {
    setState(() {
      selectedPosition = loc;
      myMarker = [];
      myMarker.add(Marker(
          markerId: MarkerId(loc.toString()),
          position: loc,
          draggable: true,
          onDragEnd: (pos) {
            selectedPosition = pos;
            print(selectedPosition);
          }));
    });
    print(selectedPosition);
  }

  _submitLocation() async {
    print("Locations: $locationListStr");
    String prevLocations = locationListStr;

    final response = await http.get(Uri.https(
        'api.waqi.info',
        'feed/geo:${selectedPosition.latitude};${selectedPosition.longitude}/',
        {"token": waqiAPIKey}));

    final builder = MqttClientPayloadBuilder();
    final builderEmpty = MqttClientPayloadBuilder();

    mqttFuture.then((value) async {
      // await value.subscribe('aq_display/location_list', MqttQos.atLeastOnce);
      value.publishMessage(
          'aq_display/location_list', MqttQos.atLeastOnce, builderEmpty.payload,
          retain: true);
      builder.addString(
          "${prevLocations.substring(0, 14)}${selectedPosition.toJson()},[37.9788421857991,23.728971736732007],[47.916638882615025,106.9225416482629],[40.24626993238064,-111.64780855178833]${prevLocations.substring(14)}");
      value.publishMessage(
          'aq_display/location_list', MqttQos.atLeastOnce, builder.payload,
          retain: true);
    });

    if (jsonDecode(response.body)["status"] == "error") {
      // cityList.add(CityPM(aqi: 999, cityName: "ERR - ${locations[i]}"));
      print("Err");
    } else if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // cityList.add(CityPM.fromJson(jsonDecode(response.body)));
      // print(response.body);
      // print("Gottem");
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }

    final snackBar = SnackBar(
      content: Text('Location added to display.'),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(
                  title: "NET Lab - WAQI",
                )));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
