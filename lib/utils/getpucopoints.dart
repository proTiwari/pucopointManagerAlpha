import 'package:cloud_firestore/cloud_firestore.dart';
 
 Future getPucopoint() async {

    var data = await FirebaseFirestore.instance.collection('pucopoints').get();
    var lis = List.from(data.docs.map((e) => e));
    return lis;
  }