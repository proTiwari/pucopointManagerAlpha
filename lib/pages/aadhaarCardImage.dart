import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pucopoint_manager/model/pucoreads.dart';
import 'package:pucopoint_manager/pages/agreement.dart';

import '../utils/uploadimage.dart';

class aadhaarCardImage extends StatefulWidget {
  final Pucopoint pucopoint;
  aadhaarCardImage({Key? key, required this.pucopoint}) : super(key: key);

  @override
  State<aadhaarCardImage> createState() => _aadhaarCardImageState();
}

class _aadhaarCardImageState extends State<aadhaarCardImage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String aadharNetworkImage = "";
  bool change = false;
  bool isloading = false;
  TextEditingController userInput = TextEditingController();
  String aadhaarnumber = "";
  late File? imageFile = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FocusScope.of(context).unfocus();
  }

  /// Widget
  @override
  Widget build(BuildContext context) {
    if (widget.pucopoint.aadharImageUrl != "" && !change) {
      aadharNetworkImage = widget.pucopoint.aadharImageUrl;
      userInput.text = widget.pucopoint.aadhar;
    }
    ;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Aadhaar Image"),
        ),
        body: Container(
            child: imageFile == null && aadharNetworkImage == ""
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
                        Center(
                          child: Text("upload aadhaar image"),
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
                                        child: aadharNetworkImage == ""
                                            ? Image.file(
                                                imageFile!,
                                              )
                                            : Image.network(
                                                aadharNetworkImage,
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
                                      hintText: 'Enter aadhaar number',
                                      hintStyle: const TextStyle(fontSize: 14),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.white, width: 0.5),
                                      ),
                                    ),
                                    validator: (value) {
                                      aadhaarnumber = value.toString();
                                      if (value!.isEmpty) {
                                        if (value.isNum) {
                                          return 'wrong aadhaar number formating';
                                        }
                                        return 'Please enter aadhaar number';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) => widget.pucopoint.aadhar = value,
                                    keyboardType: TextInputType.number,
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
        change = true;
        aadharNetworkImage = "";
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
        change = true;
        aadharNetworkImage = "";
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
        if (_formKey.currentState!.validate() && aadhaarnumber.length == 12) {
          setState(() {
            isloading = true;
          });

          var uploadimage = "";
          if (aadharNetworkImage == "") {
            uploadimage =
                await UploadImageFile().uploadFile(imageFile, id, "aadhaar");
          }
          if (uploadimage != "error") {
            pucopoint.aadharImageUrl =
                aadharNetworkImage == "" ? uploadimage : aadharNetworkImage;
            pucopoint.aadhar = aadhaarnumber;

            setState(() {
              isloading = false;
            });

            if (aadharNetworkImage == "") {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('successfully uploaded'),
                ),
              );
            }

            Get.to(agreement(pucopoint: pucopoint));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('something went wrong'),
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('check your aadhaar number'),
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
}
