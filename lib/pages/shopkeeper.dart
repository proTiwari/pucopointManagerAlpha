import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:dart_geohash/dart_geohash.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pucopoint_manager/model/pucoreads.dart';
import 'package:pucopoint_manager/pages/pucopointList.dart';
import 'package:pucopoint_manager/pages/shopkeeperImage.dart';
import 'package:pucopoint_manager/utils/location.dart';
import 'package:uuid/uuid.dart';
import '../widgets/verticalSpacing.dart';

class Shopkeeper extends StatefulWidget {
  const Shopkeeper({Key? key}) : super(key: key);

  @override
  State<Shopkeeper> createState() => _ShopkeeperState(pucopoint: Pucopoint());
}

class _ShopkeeperState extends State<Shopkeeper> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  String fileID = const Uuid().v4();
  final GlobalKey<FormState> altformKey = GlobalKey<FormState>();
  GlobalKey<CSCPickerState> _cscPickerKey = GlobalKey();
  final TextEditingController controller = TextEditingController();
  final TextEditingController altcontroller = TextEditingController();
  Pucopoint pucopoint = Pucopoint();
  _ShopkeeperState({required this.pucopoint});
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  PhoneNumber altnumber = PhoneNumber(isoCode: 'IN');

  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  String name = "";
  String email = "";

  String phone = "";
  String altphone = "";

  String streetAddress = "";
  String postcode = "";
  double latitude = 0.00;
  double longitude = 0.00;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  FocusScope.of(context).unfocus();
  }

