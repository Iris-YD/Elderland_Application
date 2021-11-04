import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constant.dart';
import 'detail.dart';

class EventNext7State extends StatefulWidget {
  const EventNext7State({Key? key}) : super(key: key);

  @override
  _EventNext7State createState() => _EventNext7State();
}

class _EventNext7State extends State<EventNext7State> {

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference event =
    FirebaseFirestore.instance.collection('event');
    DateTime _now = DateTime.now();
    DateTime _next7Days = _now.add(Duration(days: 7));

    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        child: StreamBuilder(
          //stream: event.where('type',isEqualTo:'puzzle').snapshots(),//使用 type中固定的字段来填充 不能混大小写
          stream: event.where('date', isLessThan: _next7Days)
              .where('date', isGreaterThan: _now)
              .orderBy('date')
              .snapshots(),
          //.where('date', isGreaterThan: new DateTime.now())

          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text('Loading'),);
            }
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'),);
            }
            final eventsList = snapshot.requireData;
            final eventDetail = snapshot.requireData;

            return ListView.builder(
              itemCount: eventsList.size, itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext ctx){
                            return new EventDetailState();
                          },
                          settings: RouteSettings(
                            arguments: eventsList.docs[index].id,
                          )
                      )
                  );
                },
                child: Container(
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
                                    image: new AssetImage('assets/images/'+ eventDetail.docs[index]['image'])
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
                              Text(eventsList.docs[index]['title'],
                                  style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Montserrat-Bold',
                                  color: Colors.black.withOpacity(0.8)
                              )),
                              Text(eventsList.docs[index]['suburb']),
                              Text(eventsList.docs[index]['date'].toDate().toString()),
                            ],
                          ),
                        )

                      ],
                    )
                ),
              );
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
        'Weekly',
        style: TextStyle(
          color: mPrimaryTextColor,
          fontFamily: 'Montserrat',
            fontSize: 26
        ),
      ),
    );
  }

}