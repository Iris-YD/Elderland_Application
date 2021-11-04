import 'package:flutter/material.dart';
import 'package:oc_v1/event/likelist.dart';
import 'package:oc_v1/event/list.dart';
import 'package:oc_v1/event/weekly.dart';
import 'package:oc_v1/main.dart';
import 'package:oc_v1/profile/profile.dart';
import 'package:oc_v1/screen/search_screen.dart';


import '../constant.dart';


class EventScreen extends StatelessWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: mButtonColor.withOpacity(0.5),
          elevation: 0,
          title: Text(
              'Event List',
              style: TextStyle(
                fontSize: 30,
                ),
          ),
          centerTitle: true,
          //account icon
          actions: <Widget>[
            //Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context)=> new MyApp()), (route) => route == null);
            IconButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profile()
                    ),
                  );
                },
                icon: Icon(Icons.account_box),iconSize: 28,
            ),
            //search icon
            IconButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchPage()
                    ),
                  );
                },
                icon: Icon(Icons.search),iconSize: 28,
            )
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: mButtonColor.withOpacity(0.5),
          ),
          height: 80,
          child:TabBar(
            tabs: <Widget>[
              Tab(text:'Today'),
              Tab(text:'Weekly'),
              Tab(text:'Like'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            EventState(),
            EventNext7State(),
            LikedEventState(),
        ],
        ),
      ),
    );
  }
}