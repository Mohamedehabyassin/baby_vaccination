import 'package:flutter/material.dart';

class BabyDetails extends StatefulWidget {
  final data;

  BabyDetails(this.data);

  @override
  _BabyDetailsState createState() => _BabyDetailsState();
}

class _BabyDetailsState extends State<BabyDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.blue[500], borderRadius: BorderRadius.circular(40)),
        child: Column(
          children: [
            Text(
              '${widget.data['babyName'].toString().toUpperCase()}',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            Divider(
              indent: 60,
              endIndent: 60,
              color: Colors.blue[300],
              thickness: 5,
              height: 50,
            ),
            Text(
              'Birthdate : ${widget.data['babyBirthday'].toString().toUpperCase()}',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Divider(
              indent: 60,
              endIndent: 60,
              color: Colors.blue[300],
              thickness: 5,
              height: 50,
            ),
            Text(
              "${widget.data['babyVaccination']}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                wordSpacing: 2
              ),
            )
          ],
        ),
      ),
    );
  }
}
