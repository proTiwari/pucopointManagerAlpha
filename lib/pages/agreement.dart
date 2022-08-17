import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pucopoint_manager/model/pucoreads.dart';
import 'package:pucopoint_manager/pages/pucopointList.dart';
import 'package:pucopoint_manager/pages/agreementDocument.dart';
import 'dart:ui' as ui;
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class agreement extends StatefulWidget {
  final Pucopoint pucopoint;
  agreement({Key? key, required this.pucopoint}) : super(key: key);

  @override
  State<agreement> createState() => _agreementState();
}

class _agreementState extends State<agreement> {
  var refer = FirebaseFirestore.instance.collection('pucopoints').doc();
  bool isloading = false;
  bool clean = false;
  bool? agree = false;
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();
  bool? value = false;
  @override
  void initState() {
    super.initState();
  }

  void _handleClearButtonPressed() {
    clean = false;
    signatureGlobalKey.currentState!.clear();
  }

  Future<Uint8List> _handleSaveButtonPressed() async {
    final data =
        await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    Uint8List listData = await bytes!.buffer.asUint8List();
    return listData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Agreement"),
        ),
        body: Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                      child: SfSignaturePad(
                        key: signatureGlobalKey,
                        backgroundColor: Colors.white,
                        strokeColor: Colors.black,
                        minimumStrokeWidth: 1.0,
                        maximumStrokeWidth: 4.0,
                        onDrawStart: () {
                          print("ondrawstart");
                          return false;
                        },
                        onDraw: (offset, time) {
                          Offset offsetValue = offset;
                          DateTime dateTime = time;
                          print("on draw");
                        },
                        onDrawEnd: () {
                          clean = true;
                          print(
                              "Signature has been completed in Signature Pad");
                        },
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey)))),
              SizedBox(height: 10),
              Row(children: <Widget>[
                TextButton(
                  child:
                      isloading ? CircularProgressIndicator() : Text('Clear'),
                  onPressed: _handleClearButtonPressed,
                )
              ], mainAxisAlignment: MainAxisAlignment.spaceEvenly),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ), //SizedBox
                  //Text
                  //SizedBox
                  /** Checkbox Widget **/
                  Checkbox(
                    value: value,
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                        agree = value;
                      });
                    },
                  ),
                  SizedBox(width: 10),
                  InkWell(
                      child: const Text(
                        'agree to terms and conditions',
                        style: TextStyle(
                            color: Colors.deepPurpleAccent, fontSize: 17.0),
                      ),
                      onTap: () => {Get.to(agreementDocument())}),
                  // Text(
                  //   'agree to terms and conditions',
                  //   style: TextStyle(fontSize: 17.0),
                  // ), //Checkbox
                ], //<Widget>[]
              ),
              SizedBox(
                height: 30,
              ),
              buttonwidgets()
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center));
  }

  buttonwidgets() {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width - 60,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              'Continue',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      onTap: () async {
        Pucopoint pucopoint = widget.pucopoint;
        UploadTask? uploadTask;
        var urlDownload = null;
        var id = pucopoint.imagefileId;
        if (agree != false && clean == true) {
          setState(() {
            isloading = true;
          });
          var image = await _handleSaveButtonPressed();
          final path = 'pucopoints/$id/signature';
          final ref = FirebaseStorage.instance.ref().child(path);
          uploadTask = ref.putData(image);

          final snapshot = await uploadTask.whenComplete(() => {});
          urlDownload = await snapshot.ref.getDownloadURL();
          // printWrapped("${pucopoint.shopkeeperImageUrl}");
          final FirebaseAuth auth = FirebaseAuth.instance;
          final User? user = auth.currentUser;
          final uid = user?.uid;
          pucopoint.manager = uid!;

          DocumentSnapshot docSnap = await refer.get();
          var doc_id2 = docSnap.reference.id;

          pucopoint.signaturePad = urlDownload;
          if (urlDownload != null &&
              pucopoint.aadhar != "" &&
              pucopoint.aadharImageUrl != "" &&
              pucopoint.altPhone != "" &&
              pucopoint.city != "" &&
              pucopoint.country != "" &&
              pucopoint.email != "" &&
              pucopoint.geohash != "" &&
              pucopoint.lat != 0.00 &&
              pucopoint.long != 0.00 &&
              pucopoint.manager != "" &&
              pucopoint.name != "" &&
              pucopoint.phone != "" &&
              pucopoint.pincode != "" &&
              pucopoint.shopImageUrl != "" &&
              pucopoint.shopName != "" &&
              pucopoint.shopkeeperImageUrl != "" &&
              pucopoint.signaturePad != "" &&
              pucopoint.state != "" &&
              pucopoint.streetAddress != "" &&
              pucopoint.username != "") {
            await refer.set({
              "aadhar": "${pucopoint.aadhar}",
              "aadharImageUrl": "${pucopoint.aadharImageUrl}",
              "altPhone": "${pucopoint.altPhone}",
              "city": "${pucopoint.city}",
              "country": "${pucopoint.country}",
              "email": "${pucopoint.email}",
              "geohash": "${pucopoint.geohash}",
              "lat": "${pucopoint.lat}",
              "long": "${pucopoint.long}",
              "manager": "${pucopoint.manager}",
              "name": "${pucopoint.name}",
              "phone": "${pucopoint.phone}",
              "pincode": "${pucopoint.pincode}",
              "shopImageUrl": "${pucopoint.shopImageUrl}",
              "shopName": "${pucopoint.shopName}",
              "shopkeeperImageUrl": "${pucopoint.shopkeeperImageUrl}",
              "signaturePad": "${pucopoint.signaturePad}",
              "state": "${pucopoint.state}",
              "streetAddress": "${pucopoint.streetAddress}",
              "username": "${pucopoint.username}",
              "id": "$doc_id2"
            });
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Registered successfully'),
              ),
            );
            setState(() {
              isloading = false;
            });
            Get.to(PucopointList());
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('error while uploading'),
              ),
            );
            setState(() {
              isloading = false;
            });
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('signature is not done or agreement is not checked'),
            ),
          );
        }

        // if (_formKey.currentState!.validate()) {
        // Get.changeTheme(ThemeData.dark());
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(
        //       content: Text('Logged in successfully'),
        //     ),
        //   );
        // } else {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(
        //       content: Text('Please fill all fields'),
        //     ),
        //   );
        // }
      },
    );
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
}
