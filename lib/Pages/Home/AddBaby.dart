import 'package:flutter/material.dart';
class AddBaby extends StatefulWidget {
  @override
  _AddBabyState createState() => _AddBabyState();
}

class _AddBabyState extends State<AddBaby> {
  String dropdownValue = 'Male';
  var now = new DateTime.now();
  var berlinWallFell = new DateTime.utc(1989, 11, 9);
  var moonLanding = DateTime.parse("1969-07-20 20:18:04Z");  // 8:18pm

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("New Baby")),
        backgroundColor: Colors.pink,
         automaticallyImplyLeading: false,

      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 150,left: 60,right: 60,bottom: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70),
                color: Colors.grey[300]
            ),
            child: TextFormField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Baby Name",
                  contentPadding: EdgeInsets.all(25),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10,left: 60,right: 60,bottom: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70),
                color: Colors.grey[300]
            ),
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Baby Birthday",
                contentPadding: EdgeInsets.all(25),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 5,left: 60,right: 60,bottom: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70),
                color: Colors.grey[300]
            ),
            child: Row(
              children: [
                SizedBox(width: 20,),
                Text("Gender :",
                  style: TextStyle(
                    fontSize: 19,
                  ),),
                SizedBox(width: 50,),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 22,
                  elevation: 26,
                  style: TextStyle(color: Colors.black87),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>['Male', 'Female']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              ],
            ),
          ),
          Container(
            width: 280,
            height: 80,
            margin: EdgeInsets.symmetric(horizontal: 70),
            padding: EdgeInsets.only(top: 20),
            child: RaisedButton(
              color: Colors.pink[400],
              child: Text("Add Baby ", style: TextStyle(color: Colors.white),),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30),
              ),
              onPressed: (){

              },
            ),
          ),

        ],
      ),
    );
  }
}
