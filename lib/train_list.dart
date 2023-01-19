import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:sutt_task2/api.dart';
import 'package:sutt_task2/home_page.dart';
import 'package:sutt_task2/riverpod.dart';
import 'package:sutt_task2/train_details.dart';

late String train_number;
late String train_name;
late String train_origin;
late String train_destination;
late String train_distance;
late String train_departTime;
late String train_arrivalTime;
late List<String> train_days;
late List<String> train_class;
late int days_count;
late int class_count;

class TrainList extends ConsumerStatefulWidget {
  const TrainList({super.key});
  @override
  ConsumerState<TrainList> createState() => _TrainListState();
}

class _TrainListState extends ConsumerState<TrainList> {
  late Future<Train> response;

  @override
  void initState() {
    super.initState();
    response = getTrain();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, bool> isBookmarked = ref.watch(isBookmarkedProvider);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const Screen1();
                },
              ),
            );
          },
        ),
        backgroundColor: Colors.blue,
        title: const Text('Available Trains'),
      ),
      body: FutureBuilder<Train>(
        future: response,
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
                          train_number = snapshot.data!.data[index].trainNumber;
                          train_name = snapshot.data!.data[index].trainName;
                          train_origin =
                              snapshot.data!.data[index].trainOriginStation;
                          train_destination = snapshot
                              .data!.data[index].trainDestinationStation;
                          train_distance = snapshot.data!.data[index].distance;
                          train_departTime =
                              snapshot.data!.data[index].departTime;
                          train_arrivalTime =
                              snapshot.data!.data[index].arrivalTime;
                          train_days = snapshot.data!.data[index].runDays;
                          train_class = snapshot.data!.data[index].classType;
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
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 10, 0),
                                        child: Icon(Icons.train),
                                      ),
                                      Flexible(
                                        child: Text(
                                          '${snapshot.data!.data[index].trainName} : ${snapshot.data!.data[index].trainNumber}',
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 0, 0, 0),
                                        child: IconButton(
                                          onPressed: (() {
                                            ref
                                                .read(isBookmarkedProvider
                                                    .notifier)
                                                .toggleBookmark(train_number_, snapshot.data!.data[index]);

                                          }),
                                          iconSize: 30,
                                          icon: (isBookmarked[train_number_] ??
                                                  false)
                                              ? Icon(Icons.bookmark)
                                              : Icon(
                                                  Icons.bookmark_add_outlined),
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          child: Text(
                                            from.toUpperCase(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 17,
                                                color: Color.fromARGB(
                                                    255, 3, 14, 168)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Container(
                                            child: Text(
                                              snapshot
                                                  .data!.data[index].departTime,
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 0, 15, 10),
                                      child: Icon(
                                          Icons.arrow_circle_right_rounded),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          child: Text(
                                            to.toUpperCase(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 17,
                                                color: Color.fromARGB(
                                                    255, 3, 14, 168)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Container(
                                            child: Text(
                                              snapshot.data!.data[index]
                                                  .arrivalTime,
                                              style: TextStyle(fontSize: 15),
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
                'Sorry! No Trains found',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              )));
            }
          }
          return const Center(
              child: CircularProgressIndicator(
            strokeWidth: 7,
          ));
        },
      ),
    );
  }
}
