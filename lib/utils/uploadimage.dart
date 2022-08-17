import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pucopoint_manager/model/pucoreads.dart';


class UploadImageFile {
  Future uploadFile(File? imageFile, String id, String Name,) async {
    UploadTask? uploadTask;
    Pucopoint pucopoint = Pucopoint();
    final path = 'pucopoints/$id/$Name';
    final file = File(imageFile!.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    var urlDownload = null;
    final snapshot = await uploadTask.whenComplete(() => {});
    urlDownload = await snapshot.ref.getDownloadURL();

    if (urlDownload != null) {
      return "$urlDownload";
    } else {
      return "error";
    }
    
  }
}
