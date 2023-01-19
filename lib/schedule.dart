import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sutt_task2/api2.dart' as api2;

class TrainSchedule extends StatefulWidget {
  const TrainSchedule({super.key});

  @override
  State<TrainSchedule> createState() => _TrainScheduleState();
}

class _TrainScheduleState extends State<TrainSchedule> {
  late Future<api2.Schedule> response2;
  @override
  void initState() {
    super.initState();
    response2 = api2.getSchedule();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Train Schedule')),
      body: FutureBuilder<api2.Schedule>(
        future: response2,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              var route = snapshot.data!.data.route;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stepper(
                  controlsBuilder: (context, controller) {
                    return const SizedBox.shrink();
                  },
                  currentStep: stepIndex,
                  onStepTapped: (int value) {
                    setState(() {
                      stepIndex = value;
                    });
                  },
                  steps: List<Step>.generate(
                    route.length,
                    (index) {
                      return Step(
                        isActive: true,
                        title: Text(
                          route[index].stationName,
                          style: TextStyle(fontSize: 15),
                        ),
                        subtitle: Text(route[index].stationCode),
                        content: Column(
                          children: [
                            Row(
                              children: [
                                Text('Stop : '),
                                Text(
                                  route[index].stop ? 'Yes' : 'No',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 3, 14, 168)),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text('Platform No. : '),
                                Text(
                                  route[index].platformNumber.toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 3, 14, 168)),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text('Distance from Source : '),
                                Text(
                                  route[index].distanceFromSource,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 3, 14, 168)),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          } else {
            return const Center(
                child: CircularProgressIndicator(
              strokeWidth: 7,
            ));
          }
          throw '';
        },
      ),
    );
  }
}

int stepIndex = 0;
