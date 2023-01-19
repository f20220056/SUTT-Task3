import 'package:flutter/material.dart';
import 'package:sutt_task2/api.dart';
import 'package:sutt_task2/database.dart';
import 'package:sutt_task2/home_page.dart';
import 'package:sutt_task2/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sutt_task2/train_details.dart';
import 'package:sutt_task2/train_list.dart';

class Bookmarks extends ConsumerStatefulWidget {
  const Bookmarks({super.key});

  @override
  ConsumerState<Bookmarks> createState() => _BookmarksState();
}

class _BookmarksState extends ConsumerState<Bookmarks> {
  @override
  Widget build(BuildContext context) {
    final Map<String, bool> isBookmarked = ref.watch(isBookmarkedProvider);
    Future<Train?> bookmarkedTrains = getBookmarkedTrains();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Your Bookmarks'),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Trains',
              ),
              Tab(
                text: 'Stations',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FutureBuilder<Train?>(
              future: bookmarkedTrains,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data != null) {
                    return ListView(
                      children: List<Widget>.generate(
                        snapshot.data!.data.length,
                        (index) {
                          String train_number_ =
                              snapshot.data!.data[index].trainNumber;
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: () {
                                from = snapshot
                                    .data!.data[index].trainOriginStationCode;
                                to = snapshot
                                    .data!.data[index].trainDestinationStationCode;
                                train_number =
                                    snapshot.data!.data[index].trainNumber;
                                train_name =
                                    snapshot.data!.data[index].trainName;
                                train_origin = snapshot
                                    .data!.data[index].trainOriginStation;
                                train_destination = snapshot
                                    .data!.data[index].trainDestinationStation;
                                train_distance =
                                    snapshot.data!.data[index].distance;
                                train_departTime =
                                    snapshot.data!.data[index].departTime;
                                train_arrivalTime =
                                    snapshot.data!.data[index].arrivalTime;
                                train_days = snapshot.data!.data[index].runDays;
                                train_class =
                                    snapshot.data!.data[index].classType;
                                days_count =
                                    snapshot.data!.data[index].runDays.length;
                                class_count =
                                    snapshot.data!.data[index].classType.length;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return const TrainDetails();
                                    },
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 8,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 10, 0),
                                              child: Icon(Icons.train),
                                            ),
                                            Flexible(
                                              child: Text(
                                                '${snapshot.data!.data[index].trainName} : ${snapshot.data!.data[index].trainNumber}',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      30, 0, 0, 0),
                                              child: IconButton(
                                                onPressed: (() {
                                                  ref
                                                      .read(isBookmarkedProvider
                                                          .notifier)
                                                      .toggleBookmark(
                                                          train_number_,
                                                          snapshot.data!
                                                              .data[index]);
                                                }),
                                                iconSize: 30,
                                                icon: (isBookmarked[
                                                            train_number_] ??
                                                        false)
                                                    ? Icon(Icons.bookmark)
                                                    : Icon(Icons
                                                        .bookmark_add_outlined),
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                child: Text(
                                                  snapshot.data!.data[index]
                                                      .trainOriginStationCode
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 17,
                                                      color: Color.fromARGB(
                                                          255, 3, 14, 168)),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 5, 0, 0),
                                                child: Container(
                                                  child: Text(
                                                    snapshot.data!.data[index]
                                                        .departTime,
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                15, 0, 15, 10),
                                            child: Icon(Icons
                                                .arrow_circle_right_rounded),
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                child: Text(
                                                  snapshot.data!.data[index]
                                                      .trainDestinationStationCode
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 17,
                                                      color: Color.fromARGB(
                                                          255, 3, 14, 168)),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 5, 0, 0),
                                                child: Container(
                                                  child: Text(
                                                    snapshot.data!.data[index]
                                                        .arrivalTime,
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: Container(
                        child: Text(
                          'You have not bookmarked any trains yet',
                        ),
                      ),
                    );
                  }
                }
                return const Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 7,
                ));
              },
            ),
            Center(
              child: Text("You have not bookmarked any stations yet"),
            ),
          ],
        ),
      ),
    );
  }
}
