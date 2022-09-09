import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pucopoint_manager/login/login.dart';
import 'package:pucopoint_manager/pages/pucopointList.dart';
import 'package:pucopoint_manager/pages/shopkeeper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  GestureBinding.instance.resamplingEnabled = true;
  // await FirebaseAppCheck.instance.activate(
  //   webRecaptchaSiteKey: '6Lf9TlkhAAAAAGmUZbsApCDxoELkfoFlICiy-8Ty',
  // );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const ProviderScope(child: MyApp()));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Registration Form',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.amber,
        appBarTheme: AppBarTheme(
          color: Colors.amber,
        ),
       
      ),
      // theme: ThemeData(
      //   accentColor: Colors.red,
      //     brightness: Brightness.light,
      //     primaryColor: Colors.amber,
      //     visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: '/',
      routes: {
        '/pucopointList': (context) => PucopointList(),
        '/shopkeeper': (context) => Shopkeeper(),
      },
      supportedLocales: [
        const Locale('en'),
        const Locale('ar'),
        const Locale('es'),
        const Locale('el'),
        const Locale('nb'),
        const Locale('nn'),
        const Locale('pl'),
        const Locale('pt'),
        const Locale('ru'),
        const Locale('hi'),
        const Locale('ne'),
        const Locale('uk'),
        const Locale('hr'),
        const Locale('tr'),
        const Locale.fromSubtags(
            languageCode: 'zh',
            scriptCode: 'Hans'), // Generic Simplified Chinese 'zh_Hans'
        const Locale.fromSubtags(
            languageCode: 'zh',
            scriptCode: 'Hant'), // Generic traditional Chinese 'zh_Hant'
      ],
      localizationsDelegates: [
        CountryLocalizations.delegate,
      ],

      // routes: {
      //   '/': (context) => const LoginComponent(
      //         title: 'hihh',
      //       )
      // },
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const LoginComponent(
                title: '',
              );
            } else {
              return PucopointList();
            }
          }),
    );
  }
}