//  get context => context;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _registeration();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Shopkeeper Information'),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                form(),
                verticalSpacing(10),
                shop(),

                // buttonwidgets()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget form() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          verticalSpacing(20),
          nameInput(),
          verticalSpacing(10),
          emailInput(),
          verticalSpacing(10),
          Phonenumber(),
          verticalSpacing(10),
          AltPhoneNumber()
        ],
      ),
    );
  }

  Widget Phonenumber() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      // key: _formKey,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                print(number.phoneNumber);
              },
              onInputValidated: (bool value) {
                print(value);
              },
              selectorConfig: SelectorConfig(
                selectorType: PhoneInputSelectorType.DIALOG,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              selectorTextStyle: TextStyle(color: Colors.black),
              initialValue: number,
              textFieldController: controller,
              formatInput: false,
              keyboardType:
                  TextInputType.numberWithOptions(signed: true, decimal: true),
              inputBorder: OutlineInputBorder(),
              onSaved: (PhoneNumber number) {
                phone = number.toString();
              },
              validator: (value) {
                phone = value.toString();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget AltPhoneNumber() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      key: altformKey,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber altnumber) {
                print(altnumber.phoneNumber);
              },
              onInputValidated: (bool value) {
                print(value);
              },
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.DIALOG,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              selectorTextStyle: TextStyle(color: Colors.black),
              initialValue: altnumber,
              hintText: "Alt Phone no.",
              textFieldController: altcontroller,
              formatInput: false,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
              inputBorder: OutlineInputBorder(),
              onSaved: (PhoneNumber altnumber) {
                altphone = altnumber.toString();
              },
              validator: (value) {
                altphone = value.toString();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget emailInput() {
    return Padding(
      // key: _formKey,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 6,
          ),
          hintText: 'Email',
          hintStyle: const TextStyle(fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white, width: 0.5),
          ),
        ),
        validator: (value) {
          email = value.toString();
          if (value!.isEmpty) {
            return 'Please enter your email';
          }
          if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)) {
            return 'Please enter a valid email';
          }
          return null;
        },
        onSaved: (value) {
          email = value.toString();
        },
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber);

    setState(() {
      this.number = number;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget nameInput() {
    return Padding(
      // key: _formKey,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 6,
          ),
          hintText: 'Name',
          hintStyle: const TextStyle(fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white, width: 0.5),
          ),
        ),
        validator: (value) {
          name = value.toString();
          if (value!.isEmpty) {
            return 'Please enter your name';
          }
          return null;
        },
        onSaved: (value) {
          name = value.toString();
        },
        keyboardType: TextInputType.text,
      ),
    );
  }

  Widget shop() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 400,
        child: Column(
          children: [
            ///Adding CSC Picker Widget in app
            CSCPicker(
              ///Enable disable state dropdown [OPTIONAL PARAMETER]
              showStates: true,

              /// Enable disable city drop down [OPTIONAL PARAMETER]
              showCities: true,

              ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
              flagState: CountryFlag.DISABLE,

              ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
              dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300, width: 1)),

              ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
              disabledDropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey.shade300,
                  border: Border.all(color: Colors.grey.shade300, width: 1)),

              ///placeholders for dropdown search field
              countrySearchPlaceholder: "Country",
              stateSearchPlaceholder: "State",
              citySearchPlaceholder: "City",

              ///labels for dropdown
              countryDropdownLabel: "*Country",
              stateDropdownLabel: "*State",
              cityDropdownLabel: "*City",

              ///Default Country
              defaultCountry: DefaultCountry.India,

              ///Disable country dropdown (Note: use it with default country)
              //disableCountry: true,

              ///selected item style [OPTIONAL PARAMETER]
              selectedItemStyle: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),

              ///DropdownDialog Heading style [OPTIONAL PARAMETER]
              dropdownHeadingStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),

              ///DropdownDialog Item style [OPTIONAL PARAMETER]
              dropdownItemStyle: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),

              ///Dialog box radius [OPTIONAL PARAMETER]
              dropdownDialogRadius: 10.0,

              ///Search bar radius [OPTIONAL PARAMETER]
              searchBarRadius: 10.0,

              ///triggers once country selected in dropdown
              onCountryChanged: (value) {
                setState(() {
                  ///store value in country variable
                  countryValue = value;
                });
              },

              ///triggers once state selected in dropdown
              onStateChanged: (value) {
                setState(() {
                  ///store value in state variable
                  stateValue = value.toString();
                });
              },

              ///triggers once city selected in dropdown
              onCityChanged: (value) {
                setState(() {
                  ///store value in city variable
                  cityValue = value.toString();
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey2,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Flexible(
                            child: new TextFormField(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 6,
                                ),
                                hintText: latitude == 0.00
                                    ? 'latitude'
                                    : latitude.toString(),
                                hintStyle: const TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 0.5),
                                ),
                              ),
                              validator: (value) {
                                value = latitude.toString();
                                if (value.isEmpty || !value.isNum) {
                                  return 'invalid';
                                }
                                latitude = double.parse(value) as double;
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          new Flexible(
                            child: new TextFormField(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 6,
                                ),
                                hintText: longitude == 0.00
                                    ? 'lognitude'
                                    : longitude.toString(),
                                hintStyle: const TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 0.5),
                                ),
                              ),
                              validator: (value) {
                                value = longitude.toString();
                                if (value.isEmpty || !value.isNum) {
                                  return 'invalid';
                                }
                                longitude = double.parse(value) as double;
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          new Flexible(
                            child: new TextFormField(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 6,
                                ),
                                hintText:
                                    postcode == "" ? 'postcode' : postcode,
                                hintStyle: const TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 0.5),
                                ),
                              ),
                              validator: (value) {
                                value = postcode;

                                if (value.isEmpty || !value.isNum) {
                                  return 'invalid';
                                }
                                postcode = value;
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 6,
                          ),
                          hintText: 'street address',
                          hintStyle: const TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 0.5),
                          ),
                        ),
                        validator: (value) {
                          streetAddress = value.toString();
                          if (value!.isEmpty) {
                            return 'Please enter street address';
                          }
                          streetAddress = value;
                          return null;
                        },
                        onSaved: (value) {
                          streetAddress = value.toString();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            verticalSpacing(10),
            GestureDetector(
              child: Container(
                width: MediaQuery.of(context).size.width - 60,
                height: 50,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      'Get Location',
                      style: TextStyle(
                        color: Color.fromARGB(255, 244, 86, 86),
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () async {
                var loc = await MyLocation().getLoc();
                print(loc[2].addressLine);
                var l = loc[2].addressLine.toString().split(',');
                var Ll = l.length;
                var postC = l[Ll - 2].toString();
                var lenC = postC.length;
                postcode = postC.substring(lenC - 6);
                print(postC);
                latitude = loc[0];
                longitude = loc[1];
                setState(() {
                  postcode;
                  latitude;
                  longitude;
                });
                print(loc);
              },
            ),

            verticalSpacing(20),
            GestureDetector(
              child: Container(
                width: MediaQuery.of(context).size.width - 60,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.amber,
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
                // Get.to(shopkeeperImage());
                if (_formKey.currentState!.validate()) {
                  if (stateValue == null || stateValue == "*State") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('state is null'),
                      ),
                    );
                  } else if (cityValue == null || cityValue == "*City") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('city is null'),
                      ),
                    );
                  } else {
                    if (_formKey2.currentState!.validate()) {
                      var username = email.split("@");
                      var userName = username[0];
                      pucopoint.name = name;
                      pucopoint.email = email;
                      pucopoint.phone = phone;
                      pucopoint.altPhone = altphone;
                      pucopoint.country = countryValue;
                      pucopoint.city = cityValue;
                      pucopoint.state = stateValue;
                      pucopoint.pincode = postcode;
                      pucopoint.lat = latitude;
                      pucopoint.long = longitude;
                      pucopoint.streetAddress = streetAddress;
                      pucopoint.imagefileId = fileID;
                      pucopoint.username = userName;
                      GeoHasher geoHasher = GeoHasher();
                      var geohash = geoHasher.encode(-98, 38);
                      pucopoint.geohash = geohash;
                      Get.to(shopkeeperImage(pucopoint: pucopoint));
                      // SharedPreferences.setMockInitialValues({});
                      // final prefs = await SharedPreferences.getInstance();
                      // await prefs.setDouble('lat', latitude);
                      // await prefs.setDouble('long', longitude);
                      // await prefs.setString('name', nameController.text);
                      // await prefs.setString('email', emailController.text);
                      // await prefs.setString('postcode', postcode);
                      // await prefs.setString('country', countryValue);
                      // await prefs.setString('state', stateValue);
                      // await prefs.setString('streetAddress', streetAddress);
                      // await prefs.setString('city', cityValue);
                      // await prefs.setString('phone', controller.text);
                      // await prefs.setString('altphone', altcontroller.text);
                      // await prefs.setString('id', fileID);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('fill location fields correctly'),
                        ),
                      );
                    }
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill all fields'),
                    ),
                  );
                }
              },
            )
          ],
        ));
  }

  Future<void> _registeration() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure you want to discard registration?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Get.to(PucopointList());
              },
            ),
          ],
        );
      },
    );
  }
}
