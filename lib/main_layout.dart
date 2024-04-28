import 'package:anti_theft/routes/routes_constants.dart';
import 'package:anti_theft/screens/approved_page.dart';
import 'package:anti_theft/screens/home/home.dart';
import 'package:anti_theft/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainLayout extends StatefulWidget {
  Widget child;
  String title;
  FloatingActionButton? floatingActionButton;

  MainLayout(
      {required this.title,
      required this.child,
      this.floatingActionButton,
      Key? key})
      : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.cyan,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 23.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: Container(
          height: 800,
          width: double.infinity,
          // decoration: const BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.only(
          //       topLeft: Radius.circular(30),
          //       topRight: Radius.circular(30),
          //     )
          // ),
          child: widget.child),
      floatingActionButton: widget.floatingActionButton,
    );
  }
}
