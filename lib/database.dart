import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sutt_task2/api.dart';
import 'package:sutt_task2/firebase.dart';
import 'package:sutt_task2/train_list.dart';

DatabaseReference db = FirebaseDatabase.instance.ref('users');

void updateName() async {
  db
        .child('${user!.uid}/name')
        .set(user!.displayName);
}

Future<Train?> getBookmarkedTrains() async {
  var bookmarks = (await db.child('${user!.uid}/bookmarks').get()).value as Map;
  List<Details> details = [];
  for (var detail in bookmarks.values) {
    if (detail["isBookmarked"])
      details.add(Details.fromJson(Map.from(detail["details"])));
  }
  if (details.isEmpty) return null;
  return Train(data: details, status: true, message: "", timestamp: 0);
  return (await (db.child('${user!.uid}/bookmarks').get())).value as Train;
}

// void updatePic() async {
//   await db.update({
//     user!.uid: {'pic': }
//   });
// }

