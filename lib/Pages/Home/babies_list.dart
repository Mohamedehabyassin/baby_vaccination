import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacc_app/Pages/Services/database.dart';
import 'package:vacc_app/Pages/loading.dart';

class BabiesList extends StatefulWidget {

  @override
  _BabiesListState createState() => _BabiesListState();
}

class _BabiesListState extends State<BabiesList> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DatabaseService>(
      create: (context) => DatabaseService(),
      child: Consumer<DatabaseService>(
        builder: (ctx,_service,_){
          //var uid = int.parse(_service.uid);
          return (_service.userCollection.doc(_service.uid) == null )?
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child:Text("Hi")),
                 // ElevatedButton(onPressed:() => _service.addUser("SaWy", "Male"), child: Text("add user"))
                ],
              ): Loading();
        },
      ),

    )  ; }
}
