import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oc_v1/search_page/arts_event.dart';
import 'package:oc_v1/search_page/class_event.dart';
import 'package:oc_v1/search_page/dance_event.dart';
import 'package:oc_v1/search_page/film_event.dart';
import 'package:oc_v1/search_page/food_event.dart';
import 'package:oc_v1/search_page/music_event.dart';
import 'package:oc_v1/search_page/outdoor_event.dart';
import 'package:oc_v1/search_page/party_event.dart';
import 'package:oc_v1/search_page/sports_event.dart';
import '../search_page/picnic_event.dart';
import 'package:oc_v1/widget/button.dart';
import '../constant.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          backgroundColor: mButtonColor.withOpacity(0.5),
          elevation: 0,
          title: Text('Classified By Type',
            style:TextStyle(fontSize: 30)),
          centerTitle: true,
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                 Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[

                    SizedBox(height: 40,),
                    Button(text: 'Dance',
                        press:(){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DanceEvent()
                              )
                          );
                        }
                        ),
                    SizedBox(height: 40,),
                    Button(text: 'Party',
                        press:(){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PartyEvent()
                              )
                          );
                    }),
                    SizedBox(height: 40,),
                    Button(text: 'Arts',
                        press:(){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ArtsEvent()
                              )
                          );
                        }),
                    SizedBox(height: 40,),
                    Button(text: 'Film&Media',press:(){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FilmEvent()
                          )
                      );
                    }),
                    SizedBox(height: 40,),
                    Button(text: 'Class',press:(){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClassEvent()
                          )
                      );
                    }),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 40,),
                    Button(text: 'Picnic',press:(){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PicnicEvent()
                          )
                      );
                    }),
                    SizedBox(height: 40,),
                    Button(text: 'Music',press:(){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MusicEvent()
                          )
                      );
                    }),
                    SizedBox(height: 40,),
                    Button(text: 'Sports',press:(){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SportsEvent()
                          )
                      );
                    }),
                    SizedBox(height: 40,),
                    Button(text: 'Food&Drink',press:(){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FoodEvent()
                          )
                      );
                    }),
                    SizedBox(height: 40,),
                    Button(text: 'Outdoor',press:(){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OutdoorEvent()
                          )
                      );
                    }),
                  ],
                )
              ],
          ),
        )
    );

  }
}