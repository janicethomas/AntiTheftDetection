// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class DatabaseService {
//   //collection reference
//   final CollectionReference entryCollection = FirebaseFirestore.instance.collection('entrylog');
// }

import 'package:anti_theft/models/entrylog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String ENTRYLOG_COLLECTION_REF = "entrylog";

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _entrylogRef;

  // to confirm to the schema which has been defined in Firestore
  DatabaseService() {
    _entrylogRef =
        _firestore.collection(ENTRYLOG_COLLECTION_REF).withConverter<EntryLog>(
            fromFirestore: (snapshots, _) => EntryLog.fromJSON(
                  snapshots.data()!,
                ),
            toFirestore: (entrylog, _) => entrylog.toJson());
  }

  Stream<QuerySnapshot> getEntrylogs() {
    return _entrylogRef.snapshots();
  }

  void addEntrylog(EntryLog entrylog) async {
  _entrylogRef.add(entrylog);
  }

  void updateEntrylog(String entrylogId, EntryLog entryLog) {
    _entrylogRef.doc(entrylogId).update(entryLog.toJson());
  }

  void deleteEntrylog(String entrylogId) {
    _entrylogRef.doc(entrylogId).delete();
  }
}
