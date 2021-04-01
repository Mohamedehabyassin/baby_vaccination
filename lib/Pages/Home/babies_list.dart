import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacc_app/Pages/loading.dart';
class BabiesList extends StatefulWidget {
  @override
  _BabiesListState createState() => _BabiesListState();
}

class _BabiesListState extends State<BabiesList> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("init");
  }

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<QuerySnapshot>(context);

print(users);



    return users.docs == null ?  Center(
  child: Text("Welcome to our Database"),
): Loading() ;
  }
}
//
// Widget getContent(BuildContext context) {
//   return StreamBuilder<QuerySnapshot>(
//     stream: Firestore.instance.collection("posts").snapshots(),
//     builder: (context, snap) {
//
//       //just add this line
//       if(snap.data == null) return CircularProgressIndicator();
//
//       return CarouselSlider(
//         enlargeCenterPage: true,
//         height: MediaQuery.of(context).size.height,
//         items: getItems(context, snap.data.documents),
//       );
//     },
//   );
// }
//
// List<Widget> getItems(BuildContext context, List<DocumentSnapshot>
// docs){
//   return docs.map(
//           (doc) {
//         String content = doc.data["content"];
//         return Text(content);
//       }
//   ).toList();
// }