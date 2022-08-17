import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePick extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<ImagePick> {
  /// Variables
  TextEditingController userInput = TextEditingController();
  String text = "";
  late File? imageFile = null;

  /// Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Shopkeeper Image"),
        ),
        body: Container(
            child: imageFile == null
                ? Container(
                    alignment: Alignment.center,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 420,
                          left: 340,
                          child: SizedBox.fromSize(
                            size: Size(56, 56),
                            child: Material(
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
                          left: 340,
                          child: SizedBox.fromSize(
                            size: Size(56, 56),
                            child: Material(
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
                                child: SizedBox(
                                  height: 300,
                                  child: Image.file(
                                    imageFile!,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                child: SingleChildScrollView(
                              child: TextFormField(
                                controller: userInput,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.person),
                                  hintText: '',
                                  labelText: 'Shopkeeper Name*',
                                ),
                                onSaved: (String? value) {
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                                onChanged: (value) {
                                  setState(() {
                                    userInput.text = value.toString();
                                  });
                                },
                                validator: (String? value) {
                                  return (value != null && value.contains('@'))
                                      ? 'Do not use the @ char.'
                                      : null;
                                },
                              ),
                            )),
                            Positioned(
                              top: 420,
                              left: 340,
                              child: SizedBox.fromSize(
                                size: Size(56, 56),
                                child: Material(
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
                              left: 340,
                              child: SizedBox.fromSize(
                                size: Size(56, 56),
                                child: Material(
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
      onTap: () {
        // Get.to();
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
