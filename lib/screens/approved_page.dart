import 'package:anti_theft/main_layout.dart';
import 'package:anti_theft/models/entrylog.dart';
import 'package:anti_theft/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EntryApprovedPage extends StatefulWidget {
  const EntryApprovedPage({Key? key}) : super(key: key);

  @override
  State<EntryApprovedPage> createState() => _EntryApprovedPageState();
}

class _EntryApprovedPageState extends State<EntryApprovedPage> {
  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return MainLayout(title: 'Allowed Persons', child: _BuildUI());
    // return _BuildUI();
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
                switch (entrylog.canAccess) {
                  case true:
                    // print(entrylogId);
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      child: ListTile(
                        tileColor:
                        Theme.of(context).colorScheme.primaryContainer,
                        subtitle: Container(
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(entrylog.name, style: const TextStyle(fontSize: 20),),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Arrived Time: ${DateFormat("dd-MM-yy h:mm a").format(
                                    entrylog.arrivedTime.toDate(),
                                  )}"),
                                  // Text("Entry Allowed Time: ${DateFormat("dd-MM-yy h:mm a").format(
                                  //   entrylog.allowedTime.toDate(),
                                  // )}"),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  case false:
                    return const SizedBox.shrink();
                }
              });
        },
      ),
    );
  }
}
