import 'package:anti_theft/main_layout.dart';
import 'package:anti_theft/routes/routes_constants.dart';
import 'package:anti_theft/screens/approved_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:anti_theft/screens/home/home.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anti Theft Detection',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.cyan
        ),
      ),
      routes: {
        homeRoute: (context) => const HomePage(),
        entryApprovedRoute: (context) => const EntryApprovedPage(),
      },
      home: const HomePage(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

      ),
      // bottomNavigationBar: SafeArea(
      //   child: Container(
      //     color: Colors.black,
      //     child: Padding(
      //       padding: const EdgeInsets.all(10),
      //       child: GNav(
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         backgroundColor: Colors.black,
      //         color: Colors.white,
      //         activeColor: Colors.white,
      //         tabBackgroundColor: Colors.white24,
      //         padding: const EdgeInsets.all(15),
      //         gap: 10,
      //         // selectedIndex: selectedIndex,
      //         onTabChange: (index) {
      //           setState(() {
      //             _selectedIndex = index;
      //           });
      //           switch (index) {
      //             case 0:
      //               Navigator.popAndPushNamed(context, homeRoute);
      //               break;
      //             case 1:
      //               Navigator.popAndPushNamed(context, entryApprovedRoute);
      //               break;
      //           }
      //         },
      //         tabs: const [
      //           GButton(
      //             icon: Icons.home,
      //             text: 'Home',
      //           ),
      //           GButton(
      //             icon: Icons.favorite,
      //             text: 'Approved Entry',
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
