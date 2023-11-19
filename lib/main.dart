// ignore_for_file: unused_local_variable
import 'package:fin_flow/Pages/Help_Page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'Models/Transaction_Model.dart';
import 'Pages/Home_Page.dart';
import 'Pages/IncomePage.dart';
import 'Pages/Outcome_Page.dart';

void main() async {

  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());

  final box = await Hive.openBox('mybox');

  runApp(const FinFlow());
}

class FinFlow extends StatelessWidget {
  const FinFlow({super.key,});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      theme: ThemeData(primarySwatch: Colors.indigo),

      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate
      ],

      supportedLocales: const [
        Locale('ru'),
      ],

      routes: {
        '/HomePage':(context) => const HomePage(),
        '/OutcomePage':(context) => const OutcomePage(),
        '/IncomePage':(context) => const IncomePage(),
        '/HelpPage':(context) => const HelpPage()
      },
     
      home: const HomePage(),

    );
  }
}