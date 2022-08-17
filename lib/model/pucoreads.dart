import 'package:cloud_firestore/cloud_firestore.dart';

class Pucopoint {
  String imagefileId;
  String aadhar;
  String aadharImageUrl;
  String altCountryCode;
  String altPhone;
  String city;
  String country;
  String email;
  String geohash;
  double lat;
  double long;
  String manager;
  String name;
  String phone;
  String phoneCountryCode;
  String phoneNum;
  String pid;
  String pincode;
  String shopImageUrl;
  String shopName;
  String shopkeeperImageUrl;
  String signaturePad;
  String state;
  String streetAddress;
  String username;

  Pucopoint({
    this.imagefileId = "",
    this.aadhar = "",
    this.aadharImageUrl = "",
    this.altCountryCode = "",
    this.altPhone = "",
    this.city = "",
    this.country = "",
    this.phoneCountryCode = "",
    this.name = "",
    this.email = "",
    this.username = "",
    this.state = "",
    this.streetAddress = "",
    this.shopImageUrl = "",
    this.shopName = "",
    this.shopkeeperImageUrl = "",
    this.signaturePad = "",
    this.pid = "",
    this.phone = "",
    this.phoneNum = "",
    this.pincode = "",
    this.manager = "",
    this.lat = 0.00,
    this.long = 0.00,
    this.geohash = "",
  });

  factory Pucopoint.fromDocumentSnapshot(pucoSnapshot) {
    return Pucopoint(
      imagefileId: pucoSnapshot.data()!["imagefileId"],
      name: pucoSnapshot.data()!["name"],
      email: pucoSnapshot.data()!["email"],
      phone: pucoSnapshot.data()!["phone"],
      phoneCountryCode: pucoSnapshot.data()!["phoneCountryCode"],
      phoneNum: pucoSnapshot.data()!["phoneNum"],
      pid: pucoSnapshot.data()!["pid"],
      pincode: pucoSnapshot.data()!["pincode"],
      altPhone: pucoSnapshot.data()!["altPhone"],
      shopImageUrl: pucoSnapshot.data()!["shopImageUrl"],
      shopName: pucoSnapshot.data()!["shopName"],
      shopkeeperImageUrl: pucoSnapshot.data()!["shopkeeperImageUrl"],
      signaturePad: pucoSnapshot.data()!["signaturePad"],
      state: pucoSnapshot.data()!["state"],
      streetAddress: pucoSnapshot.data()!["streetAddress"],
      city: pucoSnapshot.data()!["city"],
      country: pucoSnapshot.data()!["country"],
      manager: pucoSnapshot.data()!["manager"],
      // lat: pucoSnapshot.data()!["lat"],
      // long: pucoSnapshot.data()!["long"],
      geohash: pucoSnapshot.data()!["geohash"],
      username: pucoSnapshot.data()!["username"],
      aadhar: pucoSnapshot.data()!["aadhar"],
      aadharImageUrl: pucoSnapshot.data()!["aadharImageUrl"],
      altCountryCode: pucoSnapshot.data()!["altCountryCode"],
  
    );
  }
}
