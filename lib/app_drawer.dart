import 'package:anti_theft/routes/routes_constants.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
          child:Container(
              margin:EdgeInsets.only(top:100),
              child:Column(children: <Widget>[

                ListTile(
                    leading:Icon(Icons.home),
                    title: const Text("Entries"),
                    onTap:(){
                      Navigator.of(context).pushNamed(homeRoute);
                    }
                ),

                ListTile(
                    leading:Icon(Icons.person),
                    title:const Text("Approved Entries"),
                    onTap:(){
                      Navigator.of(context).pushNamed(entryApprovedRoute);
                    }
                ),

                //add more drawer menu here

              ],)
          )
      ),
    );
  }
}