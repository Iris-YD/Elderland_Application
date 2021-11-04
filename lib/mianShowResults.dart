import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async{
  // Modify from here
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  // to here.
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference event =
    FirebaseFirestore.instance.collection('event') ;
    CollectionReference eventAttendance =
    FirebaseFirestore.instance.collection('eventAttendance') ;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: textController,
          ),
        ),
        body: Center(
          child: StreamBuilder(
            stream: event.snapshots(),
/*            stream: FirebaseFirestore.instance
                .collection('event')
                .snapshots(),*/
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
              if (!snapshot.hasData){
                return Center(child: Text('Loading'),);
              }
              return ListView(
                children: snapshot.data!.docs.map((event) {
                  return Center(
                    child: ListTile(
                      title: Text(event['title']),
                      onLongPress: (){
                        event.reference. delete();
                      },
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () {
            event.add({
              'title': textController.text,
            });
          },
        ),
      ),
    );
  }
}