import 'package:flutter/material.dart';
import 'package:vacc_app/modules/screen/vacc_settings.dart';

class BabyDetails extends StatefulWidget {
  final data;

  BabyDetails(this.data);

  @override
  _BabyDetailsState createState() => _BabyDetailsState();
}

class _BabyDetailsState extends State<BabyDetails> {
  var vaccList = [];
  int goal = 0;

  @override
  void initState() {
    // TODO: implement initState
    modifyVaccList();
    super.initState();
  }

  void modifyVaccList() {
    for (var data in widget.data['babyVaccination']) {
      setState(() {
        vaccList.add(VaccSettings(title: data));
      });
    }
  }

  void modifyGoal() {
    int counter = 0;
    for (var data in vaccList) {
      if (data.value == true) {
        counter++;
      }
    }
    setState(() {
      if(counter == 0){
        goal= 0;
      }
      else{
        goal = ((counter / vaccList.length)*100).toInt() ;
      }

    });
  }

  Widget buildSingleCheckbox(VaccSettings settings) => buildCheckbox(
      vaccSettings: settings,
      onClicked: () {
        setState(() {
          final newValue = !settings.value;
          settings.value = newValue;
        });
      });

  Widget buildDivider() => Divider(
        indent: 60,
        endIndent: 60,
        color: Colors.blue[300],
        thickness: 3,
        height: 50,
      );

  Widget buildCheckbox({
    @required VaccSettings vaccSettings,
    @required VoidCallback onClicked,
  }) =>
      Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.blue[200],
          borderRadius: BorderRadius.circular(90),
        ),
        child: ListTile(
          onTap: onClicked,
          leading: Checkbox(
            value: vaccSettings.value,
            onChanged: (val) => onClicked(),
          ),
          title: Text(
            '${vaccSettings.title}',
            style: TextStyle(
              color: Colors.indigo[900],
              wordSpacing: 2,
              fontSize: 18,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: modifyGoal, icon: Icon(Icons.house_siding_outlined))
        ],
        title: (goal == null)
            ? Text(
                'Goal : ',
                style: TextStyle(color: Colors.white, fontSize: 20),
              )
            : Text(
                'Goal : $goal %',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 30),
        height: MediaQuery.of(context).size.height *4,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.blue[500], borderRadius: BorderRadius.circular(40)),
        child: ListView(
          children: [
            Text(
              '${widget.data['babyName'].toString().toUpperCase()}',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            buildDivider(),
            Text(
              'Birthdate : ${widget.data['babyBirthday'].toString().toUpperCase()}',
              style: TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            buildDivider(),
            Text(
              '${widget.data['babyGender']}',
              style: TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            buildDivider(),
            ...vaccList.map((e) => buildSingleCheckbox(e)).toList()
          ],
        ),
      ),
    );
  }
}
