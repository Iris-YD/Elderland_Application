import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oc_v1/event/detail.dart';

import '../constant.dart';

class FilmEvent extends StatefulWidget {
  const FilmEvent({Key? key}) : super(key: key);

  @override
  _FilmEvent createState() => _FilmEvent();
}

class _FilmEvent extends State<FilmEvent> {
  get title => null;


  @override
  Widget build(BuildContext context) {
    CollectionReference event =
    FirebaseFirestore.instance.collection('event');

    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        child: StreamBuilder(
          stream: event.where('type',isEqualTo:'Film&Media').snapshots(),
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
              scrollDirection: Axis.vertical,
              itemCount: eventsList.size,
              itemBuilder: (context, index) {
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
                                      image: new AssetImage('assets/images/'+ eventsList.docs[index]['image'])
                                  )
                              )
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
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
      automaticallyImplyLeading: true,
      backgroundColor: mButtonColor.withOpacity(0.5),
      elevation: 0,
      title: Text(
        'Film&Media',
        style: TextStyle(
          color: mBackgroundColor,
          fontFamily: 'Montserrat',
        ),
      ),
    );
  }
}