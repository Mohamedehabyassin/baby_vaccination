import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:google_maps_webservice/directions.dart' as directions;
import 'package:vacc_app/model/direction_model.dart';
import 'package:vacc_app/modules/map/direction_details.dart';
import 'package:vacc_app/modules/map/direction_rep.dart';

class MapScreen extends StatefulWidget {
  final LatLng position;

  MapScreen(this.position);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(30.773972, 31.431297),
    zoom: 12.5,
  );
  GoogleMapController _googleMapController;
  Location locationTracker = Location();
  Marker _origin;
  Marker _destination;
  Directions _info;
  DirectionDetails directionDetails;
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  final Set<Polyline> _polyline = {};
  List<LatLng> latLngList = [];

  void getCurrentLocation() async {
    try {
      LocationData location = await locationTracker.getLocation();
      LatLng latLng = LatLng(location.latitude, location.longitude);

      if (_googleMapController != null) {
        _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
            new CameraPosition(
                target: LatLng(location.latitude, location.longitude),
                zoom: 11.00)));
      }
      setState(() {
        _origin = Marker(
          markerId: MarkerId("origin"),
          position: latLng,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        );
        latLngList.add(_origin.position);
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  void addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  void getHospitalLocation() {
    LatLng latLngDes =
        LatLng(widget.position.latitude, widget.position.longitude);
    if (_googleMapController != null) {
      _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          new CameraPosition(target: latLngDes, zoom: 11.00)));
    }
    setState(() {
      _destination = Marker(
        markerId: MarkerId("destination"),
        position: latLngDes,
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      );
      obtainDirection();
    });
  }

  void makeLines() async {
    await polylinePoints
        .getRouteBetweenCoordinates(
      'AIzaSyCIdWX_NEbI8bJpujWZadAjwNbZb_lP38E',
      PointLatLng(_origin.position.latitude, _origin.position.longitude),
      //Starting LATLANG
      PointLatLng(
          _destination.position.latitude, _destination.position.longitude),
      //End LATLANG
      travelMode: TravelMode.driving,
    )
        .then((value) {
      value.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }).then((value) {
      addPolyLine();
    });
  }

  Future<dynamic> makingRequest() async {
    try {
      String url =
          "https://maps.googleapis.com/maps/api/directions/json?origin=${_origin.position.latitude},${_origin.position.longitude}&destination=${_destination.position.latitude},${_destination.position.longitude}&key=AIzaSyCIdWX_NEbI8bJpujWZadAjwNbZb_lP38E";

      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        String data = response.body;
        String decodedData = jsonDecode(data);
        return decodedData;
      } else {
        return "Failed";
      }
    } catch (e) {
      return "Failed";
    }
  }

  void obtainDirection() async {
    var request = await makingRequest();

    if (request == "Failed") {
      return null;
    }

    setState(() {
      directionDetails.encodedPoints =
          request["routes"][0]["overview_polyline"]["points"];
      directionDetails.distanceText =
          request["routes"][0]["legs"][0]["distance"]["text"];
      directionDetails.distanceValue =
          request["routes"][0]["legs"][0]["distance"]["value"];
      directionDetails.durationText =
          request["routes"][0]["legs"][0]["duration"]["text"];
      directionDetails.durationValue =
          request["routes"][0]["legs"][0]["duration"]["value"];
    });
  }

  @override
  void dispose() {
    super.dispose();
    _googleMapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.indigo[900],
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.local_airport_sharp),
          onPressed: () {
            getHospitalLocation();
          },
        ),
        title: const Text('Maps'),
        actions: [
          if (_origin != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _origin.position,
                    zoom: 18,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.green,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('Location'),
            ),
          if (_destination != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _destination.position,
                    zoom: 18,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.white,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('Destination'),
            )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              initialCameraPosition: _initialCameraPosition,
              onMapCreated: (controller) => _googleMapController = controller,
              markers: {
                if (_origin != null) _origin,
                if (_destination != null) _destination,
              },
              polylines: {
                if (directionDetails != null)
                  Polyline(
                    polylineId: PolylineId('overview_polyline'),
                    points: directionDetails.encodedPoints
                        .map((e) => LatLng(e.latitude, e.longitude))
                        .toList(),
                    width: 5,
                    color: Colors.red,
                  )
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo[900],
        foregroundColor: Colors.white,
        onPressed: () => getCurrentLocation(),
        child: const Icon(Icons.location_on),
      ),
    );
  }

  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      // Origin is not set OR Origin/Destination are both set
      // Set origin
      setState(() {
        _origin = Marker(
          markerId: MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          position: pos,
        );
        // Reset destination
        _destination = null;

        // Reset info
        _info = null;
      });
    } else {
      // Origin is already set
      // Set destination
      setState(() {
        _destination = Marker(
          markerId: MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
          position: pos,
        );
      });

      // Get directions
      final directions = await DirectionsRepository()
          .getDirections(origin: _origin.position, destination: pos);
      setState(() => _info = directions as Directions);
    }
  }
}
