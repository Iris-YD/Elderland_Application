import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oc_v1/event/detail.dart';

import '../constant.dart';

class LikedEventState extends StatefulWidget {
  const LikedEventState({Key? key}) : super(key: key);

  @override
  _LikedEventState createState() => _LikedEventState();
}

class _LikedEventState extends State<LikedEventState> {
  //get title => null;


  @override
  Widget build(BuildContext context) {
    CollectionReference enrollmentCollection =
    FirebaseFirestore.instance.collection('enrollment') ;
    User? user = FirebaseAuth.instance.currentUser;


    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        child: StreamBuilder(
          stream: enrollmentCollection.where('uid',isEqualTo: user!.uid).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text('Loading'),);
            }
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'),);
            }
            final eventsList = snapshot.requireData;
            //final eventDetail = snapshot.requireData;

            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: eventsList.size,
              itemBuilder: (context, index) {
                return GestureDetector(

                child:Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color:mBackgroundColor,
                    border: Border(
                      top:BorderSide(
                      color: Colors.black.withOpacity(0.1)
                      )
                    )
                  ),
                  child:Row(
                    children: [
                      Container(
                        height: 180,
                        width: 200,
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: new AssetImage('assets/images/'+ eventsList.docs[index]['image'])
                          )
                        )
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        height: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              eventsList.docs[index]['title'],
                              style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Montserrat-Bold',
                              color: Colors.black.withOpacity(0.8)
                              )
                            ),
                            Text(eventsList.docs[index]['suburb']),
                            Text(eventsList.docs[index]['date'].toDate().toString()),
                          ],
                        ),
                      )
                    ],
                )
                ),
                    onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext ctx){
                            return new EventDetailState();
                          },
                          settings: RouteSettings(
                            arguments: eventsList.docs[index]['eid'],
                          )
                      )
                  );
                },
                );

                // return Card(
                //   elevation: 3,
                //   margin: EdgeInsets.all(16),
                //   color: mSecondBackgroundColor,
                //   child: ListTile(
                //     leading: Text(eventsList.docs[index]['date'].toDate().toString(),
                //       style: TextStyle(
                //           fontSize: 12,
                //           fontFamily: 'Montserrat',
                //           // color: Colors.black
                //       ),
                //     ),
                //     title: Text(eventsList.docs[index]['title'],
                //       style: TextStyle(
                //           fontSize: 18,
                //           fontFamily: 'Montserrat-Bold',
                //           color: Colors.black
                //       ),
                //     ),
                //     subtitle: Text(eventsList.docs[index]['address'],
                //       style: TextStyle(
                //           fontSize: 14,
                //           fontFamily: 'Montserrat',
                //           // color: Colors.black
                //       ),),
                //     onTap: (){
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (BuildContext ctx){
                //                 return new EventDetailState();
                //               },
                //               settings: RouteSettings(
                //                 arguments: eventsList.docs[index]['eid'],
                //               )
                //           )
                //       );
                //     },
                //   ),
                // );

              },
            );
          },
        ),
      ),
    );
  }

  buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: mBackgroundColor,
      elevation: 0,
      title: Text(
        'Your Likes',
        style: TextStyle(
            color: mPrimaryTextColor,
            fontFamily: 'Montserrat',
            fontSize: 26
        ),
      ),
    );
  }
}