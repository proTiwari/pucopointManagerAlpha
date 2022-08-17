import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'; 
 
 Future getPucopoint() async {
    // setState(() {
    //   _isLoading = true;
    // });

    var data = await FirebaseFirestore.instance.collection('pucopoints').get();
    var lis = List.from(data.docs.map((e) => e));

    // setState(() {
    //   lis;
    //   resultsList = lis;
    // });
    // if (lis != []) {
    //   _isLoading = false;
    // }
    return lis;
  }