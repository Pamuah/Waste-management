import 'package:final_year_project/firebase_options.dart';
import 'package:final_year_project/models/details.dart';
import 'package:final_year_project/models/payment.dart';
import 'package:final_year_project/momo_payment.dart';
import 'package:final_year_project/searchScreen.dart';
import 'package:final_year_project/signIn.dart';
import 'package:final_year_project/signUp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => DetailsModel()),
          ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ],
        child: const MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      home: SearchScreen(),
    );
  }
}
