import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../constant.dart';

class EventDetailState extends StatefulWidget {
  const EventDetailState({Key? key}) : super(key: key);

  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetailState> {
  CollectionReference enrollmentCollection =
  FirebaseFirestore.instance.collection('enrollment') ;
  CollectionReference eventCollection =
  FirebaseFirestore.instance.collection('event') ;

  bool _isLiked = false;
  void _toggleLike(eid,uid) {
    setState(() {
      // If the lake is currently favorited, unfavorite it.
      if (_isLiked) {
        final enrollmentID = uid + eid;
        _isLiked = false;
        enrollmentCollection.doc(enrollmentID).delete();
        print("false: " + enrollmentID);
        // Otherwise, favorite it.
      } else {
        _isLiked = true;
        final enrollmentID = uid + eid;
        print("true: " + enrollmentID);
        eventCollection.doc(eid).get().then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists){
            enrollmentCollection.doc(enrollmentID).set({
              "uid": uid,
              "eid": eid,
              "address": documentSnapshot.get("address"),
              "date": documentSnapshot.get("date"),
              "details": documentSnapshot.get("details"),
              "image": documentSnapshot.get("image"),
              "limit": documentSnapshot.get("limit"),
              "suburb": documentSnapshot.get("suburb"),
              "title": documentSnapshot.get("title"),
              "type": documentSnapshot.get("type"),
            });
          }
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final _eid = ModalRoute.of(context)!.settings.arguments;
    CollectionReference event =
    FirebaseFirestore.instance.collection('event');
    CollectionReference enrollmentCollection =
    FirebaseFirestore.instance.collection('enrollment');
    User? user = FirebaseAuth.instance.currentUser;
    String eid = _eid.toString();
    String uid = user!.uid.toString();
    final enrollmentID = uid + eid;
    enrollmentCollection.doc(enrollmentID).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists){
        _isLiked = true;
      }
    });

    return Scaffold(
      appBar:AppBar(
          backgroundColor: mButtonColor.withOpacity(0.5),
          elevation: 0,
          title: Text('Event Detail'),
          centerTitle: true
      ),
      body: Center(
        child: StreamBuilder(
          //使用eid来获取单个event详情
          stream: event.doc(_eid.toString()).get().asStream(),
          //stream: event.where('eid',isEqualTo:'2').snapshots(), //用eventlist里的eid去替换'1'
          builder: (context,AsyncSnapshot<DocumentSnapshot> snapshot){
            if (!snapshot.hasData){
              return Center(child: Text('Loading'),);
            }
            if (snapshot.hasError){
              return Center(child: Text('Something went wrong'),);
            }
            final eventDetail = snapshot.requireData;
            return SingleChildScrollView(
              child: Container(
                height: 770,
                child: Column(
                  children: [
                    //SizedBox(height: 10,),
                    Container(
                        width: 400.0,
                        height: 360.0,
                        decoration: new BoxDecoration(
                            image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: new AssetImage('assets/images/'+ eventDetail.get('image'))
                            )
                        )
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20,left:20,right:20),
                      child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: Text(eventDetail.get('title'),style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    )
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                        child: IconButton(
                                            onPressed: () => _toggleLike(eid, uid),
                                            icon: _isLiked ? new Icon(Icons.star, size: 30,) : Icon(Icons.star_border, size: 30)
                                        ),
                                    )
                                ),
                              ],
                            ),

                            SizedBox(height: 30),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                        child: Text("Description:",
                                          style: TextStyle(
                                            color: mTitleTextColor,
                                            fontFamily: 'Montserrat',
                                            fontSize: 19,
                                          ),
                                        )
                                    )
                                ),
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                        child: Text(eventDetail.get('details'),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Montserrat',
                                            fontSize: 19,
                                          ),
                                        )
                                    )
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                        child: Text("Limit:",
                                          style: TextStyle(
                                            color: mTitleTextColor,
                                            fontFamily: 'Montserrat',
                                            fontSize: 19,
                                          ),
                                        )
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                        child: Text(eventDetail.get('limit'),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Montserrat',
                                            fontSize: 19,
                                          ),
                                        )
                                    )),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                        child: Text("Address:",
                                          style: TextStyle(
                                            color: mTitleTextColor,
                                            fontFamily: 'Montserrat',
                                            fontSize: 19,
                                          ),
                                        )
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                        child: Text(eventDetail.get('address'),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Montserrat',
                                            fontSize: 19,
                                          ),
                                        )
                                    )),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                        child: Text("Date:",
                                          style: TextStyle(
                                            color: mTitleTextColor,
                                            fontFamily: 'Montserrat',
                                            fontSize: 19,
                                          ),
                                        )
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                        child: Text(eventDetail.get('date').toDate().toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Montserrat',
                                            fontSize: 19,
                                          ),
                                        )
                                    )),
                              ],
                            ),
                            // SizedBox(height: 50),
                            // TextButton(
                            //   child: Container(
                            //     padding: EdgeInsets.symmetric(vertical: 8),
                            //     alignment: Alignment.center,
                            //     // width: double.infinity,
                            //     child: Text('Like it',
                            //       style: TextStyle(
                            //         color: mPrimaryTextColor,
                            //         fontFamily: 'Montserrat',
                            //         fontSize: 19,
                            //       ),
                            //     ),
                            //   ),
                            //   // child: Text('Log in'),
                            //   style: ButtonStyle(
                            //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            //         RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.circular(36),
                            //         )
                            //     ),
                            //     backgroundColor:
                            //     MaterialStateProperty.all(Color(0xFF5063FF).withOpacity(0.5)),
                            //     //mButtonColor.withOpacity(0.5),
                            //   ),
                            //   onPressed: () => _toggleLike(eid, uid),
                            // ),
                          ]
                      ),
                    )
                  ],
                ),
              ),
            );

          },
        ),
      ),
    );
  }
  buildAppBar() {
    return AppBar(
      backgroundColor: mBackgroundColor,
      elevation: 0,
      title: Text(
        'Event Detail',
        style: TextStyle(
          color: mPrimaryTextColor,
          fontFamily: 'Montserrat',
        ),
      ),
    );
  }
}