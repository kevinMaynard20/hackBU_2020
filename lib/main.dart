import 'dart:collection';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'Backend/API_Handler.dart'; 
import 'Backend/LocationDoc.dart';

void main() => runApp(MyApp());



class MyApp extends StatelessWidget{

  Widget build(BuildContext context){
    return MaterialApp(
      home: MyHomePage(),
    );
  }

}
  class MyHomePage extends StatefulWidget{
  _MyHomePageState createState() => _MyHomePageState(); //Kind of works how suppliers do in java
  }                                                    // most of this stuff on top is p basic

class _MyHomePageState extends State<MyHomePage> {
  Completer<GoogleMapController> _controller = Completer(); //turning it into some kinda promise idk Just trying to fix the issue this is code from docs 
  String search;
  Set<Marker> _markers = HashSet<Marker>();//hashset 0_0 cool taylor

  @override
  Widget build(BuildContext context) { // reformatted most of this based off of what

      return Scaffold(
        appBar: AppBar(
          title: Text('D8 Night'), // i changed the name B )
          backgroundColor: Colors.red[700],
        ),
        body: Stack(        // layers widgets in reverse order
        children: <Widget>[ //
          GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(0 ,0), // arbitrary location
                zoom: 10
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);

              }, //OnMapCreated function moved up
              markers: _markers,
            ),
          Positioned(
            top: 30.0,
            right: 15.0,
            left: 15.0,
            child: Container(//
              height: 50,
              width: double.infinity,// text box aint got no limit
              decoration: BoxDecoration(
                color: Colors.pink[100],//jus tryna make it love themed team : .. (
              ),
              child: TextField(
              decoration: InputDecoration(
                hintText: 'Type your destination',
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15, top: 15),
                suffixIcon: IconButton(
                icon: Icon(Icons.search), // adds search icon
                  onPressed:  searchAndNavigate, // calls the class that moves and
                    iconSize: 30,
    )
              ),
                onChanged: (val){
                setState(() {
                  search = val;
                });
                }
              )
            )
          )
        ],
        ),
      );
  }

  searchAndNavigate() async{ //p much google's implementation of Geolocator
    Geolocator().placemarkFromAddress(search).then((result) async { //Generates palcemarker from 'search'
        final GoogleMapController mapController = await _controller.future; //getting mapController from Future
        mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(result[0].position.latitude, result[0].position.longitude),//
          zoom: 15.0)));
        
        //Getting locations in the area
        var coords = [result[0].position.latitude, result[0].position.longitude];
        await generatePins(coords);


    });
  }
generatePins(List<double> coords) async{
    var locations = await APIHandler.getLocationInfo(coords);
    for(var i = 0; i < 8; i++){
    print(locations[i]);
    setState((){
      _markers.add(
        Marker(
          markerId: MarkerId(locations[i].getName() + locations[i].getLat().toString()),
          position: LatLng( locations[i].getLat(), locations[i].getLon()),
          infoWindow: InfoWindow(
            title: locations[i].getName(),
            snippet: locations[i].getDescript(),
          ),
        ),
      );
    });
    }

  }
}