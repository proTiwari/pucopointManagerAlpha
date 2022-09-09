import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:pucopoint_manager/pages/pucopointList.dart';
import 'package:pucopoint_manager/widgets/verticalSpacing.dart';

class ShopkeeperCompleteInfo extends StatefulWidget {
  final lis;
  ShopkeeperCompleteInfo({Key? key, this.lis}) : super(key: key);

  @override
  State<ShopkeeperCompleteInfo> createState() => _ShopkeeperCompleteInfoState();
}

class _ShopkeeperCompleteInfoState extends State<ShopkeeperCompleteInfo> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => PucopointList()),
    );
  }

  Widget _buildFullscreenImage(list) {
    return Image.network(
      '$list',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    SizedBox(
      height: 60,
    );
    return Image.network('$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    dynamic list = widget.lis;
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.fromLTRB(0, 76, 0, 0),
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,

      // globalHeader: Align(
      //   alignment: Alignment.topRight,
      //   child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.only(top: 16, right: 16),
      //     ),
      //   ),
      // ),
      globalFooter: SizedBox(
        width: double.infinity,
        height: 20,
        // child: ElevatedButton(
        //   child: const Text(
        //     'Let\'s go right away!',
        //     style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        //   ),
        //   onPressed: () => _onIntroEnd(context),
        // ),
      ),
      pages: [
        PageViewModel(
          title: "Shopkeeper information",
          body:
              "Name : ${list['name']}  \n  Email : ${list['email']} \n Phone : ${list['phone']}  \n  alt phone : ${list['altPhone']} ",
          image: _buildImage('${list['shopkeeperImageUrl']}'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Shop information",
          body:
              "Country : ${list['country']}  \n  State : ${list['state']} \n City : ${list['city']}  \n  latitude : ${list['lat']} \n longitude : ${list['long']}  \n  postcode : ${list['pincode']} \n Street Address : ${list['streetAddress']} \n Shop name : ${list['shopName']}",
          image: _buildImage('${list['shopImageUrl']}'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Aadhaar Image",
          body: "${list['aadhar']}",
          image: _buildImage('${list['aadharImageUrl']}'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Signature",
          body: "",
          image: _buildImage('${list['signaturePad']}'),
          // decoration: pageDecoration.copyWith(
          //   contentMargin: const EdgeInsets.symmetric(horizontal: 16),
          //   fullScreen: true,
          //   bodyFlex: 2,
          //   imageFlex: 3,
          // ),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color.fromARGB(255, 255, 255, 255),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.amber,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   dynamic list = widget.lis;
  //   print(list);
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text("Flutter Card"),
  //     ),
  //     body: SingleChildScrollView(
  //       child: Stack(
  //         children: [
  //           SizedBox(

  //             child: Column(
  //               children: [
  //                 SizedBox(
  //                   height: 300,
  //                   child: ListView(
  //                     // This next line does the trick.
  //                     scrollDirection: Axis.horizontal,
  //                     children: <Widget>[

  //                       Container(
  //                         width: 360.0,
  //                         color: Color.fromARGB(255, 255, 255, 255),
  //                         child: ClipRRect(
  //                             child: Image.network(list['shopkeeperImageUrl'],
  //                                 width: 163, height: 163, fit: BoxFit.cover)),
  //                       ),
  //                       Container(
  //                         width: 360.0,
  //                         color: Colors.blue,
  //                         child: ClipRRect(
  //                             child: Image.network(list['shopImageUrl'],
  //                                 width: 163, height: 163, fit: BoxFit.cover)),
  //                       ),
  //                       Container(
  //                         width: 360.0,
  //                         color: Colors.green,
  //                         child: ClipRRect(
  //                             child: Image.network(list['aadharImageUrl'],
  //                                 width: 163, height: 163, fit: BoxFit.cover)),
  //                       ),
  //                       Container(
  //                         width: 360.0,
  //                         color: Colors.yellow,
  //                         child: ClipRRect(
  //                             child: Image.network(list['signaturePad'],
  //                                 width: 163, height: 163, fit: BoxFit.cover)),
  //                       ),

  //                     ],
  //                   ),
  //                 ),
  //                  Padding(
  //                    padding: const EdgeInsets.all(18.0),
  //                    child: Text("Name : " +
  //                           list['name'] +
  //                           '\n' +
  //                           "Email : " +
  //                           list['email'] +
  //                           '\n' +
  //                           "Phone : " +
  //                           list['phone'] +
  //                           '\n' +
  //                           "Alt Phone : " +
  //                           list['altPhone'] +
  //                           '\n' +
  //                           "Country : " +
  //                           list['country'] +
  //                           '\n' +
  //                           "State : " +
  //                           list['state'] +
  //                           '\n' +
  //                           "City : " +
  //                           list['city'] +
  //                           '\n' +
  //                           "Pincode : " +
  //                           list['pincode'] +
  //                           '\n' +
  //                           "Street Address : " +
  //                           list['streetAddress'] +
  //                           '\n' +
  //                           "Latitude : " +
  //                           list['lat'] +
  //                           '\n' +
  //                           "Longitude : " +
  //                           list['long'] +
  //                           '\n' +
  //                           " ", style: TextStyle(fontSize: 25)),
  //                  ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

          
          // Card(
          //   child: Container(
          //     height: 250,
          //     color: Colors.white,
          //     child: ListView(
          //       scrollDirection: Axis.horizontal,
          //       children: [
          //         Center(

          //           child: Padding(
          //             padding: EdgeInsets.all(10),
          //             child: Expanded(
          //               child:ClipRRect(
          //                   borderRadius: BorderRadius.circular(100),
          //                   child: Image.network(list['shopkeeperImageUrl'],
          //                       width: 163, height: 163, fit: BoxFit.cover)),
          //               flex: 1,
          //             ),
          //           ),
          //         ),
          //         Expanded(
          //           child: Container(
          //             alignment: Alignment.bottomLeft,
          //             child: Column(
          //               children: [
          //                 Expanded(
          //                   flex: 5,
          //                   child: ListTile(
          //                     title: Text("Name : " +
          //                         list['name'] +
          //                         '\n' +
          //                         "Email : " +
          //                         list['email'] +
          //                         '\n' +
          //                         "Phone : " +
          //                         list['phone'] +
          //                         '\n' +
          //                         "Alt Phone : " +
          //                         list['altPhone'] +
          //                         '\n' +
          //                         "Country : " +
          //                         list['country'] +
          //                         '\n' +
          //                         "State : " +
          //                         list['state'] +
          //                         '\n' +
          //                         "City : " +
          //                         list['city'] +
          //                         '\n' +
          //                         "Pincode : " +
          //                         list['pincode'] +
          //                         '\n' +
          //                         "Street Address : " +
          //                         list['streetAddress'] +
          //                         '\n' +
          //                         "Latitude : " +
          //                         list['lat'] +
          //                         '\n' +
          //                         "Longitude : " +
          //                         list['long'] +
          //                         '\n' +
          //                         " "),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           flex: 8,
          //         ),
          //         Center(

          //           child: Padding(
          //             padding: EdgeInsets.all(10),
          //             child: Expanded(
          //               child:ClipRRect(
          //                   borderRadius: BorderRadius.circular(100),
          //                   child: Image.network(list['shopImageUrl'],
          //                       width: 163, height: 163, fit: BoxFit.cover)),
          //               flex: 1,
          //             ),
          //           ),
          //         ),
          //         Center(

          //           child: Padding(
          //             padding: EdgeInsets.all(10),
          //             child: Expanded(
          //               child:ClipRRect(
          //                   borderRadius: BorderRadius.circular(100),
          //                   child: Image.network(list['signaturePad'],
          //                       width: 163, height: 163, fit: BoxFit.cover)),
          //               flex: 1,
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          //   elevation: 8,
          //   margin: EdgeInsets.all(10),
          // ),
        
