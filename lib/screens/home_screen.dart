import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_geofence/geofence.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  String _platformVersion = Platform.isAndroid ? "Android" : "ios";

  Completer<GoogleMapController> _controller = Completer();

  static LatLng _initialPosition;

  Set<Marker> _markers = {};

  static LatLng _geofenceMarkerPosition;

  static double _initRadius = 500.0;

  String _userStatus = "None";

  static Geolocation _location;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    Geofence.requestPermissions();
    _initPlatformState();

    _listenForPersmissionStatus();

// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings();

    var initializationSettings = InitializationSettings(
      initializationSettingsAndroid,
      initializationSettingsIOS,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: _onSelectNotification,
    );
  }

  @override
  void didUpdateWidget(HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    print("oldwidget $oldWidget");
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    removeGeoFenceLocation();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print("resumed");
        _listenForPersmissionStatus();
        break;
      case AppLifecycleState.detached:
        print("detached");
        break;
      case AppLifecycleState.inactive:
        print("inactive");
        removeGeoFenceLocation();
        setState(() {
          _markers = {};
          _geofenceMarkerPosition = null;
        });
        break;
      case AppLifecycleState.paused:
        print("paused");
        break;
      default:
        print("Lifecycle error occur");
    }
  }

  void removeGeoFenceLocation() {
    if (_location != null) {
      Geofence.removeGeolocation(_location, GeolocationEvent.entry);
    }
  }

  Future<void> _listenForPersmissionStatus() async {
    try {
      final _status = await Permission.locationWhenInUse.serviceStatus;

      if (_status.isEnabled) {
        print("permission granted");
        _getUserLocation();
      } else {
        print("permission denied");
      }
    } catch (error) {
      print("get permission status error: $error");
    }
  }

  Future<void> _initPlatformState() async {
    if (!mounted) return;

    Geofence.initialize();

    Geofence.startListening(GeolocationEvent.entry, (entry) {
      _scheduleNotification("Inside GeoFence", "Welcome to: ${entry.id}");
      setState(() {
        _userStatus = "inside";
      });
    });

    Geofence.startListening(GeolocationEvent.exit, (entry) {
      _scheduleNotification("Outside GeoFence", "Byebye to: ${entry.id}");
      setState(() {
        _userStatus = "outside";
      });
    });

    setState(() {});
  }

  Future _onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Here is your payload"),
        content: Text("Playload : $payload"),
      ),
    );
  }

  Future<void> _getUserLocation() async {
    try {
      final Coordinate userLoc = await Geofence.getCurrentLocation();

      setState(() {
        _initialPosition = LatLng(userLoc.latitude, userLoc.longitude);
      });
    } catch (error) {
      print("Error get current location");
    }
  }

  void _setGeofenceRegion(LatLng geofenceMarkerLatLng) {
    _location = Geolocation(
      id: "luktm",
      latitude: geofenceMarkerLatLng.latitude,
      longitude: geofenceMarkerLatLng.longitude,
      radius: _initRadius,
    );

    Geofence.addGeolocation(
      _location,
      GeolocationEvent.entry,
    ).then((value) {
      print("Georegion added");
      
    }).catchError((error) {
      print("Added geofence failed, $error");
    });
  }

  Future<void> _addMarkerLongPressed(LatLng latLng) async {
    setState(() {
      _markers = {};
      _geofenceMarkerPosition = latLng;

      _setGeofenceRegion(_geofenceMarkerPosition);

      _markers.add(
        Marker(
          icon: BitmapDescriptor.defaultMarker,
          markerId: MarkerId(_initialPosition.toString()),
          position: latLng,
          infoWindow:
              InfoWindow(title: "Region Set", snippet: "This is snippet"),
          onTap: () {
            setState(() {
              _markers = {};
            });
          },
        ),
      );
    });
  }

  void _scheduleNotification(String title, String subtitle) {
    Future.delayed(Duration(seconds: 5)).then((result) async {
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        'your channel description',
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'ticker',
      );

      var iOSPlatformChannelSpecifics = IOSNotificationDetails();

      var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics,
        iOSPlatformChannelSpecifics,
      );

      await flutterLocalNotificationsPlugin.show(
        0,
        title,
        subtitle,
        platformChannelSpecifics,
        payload: 'you clicked the notfication',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Geofence'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("Guideline to use geofence"),
                  content: Text(
                      "Long pressed the area you wanted to place marker, Slider will be appear for you to adjust the geofence ranges"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("OK"),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: _initialPosition == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: <Widget>[
                Container(
                  height: deviceData.size.height,
                  width: deviceData.size.width,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    initialCameraPosition: CameraPosition(
                      target: _initialPosition,
                      zoom: 14.4746,
                    ),
                    myLocationEnabled: true,
                    compassEnabled: true,
                    myLocationButtonEnabled: true,
                    tiltGesturesEnabled: false,
                    onLongPress: (latLng) {
                      _addMarkerLongPressed(latLng);
                    },
                    markers: _markers,
                    circles: _geofenceMarkerPosition == null
                        ? null
                        : Set.from(
                            [
                              Circle(
                                fillColor:
                                    ThemeData().primaryColor.withOpacity(0.2),
                                strokeColor: Colors.transparent,
                                center: _geofenceMarkerPosition,
                                radius: _initRadius,
                                circleId: CircleId(
                                  _initialPosition.toString(),
                                ),
                              )
                            ],
                          ),
                  ),
                ),
                if (_markers.isNotEmpty)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      margin: EdgeInsets.only(bottom: 30, right: 80, left: 30),
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                  "Geofence area: ${(_initRadius / 100).toStringAsFixed(0)}KM"),
                              Text("Status: $_userStatus")
                            ],
                          ),
                          Slider(
                              value: _initRadius,
                              divisions: 5,
                              min: 100,
                              max: 1000,
                              onChangeEnd: (_) {
                                Geofence.removeGeolocation(
                                  _location,
                                  GeolocationEvent.entry,
                                ).then((value) {
                                  print("Georegion removed");
                                  _setGeofenceRegion(_geofenceMarkerPosition);
                                });
                              },
                              onChanged: (newValue) {
                                setState(() {
                                  _initRadius = newValue;
                                });
                              })
                        ],
                      ),
                    ),
                  )
              ],
            ),
    );
  }
}
