import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vacc_app/Pages/Home/Map/google_map.dart';
import 'package:vacc_app/Pages/Home/Map/hospital_model.dart';

class Hospital extends StatefulWidget {
  const Hospital({Key key}) : super(key: key);

  @override
  _HospitalState createState() => _HospitalState();
}

class _HospitalState extends State<Hospital> {
  List<HospitalModel> _list = [
    HospitalModel('Cairo', 'lorem rqhwfbesdalkhjxhbwhjefbDS XKJWBHEbwnfej',
        LatLng(30.033333, 31.233334)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.indigo[200],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width / 2,
                      child: Image.asset('assets/h.png'),
                    ),
                    Column(
                      children: [
                        Text(
                          "${_list[index].name}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                          ),
                        ),
                        //   Text("${_list[index].description}",overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                  ],
                ),
              ),
              onLongPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MapScreen(_list[index].position)));
              },
            );
          }),
    );
  }
}
