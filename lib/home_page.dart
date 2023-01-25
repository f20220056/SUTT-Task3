import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sutt_task2/bookmarks.dart';
import 'package:sutt_task2/database.dart';
import 'package:sutt_task2/firebase.dart';
import 'package:sutt_task2/train_list.dart';
import 'dart:io';

late String from;
late String to;

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  Future<String> getName() async {
    final displayName = await db.child('${user!.uid}/name').get();
    if (displayName.exists) {
      return displayName.value.toString();
    } else {
      return 'Name Unavailable';
    }
  }

  bool hasAvatarImage = false;
  late XFile? avatarImage;
  final ImagePicker _picker = ImagePicker();
  Future<XFile?> pickImage() async {
    XFile? finalImage = await _picker.pickImage(source: ImageSource.gallery);
    return finalImage;
  }

  Future<XFile?> clickImage() async {
    XFile? finalImage = await _picker.pickImage(source: ImageSource.camera);
    return finalImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar( 
        automaticallyImplyLeading: false,
        title: Text(
          'Home',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Bookmarks();
                  },
                ),
              );
            },
          ),
        ],
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: GestureDetector(
                onTap: () async {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 200,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: FloatingActionButton.extended(
                                  backgroundColor:
                                      Color.fromARGB(255, 0, 89, 243),
                                  elevation: 8,
                                  icon: Icon(Icons.camera_alt),
                                  label: Text('Camera'),
                                  onPressed: () async {
                                    XFile? image = await clickImage();
                                    setState(() {
                                      avatarImage = image;
                                      hasAvatarImage = (image!=null);
                                    });
                                  },
                                ),
                              ),
                              FloatingActionButton.extended(
                                backgroundColor:
                                    Color.fromARGB(255, 0, 89, 243),
                                elevation: 8,
                                icon: Icon(Icons.photo),
                                label: Text('Gallery'),
                                onPressed: () async {
                                  XFile? image = await pickImage();
                                  setState(() {
                                    avatarImage = image;
                                    hasAvatarImage = (image!=null);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.blue,
                  child: CircleAvatar(
                    radius: 42,
                    backgroundImage: (hasAvatarImage)
                        ? (FileImage(File(avatarImage!.path)))
                        : (AssetImage('assets/images/avatar.png'))
                            as ImageProvider,
                  ),
                ),
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 30),
            child: FutureBuilder(
              future: getName(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data!,
                    style: TextStyle(
                      fontFamily: 'Zendots',
                      fontSize: 18,
                    ),
                  );
                } else {
                  return Text('');
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: Image.asset('assets/images/train_sutt (1).jpg'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 8),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'From',
                hintText: 'Enter origin station code',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                from = text;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 8, 30, 20),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'To',
                hintText: 'Enter destination station code',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                to = text;
              },
            ),
          ),
          FloatingActionButton.extended(
            backgroundColor: Colors.blue,
            elevation: 8,
            icon: Icon(Icons.arrow_circle_right_outlined),
            label: Text('Search for Trains'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const Screen2();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TrainList(),
    );
  }
}
