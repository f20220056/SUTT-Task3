import 'package:flutter/material.dart';
import 'package:sutt_task2/schedule.dart';
import 'package:sutt_task2/train_list.dart';

import 'home_page.dart';

class TrainDetails extends StatefulWidget {
  const TrainDetails({super.key});

  @override
  State<TrainDetails> createState() => _TrainDetailsState();
}

class _TrainDetailsState extends State<TrainDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Train Details'),
      ),
      body: Card(
        elevation: 8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.train, size: 40, color: Color.fromARGB(255, 3, 14, 168)),
                  Text(' $train_number',
                      style: TextStyle(
                          fontSize: 25,
                          letterSpacing: 5,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 3, 14, 168)))
                ],
              ),
            ),
            Text(train_name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Zendots',
                  fontSize: 27,
                  letterSpacing: 2,
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 30),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Column(
                  children: [
                    Container(
                      child: Text(
                        from.toUpperCase(),
                        style:
                            TextStyle(color: Color.fromARGB(255, 3, 14, 168),
                            fontSize: 25),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Container(
                        child: Text(train_departTime, style: TextStyle(
                  fontSize: 18,
                )),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                  child: Icon(Icons.arrow_circle_right, size: 40),
                ),
                Column(
                  children: [
                    Container(
                      child: Text(
                        to.toUpperCase(),
                        style:
                            TextStyle(color: Color.fromARGB(255, 3, 14, 168),
                            fontSize: 25),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Container(
                        child: Text(train_arrivalTime, style: TextStyle(
                  fontSize: 18,
                )),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 5),
              child: Text(
                'Run Days',
                style: TextStyle(
                    fontSize: 22,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                days_count,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(1, 0, 1, 0),
                    child: Chip(
                      label: Text(train_days[index]),
                      labelStyle: TextStyle(color: Colors.white),
                      elevation: 8,
                      backgroundColor: Colors.green,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
              child: Text(
                'Class',
                style: TextStyle(
                    fontSize: 22,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Chip>.generate(
                class_count,
                (index) {
                  return Chip(
                    label: Text(train_class[index]),
                    labelStyle: TextStyle(color: Colors.white),
                    elevation: 8,
                    backgroundColor: Colors.blue,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Train starts from:   ',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    train_origin,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 3, 14, 168)),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Train ends at:   ',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    train_destination,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 3, 14, 168)),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Distance:   ',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    '$train_distance km',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 3, 14, 168)),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
              child: FloatingActionButton.extended(label:Text('Get Train Schedule'),
              icon: Icon(Icons.arrow_circle_right_outlined),
              backgroundColor: Color.fromARGB(255, 3, 14, 168),
              elevation: 12,
              onPressed: () {
                Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return const TrainSchedule();
                                },
                              ),
                            );
              }, ),
            )
          ],
        ),
      ),
    );
  }
}
