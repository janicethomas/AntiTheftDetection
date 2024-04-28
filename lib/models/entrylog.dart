import 'package:cloud_firestore/cloud_firestore.dart';

class EntryLog {
  String name;
  Timestamp arrivedTime;
  // Timestamp allowedTime;
  bool canAccess;

  EntryLog(
      {required this.name, required this.arrivedTime, required this.canAccess});
      // {required this.name, required this.arrivedTime, required this.canAccess, required this.allowedTime});

  EntryLog.fromJSON(Map<String, Object?> json)
      : this(
            name: json['name']! as String,
            arrivedTime: json['arrivedTime']! as Timestamp,
            canAccess: json['canAccess']! as bool,
            // allowedTime: json['allowedTime']! as Timestamp
  );

  // EntryLog copyWith({String? name, bool? canAccess, Timestamp? arrivedTime, Timestamp? allowedTime}) {
  EntryLog copyWith({String? name, bool? canAccess, Timestamp? arrivedTime}) {
    return EntryLog(
        name: name ?? this.name,
        canAccess: canAccess ?? this.canAccess,
        arrivedTime: arrivedTime ?? this.arrivedTime,
        // allowedTime: allowedTime ?? this.allowedTime,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'canAccess' : canAccess,
      'arrivedTime' : arrivedTime,
      // 'allowedTime' : allowedTime,
    };
  }
}
