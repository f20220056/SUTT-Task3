import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sutt_task2/api.dart';
import 'package:sutt_task2/firebase.dart';
import 'package:sutt_task2/train_list.dart';
import 'package:sutt_task2/database.dart';

final isBookmarkedProvider =
    StateNotifierProvider<IsBookmarkedState, Map<String, bool>>((ref) {
  return IsBookmarkedState();
});

class IsBookmarkedState extends StateNotifier<Map<String, bool>> {
  IsBookmarkedState() : super({});
  void toggleBookmark(String train_number, Details? train) {
    var oldState = Map<String, bool>.from(state);
    oldState[train_number] = !(oldState[train_number] ?? false);
    state = oldState;
    db
        .child('${user!.uid}/bookmarks/$train_number/isBookmarked')
        .set(state[train_number]);
    db
        .child('${user!.uid}/bookmarks/$train_number/details')
        .set(train!.toJson());
  }
}
