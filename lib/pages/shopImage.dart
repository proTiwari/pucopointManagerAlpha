import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pucopoint_manager/model/pucoreads.dart';
import 'package:pucopoint_manager/pages/aadhaarCardImage.dart';
import 'package:pucopoint_manager/utils/uploadimage.dart';


class shopImage extends StatefulWidget {
  final Pucopoint pucopoint;
  shopImage({Key? key, required this.pucopoint}) : super(key: key);

  @override
  State<shopImage> createState() => _shopImageState();
}

class _shopImageState extends State<shopImage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController userInput = TextEditingController();
  String text = "";
  late File? imageFile = null;
  String shopname = "";

  bool isloading = false;

  /// Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Shop Image"),
        ),
        body: Container(
            child: imageFile == null
                ? Container(
                    alignment: Alignment.center,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 420,
                          left: 310,
                          child: SizedBox.fromSize(
                            size: Size(56, 56),
                            child: Material(
                              shape: CircleBorder(),
                              color: Colors.amberAccent,
                              child: InkWell(
                                splashColor: Colors.green,
                                onTap: () {
                                  _getFromGallery();
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    Icon(Icons.photo_album_outlined),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 350,
                          left: 310,
                          child: SizedBox.fromSize(
                            size: Size(56, 56),
                            child: Material(
                              shape: CircleBorder(),
                              color: Colors.amberAccent,
                              child: InkWell(
                                splashColor: Colors.green,
                                onTap: () {
                                  _getFromCamera();
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    Icon(Icons.camera_alt),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Center(
                    child: Container(
                      alignment: Alignment.center,
                      child: Center(
                        child: Stack(
                          children: <Widget>[
                            const SizedBox(
                              height: 200,
                            ),
                            Positioned(
                              child: Center(
                                child: !isloading
                                    ? SizedBox(
                                        height: 300,
                                        child: Image.file(
                                          imageFile!,
                                        ),
                                      )
                                    : SizedBox(
                                        child: CircularProgressIndicator()),
                              ),
                            ),
                            Container(
                                child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    controller: userInput,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 6,
                                      ),
                                      hintText: 'Enter Shop Name',
                                      hintStyle: const TextStyle(fontSize: 14),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.white, width: 0.5),
                                      ),
                                    ),
                                    validator: (value) {
                                      shopname = value.toString();
                                      if (value!.isEmpty) {
                                        return 'Please enter shop name';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                              ),
                            )),
                            Positioned(
                              top: 420,
                              left: 310,
                              child: SizedBox.fromSize(
                                size: Size(56, 56),
                                child: Material(
                                  shape: CircleBorder(),
                                  color: Colors.amberAccent,
                                  child: InkWell(
                                    splashColor: Colors.green,
                                    onTap: () {
                                      _getFromGallery();
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const <Widget>[
                                        Icon(Icons.photo_album_outlined),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 350,
                              left: 310,
                              child: SizedBox.fromSize(
                                size: Size(56, 56),
                                child: Material(
                                  shape: CircleBorder(),
                                  color: Colors.amberAccent,
                                  child: InkWell(
                                    splashColor: Colors.green,
                                    onTap: () {
                                      _getFromCamera();
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const <Widget>[
                                        Icon(Icons.camera_alt),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 500,
                              left: 30,
                              child: Center(
                                child: Material(
                                  child: InkWell(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        buttonwidgets(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )));
  }

  /// Get from gallery
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 800,
      maxHeight: 800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
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
        var id = pucopoint.imagefileId;

        if (_formKey.currentState!.validate()) {
          setState(() {
            isloading = true;
          });
          var uploadimage =
              await UploadImageFile().uploadFile(imageFile, id, "shop");
          if (uploadimage != "error") {
            pucopoint.shopImageUrl = uploadimage;
            pucopoint.shopName = shopname;

            setState(() {
              isloading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('successfully uploaded'),
              ),
            );

            Get.to(aadhaarCardImage(pucopoint:pucopoint));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('something went wrong'),
              ),
            );
          }
        }

        // Get.to(aadhaarCardImage());
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
}
