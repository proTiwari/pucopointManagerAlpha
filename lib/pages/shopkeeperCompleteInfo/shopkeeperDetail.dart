import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pucopoint_manager/widgets/verticalSpacing.dart';

class ShopkeeperCompleteInfo extends StatefulWidget {
  final lis;
  ShopkeeperCompleteInfo({Key? key, this.lis}) : super(key: key);

  @override
  State<ShopkeeperCompleteInfo> createState() => _ShopkeeperCompleteInfoState();
}

class _ShopkeeperCompleteInfoState extends State<ShopkeeperCompleteInfo> {
  @override
  Widget build(BuildContext context) {
    dynamic list = widget.lis;
    print(list);
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Card"),
      ),
      body: Stack(
        children: [
          SizedBox(
          
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  child: ListView(
                    // This next line does the trick.
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      
                      Container(
                        width: 360.0,
                        color: Color.fromARGB(255, 255, 255, 255),
                        child: ClipRRect(
                            child: Image.network(list['shopkeeperImageUrl'],
                                width: 163, height: 163, fit: BoxFit.cover)),
                      ),
                      Container(
                        width: 360.0,
                        color: Colors.blue,
                        child: ClipRRect(
                            child: Image.network(list['shopImageUrl'],
                                width: 163, height: 163, fit: BoxFit.cover)),
                      ),
                      Container(
                        width: 360.0,
                        color: Colors.green,
                        child: ClipRRect(
                            child: Image.network(list['aadharImageUrl'],
                                width: 163, height: 163, fit: BoxFit.cover)),
                      ),
                      Container(
                        width: 360.0,
                        color: Colors.yellow,
                        child: ClipRRect(
                            child: Image.network(list['signaturePad'],
                                width: 163, height: 163, fit: BoxFit.cover)),
                      ),
                     
                    ],
                  ),
                ),
                 Padding(
                   padding: const EdgeInsets.all(18.0),
                   child: Text("Name : " +
                          list['name'] +
                          '\n' +
                          "Email : " +
                          list['email'] +
                          '\n' +
                          "Phone : " +
                          list['phone'] +
                          '\n' +
                          "Alt Phone : " +
                          list['altPhone'] +
                          '\n' +
                          "Country : " +
                          list['country'] +
                          '\n' +
                          "State : " +
                          list['state'] +
                          '\n' +
                          "City : " +
                          list['city'] +
                          '\n' +
                          "Pincode : " +
                          list['pincode'] +
                          '\n' +
                          "Street Address : " +
                          list['streetAddress'] +
                          '\n' +
                          "Latitude : " +
                          list['lat'] +
                          '\n' +
                          "Longitude : " +
                          list['long'] +
                          '\n' +
                          " ", style: TextStyle(fontSize: 25)),
                 ),
              ],
            ),
          ),
        ],
      ),
    );
  }
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
        
