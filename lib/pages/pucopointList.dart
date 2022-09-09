import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide Notification;
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pucopoint_manager/login/login.dart';
import 'package:pucopoint_manager/model/pucoreads.dart';
import 'package:pucopoint_manager/pages/googleMap.dart';
import 'package:pucopoint_manager/pages/shopkeeper.dart';
import 'package:pucopoint_manager/pages/notification.dart';
import 'package:pucopoint_manager/pages/shopkeeperCompleteInfo/shopkeeperDetail.dart';

import '../utils/getpucopoints.dart';

class PucopointList extends StatefulWidget {
  const PucopointList({Key? key}) : super(key: key);

  @override
  State<PucopointList> createState() => _PucopointListState();
}

class _PucopointListState extends State<PucopointList> {
  int pageIndex = 0;
  bool googlemaptab = false;
  @override
  didChangeDependencies() {
    getPucopoints();
    super.didChangeDependencies();
  }

  TextEditingController controller = new TextEditingController();
  final db = FirebaseFirestore.instance;
  bool _isLoading = false;
  List lis = [];
  List resultsList = [];

  int _selectedIndex = 0;

  @override
  void initState() {
    googlemaptab = false;
    pageIndex = 0;
    controller.addListener((_onSearchChange));
    super.initState();
  }

  _onSearchChange() {
    searchResultList();
  }

  searchResultList() {
    List showResult = [];
    if (controller.text != "") {
      for (var pucoSnapshot in lis) {
        var name = Pucopoint.fromDocumentSnapshot(pucoSnapshot)
            .name
            .toString()
            .toLowerCase();
        if (name.contains(controller.text.toLowerCase())) {
          showResult.add(pucoSnapshot);
        }
      }
    } else {
      showResult = resultsList;
    }
    setState(() {
      lis = showResult;
    });
  }

  @override
  void dispose() {
    controller.removeListener(_onSearchChange());
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // googlemaptab = false;
    return WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
        appBar: new AppBar(
          title: const Text('Pucopoints'),
          actions: [
            IconButton(
              onPressed: () {
                googlemaptab = true;
                setState(() {
                  googlemaptab = true;
                });

                Future.delayed(const Duration(seconds: 5)).then((value) => {
                      Future.delayed(const Duration(seconds: 1))
                          .then((value) => setState(() {
                                googlemaptab = false;
                              })),
                      Get.to(Googlemap(liss: lis)),
                    });
              },
              icon: const Icon(Icons.gps_fixed),
            ),
            IconButton(
              onPressed: () {
                _logout();
              },
              icon: const Icon(Icons.logout),
            ),
          ],
          elevation: 0.0,
        ),
        body: googlemaptab
            ? WillPopScope(
                onWillPop: () async => false,
                child: Center(
                  child: SizedBox(
                      height: 200.0,
                      width: 200.0,
                      child: LottieBuilder.asset(
                          'assets/animassets/animation.json')),
                ),
              )
            : new Column(
                children: <Widget>[
                  new Container(
                    color: Theme.of(context).primaryColor,
                    child: new Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Card(
                        child: new ListTile(
                          leading: const Icon(Icons.search),
                          title: new TextField(
                            controller: controller,
                            decoration: const InputDecoration(
                                hintText: 'Search', border: InputBorder.none),
                            // onChanged: onSearchTextChanged,
                          ),
                          trailing: IconButton(
                            icon: controller.text != "" ?const Icon(Icons.cancel) : Container(),
                            onPressed: () {
                              
                              controller.clear();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  lis.isEmpty
                      ? SingleChildScrollView(
                        child: Center(
                            child: SizedBox(
                              height: 200,
                              child: Container(
                                  height: 160.0,
                                  width: 160.0,
                                  child: LottieBuilder.asset(
                                      'assets/animassets/loading.json')),
                            ),
                          ),
                      )
                      : Expanded(
                          child: ListView.builder(
                              // scrollDirection: Axis.horizontal,
                              itemCount: lis.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: GestureDetector(
                                    onTap: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ShopkeeperCompleteInfo(
                                                    lis: lis[index])),
                                      )
                                    },
                                    child: ListTile(
                                      leading: new CircleAvatar(
                                        radius: 29,
                                        backgroundImage: new NetworkImage(
                                            lis[index]['shopkeeperImageUrl']),
                                      ),
                                      title: new Text(lis[index]['name'] +
                                          '\n' +
                                          lis[index]['email'] +
                                          '\n' +
                                          lis[index]['phone'] +
                                          '\n' +
                                          lis[index]['streetAddress']),
                                    ),
                                  ),
                                  elevation: 8,
                                  margin: EdgeInsets.all(10),
                                  shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                );
                              })),
                ],
              ),
        bottomNavigationBar: bottomNav(),
      ),
    );
  }

  Future getPucopoints() async {
    lis = await getPucopoint();
    setState(() {
      resultsList = lis;
    });
    // setState(() {
    //   _isLoading = true;
    // });

    // var data = await FirebaseFirestore.instance.collection('pucopoints').get();
    // lis = List.from(data.docs.map((e) => e));

    // setState(() {
    //   lis;
    //   resultsList = lis;
    // });
    // if (lis != []) {
    //   _isLoading = false;
    // }
    // return lis;
  }

  Future<void> _logout() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure you want to Logout?'),
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
                FirebaseAuth.instance.signOut();
                Navigator.popUntil(context, ModalRoute.withName("/"));
              },
            ),
          ],
        );
      },
    );
  }

  Widget bottomNav() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
                    Icons.home_filled,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            onPressed: () async {
              Get.to(Shopkeeper());
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
                    Icons.add_circle,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () async {
              Get.to(Notification());
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.notifications_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
        ],
      ),
    );
  }
}
