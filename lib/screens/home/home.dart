import 'package:anti_theft/main_layout.dart';
import 'package:anti_theft/models/entrylog.dart';
import 'package:anti_theft/app_drawer.dart';
import 'package:anti_theft/screens/home/emergency_call.dart';
import 'package:anti_theft/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return MainLayout(title: 'Home Page', child: _BuildUI());
    // return _BuildUI();
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text("Entries"),
    //   ),
    //   drawer: const AppDrawer(),
    //   body: _BuildUI(),
    // );
  }

  Widget _BuildUI() {
    return SafeArea(
      child: Column(
        children: [
          _messagesListView(),
        ],
      ),
    );
  }

  Widget _messagesListView() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.80,
      width: MediaQuery.sizeOf(context).height,
      child: StreamBuilder(
        stream: _databaseService.getEntrylogs(),
        builder: (context, snapshot) {
          List entrylogs = snapshot.data?.docs ?? [];
          if (entrylogs.isEmpty) {
            return const Center(
              child: Text("Empty"),
            );
          }
          return ListView.builder(
              itemCount: entrylogs.length,
              itemBuilder: (context, index) {
                EntryLog entrylog = entrylogs[index].data();
                String entrylogId = entrylogs[index].id;
                // print(entrylogId);
                switch (entrylog.name) {
                  case "unknown":
                    switch (entrylog.canAccess) {
                      case false:
                        // print(entrylogId);
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 80, 15, 0),
                                  // child: Image.asset(
                                  //   'unknown.png',
                                  //   height: 160,
                                  //   width: double.infinity,
                                  //   fit: BoxFit.cover,
                                  // ),
                                  child: const Text(
                                    "Unknown Person",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 15, 15, 60),
                                  child: Text(
                                      "Arrived Time: ${DateFormat("dd-MM-yy h:mm a").format(
                                    entrylog.arrivedTime.toDate(),
                                  )}",
                                  style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 15, 15, 40),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.check),
                                            color: Colors.green,
                                            iconSize: 60,
                                            onPressed: () {
                                              EntryLog updatedEntryLog =
                                                  entrylog.copyWith(
                                                      canAccess: true,
                                                      // allowedTime:
                                                      //     Timestamp.now()
                                                      );
                                              _databaseService.updateEntrylog(
                                                  entrylogId, updatedEntryLog);
                                            },
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.close),
                                            color: Colors.red,
                                            iconSize: 60,
                                            onPressed: () {
                                            },
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.call),
                                            color: Colors.orange,
                                            iconSize: 60,
                                            onPressed: () {
                                              emergencyCallDialog(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          // child: ListTile(
                          //   tileColor:
                          //       Theme.of(context).colorScheme.primaryContainer,
                          //   title: Text(entrylog.name),
                          //   subtitle: Text("Arrived Time: ${DateFormat("dd-MM-yy h:mm a").format(
                          //     entrylog.arrivedTime.toDate(),
                          //   )}"),
                          //   trailing: IconButton(
                          //     icon: const Icon(Icons.doorbell),
                          //     onPressed: () {
                          //       EntryLog updatedEntryLog = entrylog.copyWith(
                          //           canAccess: !entrylog.canAccess,
                          //           allowedTime: Timestamp.now());
                          //       _databaseService.updateEntrylog(
                          //           entrylogId, updatedEntryLog);
                          //     },
                          //   ),
                          // ),
                        );
                      case true:
                        return const SizedBox.shrink();
                    }
                }
              });
        },
      ),
    );
  }
}
