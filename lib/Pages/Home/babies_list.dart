import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacc_app/Pages/Home/baby_details.dart';
import 'package:vacc_app/Pages/Services/database.dart';
import 'package:vacc_app/Pages/Services/userModel.dart';
import 'package:vacc_app/Pages/loading.dart';

class BabiesList extends StatefulWidget {
  @override
  _BabiesListState createState() => _BabiesListState();
}

class _BabiesListState extends State<BabiesList> {
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserModel>(context);
    return ChangeNotifierProvider<DatabaseService>(
      create: (context) => DatabaseService(),
      child: Consumer<DatabaseService>(
        builder: (ctx, _service, _) {
          return (_service.babies.length != 0)
              ? ListView.builder(
                  itemCount: _service.babies.length,
                  itemBuilder: (context, item) {
                    return GestureDetector(
                      onLongPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BabyDetails(_service.babies[item])));
                      },
                      child: Container(
                          height: MediaQuery.of(context).size.height / 8,
                          margin: EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.blue[600],
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(15),
                            title: Text(
                              "${_service.babies[item]['babyName'].toString().toUpperCase()}",
                              style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 4,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            leading: Icon(
                              Icons.face,
                              color: Colors.black,
                              size: 30,
                            ),
                          )),
                    );
                  })
              : Loading();
        },
      ),
    );
  }
}
