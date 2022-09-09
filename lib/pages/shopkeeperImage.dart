import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pucopoint_manager/model/pucoreads.dart';
import 'package:pucopoint_manager/pages/shopImage.dart';
import 'package:pucopoint_manager/utils/uploadimage.dart';

class shopkeeperImage extends StatefulWidget {
  final Pucopoint pucopoint;
  const shopkeeperImage({Key? key, required this.pucopoint}) : super(key: key);

  @override
  State<shopkeeperImage> createState() => _shopkeeperImageState();
}

// ignore: camel_case_types
class _shopkeeperImageState extends State<shopkeeperImage> {
  TextEditingController userInput = TextEditingController();
  String shopkeeperNetworkImage = "";
  bool change = false;
  String text = "";
  late File? imageFile = null;

  bool isloading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FocusScope.of(context).unfocus();
  }

  /// Widget
  @override
  Widget build(BuildContext context) {
    print("see here :${widget.pucopoint.name}");
    if (widget.pucopoint.shopkeeperImageUrl != "" && !change) {
      shopkeeperNetworkImage = widget.pucopoint.shopkeeperImageUrl;
    }
    ;

    return Scaffold(
        appBar: AppBar(
          title: Text("Shopkeeper Image"),
        ),
        body: Container(
            child: imageFile == null && shopkeeperNetworkImage == ""
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
                          child: Text("upload shopkeeper image"),
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
                        ),
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
                              height: 20,
                            ),
                            Positioned(
                              child: Center(
                                child: !isloading
                                    ? SizedBox(
                                        height: 300,
                                        child: shopkeeperNetworkImage == ""
                                            ? Image.file(
                                                imageFile!,
                                              )
                                            : Image.network(
                                                shopkeeperNetworkImage,
                                              ),
                                      )
                                    : const SizedBox(
                                        child: CircularProgressIndicator()),
                              ),
                            ),
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
                                    customBorder: CircleBorder(),
                                    borderRadius: BorderRadius.circular(25),
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
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        change = true;
        shopkeeperNetworkImage = "";
        imageFile = File(pickedFile.path);
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        change = true;
        shopkeeperNetworkImage = "";
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

        setState(() {
          isloading = true;
        });
        
        var uploadimage = "";
        if (shopkeeperNetworkImage == "") {
          uploadimage =
              await UploadImageFile().uploadFile(imageFile, id, "shopkeeper");
        }

        print("upload image: $uploadimage");

        if (uploadimage != "error") {
          pucopoint.shopkeeperImageUrl = shopkeeperNetworkImage == ""
              ? uploadimage
              : shopkeeperNetworkImage;
          // print(pucopoint.shopkeeperImageUrl);
          setState(() {
            isloading = false;
          });

          if (shopkeeperNetworkImage == "") {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('successfully uploaded'),
              ),
            );
          }

          Get.to(shopImage(pucopoint: pucopoint));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('something went wrong'),
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

  // Future uploadFile() async {
  //   UploadTask? uploadTask;
  //   Pucopoint(shopkeeperImageUrl: fileID);
  //   var id = Pucopoint().shopkeeperImageUrl;
  //   final path = 'pucopoints/$id/shopkeeper';
  //   final file = File(imageFile!.path);
  //   final ref = FirebaseStorage.instance.ref().child(path);
  //   uploadTask = ref.putFile(file);
  //   var urlDownload = null;
  //   final snapshot = await uploadTask.whenComplete(() => {});
  //   urlDownload = await snapshot.ref.getDownloadURL();
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     isloading = false;
  //     if (!isloading) {
  //       if (urlDownload != null) {
  //         Pucopoint(shopkeeperImageUrl: urlDownload);
  //         Pucopoint().shopkeeperImageUrl = urlDownload;
  //         var r = Pucopoint().shopkeeperImageUrl;
  //         print('Download link: $r');
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(
  //             content: Text('Image uploaded successfully'),
  //           ),
  //         );
  //         Get.to(shopImage());
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(
  //             content: Text('some error while uploading'),
  //           ),
  //         );
  //       }
  //     }
  //   });
  // }
}
