import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async{
  // Modify from here
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(EventDetailState());
  // to here.
}

//-------------user sign in - sign up - log out start
class AuthState extends StatefulWidget {
  const AuthState({Key? key}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<AuthState> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Auth User (Logged ' + (user == null ? 'out':'in') + ')'),
        ),
        body: Form(
          key: _key,
          child: Center(
            child: Column(
              children: [
                TextFormField(controller: emailController,
                    validator: validateEmail),
                TextFormField(controller: passwordController,
                    validator: validatePassword),
                Center(
                  child: Text(errorMessage),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround ,
                  children: [
                    ElevatedButton(child: Text('Sign up'),
                        onPressed: () async {
                          if(_key.currentState!.validate()){
                            try {
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                              errorMessage = '';
                            } on FirebaseAuthException catch(error){
                              errorMessage = error.message!;
                            }
                            setState(() {});
                          }
                        }),
                    ElevatedButton(child: Text('Sign in'),
                        onPressed: () async {
                          if(_key.currentState!.validate()) {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                              errorMessage = '';
                            } on FirebaseAuthException catch (error){
                              errorMessage = error.message!;
                            }
                            setState(() {});
                          }
                        }),
                    ElevatedButton(child: Text('log out'),
                        onPressed: () async {
                          try{
                            await FirebaseAuth.instance.signOut();
                            errorMessage = '';
                          } on FirebaseAuthException catch (error){
                            errorMessage = error.message!;
                          }
                          setState(() {});
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String? validateEmail(String? formEmail){
  if(formEmail == null || formEmail .isEmpty){
    return 'Email address is required';
  }
  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if(!regex.hasMatch(formEmail)) return 'Invalid Email Address Format';
  return null;
}

String? validatePassword(String? formPassword){
  if(formPassword == null || formPassword .isEmpty){
    return 'formPassword is required';
  }
  String pattern = r'^(?=.*?[0-9]).{6,8}$';
  RegExp regex = RegExp(pattern);
  if(!regex.hasMatch(formPassword)) return 'Password has 6-8 characters';
  return null;
}


//-------------user sign in - sign up - log out end



//-------------event list start

class EventState extends StatefulWidget {
  const EventState({Key? key}) : super(key: key);

  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<EventState> {

  @override
  Widget build(BuildContext context) {
    CollectionReference event =
    FirebaseFirestore.instance.collection('event') ;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Event list'),
        ),
        body: Center(
          child: StreamBuilder(
            stream: event.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
              if (!snapshot.hasData){
                return Center(child: Text('Loading'),);
              }
              if (snapshot.hasError){
                return Center(child: Text('Something went wrong'),);
              }
              final eventsList = snapshot.requireData;

              return ListView.builder(
                itemCount: eventsList.size, itemBuilder: (context, index){
                return ListTile(
                  title: Text(eventsList.docs[index]['title']),
                  subtitle: Text(eventsList.docs[index]['address']),
                  leading: Text(eventsList.docs[index]['date'].toDate().toString()),
                  onTap: () {
                    // 在这里跳转去detail页面 需要传入eventsList.docs[index]['eid']
                  },
                );
              },);
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
      ),
    );
  }
}

//-------------event list end


//-------------event list Search start

class EventSearchState extends StatefulWidget {
  const EventSearchState({Key? key}) : super(key: key);

  @override
  _EventSearchState createState() => _EventSearchState();
}

class _EventSearchState extends State<EventSearchState> {

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference event =
    FirebaseFirestore.instance.collection('event') ;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Event list Search'),
        ),
        body: Center(

          child: StreamBuilder(
            //stream: event.where('type',isEqualTo:'puzzle').snapshots(),//使用 type中固定的字段来填充 不能混大小写
            stream: event.where('type',isEqualTo:'puzzle')
                .snapshots(),
            //.where('date', isGreaterThan: new DateTime.now())

            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
              if (!snapshot.hasData){
                return Center(child: Text('Loading'),);
              }
              if (snapshot.hasError){
                return Center(child: Text('Something went wrong'),);
              }
              final eventsList = snapshot.requireData;

              return ListView.builder(
                itemCount: eventsList.size, itemBuilder: (context, index){
                return ListTile(
                  title: Text(eventsList.docs[index]['title']),
                  subtitle: Text(eventsList.docs[index]['address']),
                  leading: Text(eventsList.docs[index]['date'].toDate().toString()),
                  onTap: () {
                    // 在这里跳转去detail页面 需要传入eventsList.docs[index]['eid']
                  },
                );
              },);
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
      ),
    );
  }
}

//-------------event list Search end



//-------------event detail start

class EventDetailState extends StatefulWidget {
  const EventDetailState({Key? key}) : super(key: key);

  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetailState> {

  @override
  Widget build(BuildContext context) {
    CollectionReference event =
    FirebaseFirestore.instance.collection('event') ;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Event details'),
        ),
        body: Center(
          child: StreamBuilder(
            //使用eid来获取单个event详情
            stream: event.where('eid',isEqualTo:'2').snapshots(), //用eventlist里的eid去替换'1'
            builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
              if (!snapshot.hasData){
                return Center(child: Text('Loading'),);
              }
              if (snapshot.hasError){
                return Center(child: Text('Something went wrong'),);
              }
              final eventDetail = snapshot.requireData;
              return Column(
                children: [
                  Text(eventDetail.docs[0]['title']),//eventDetail.docs[0].id
                  Text(eventDetail.docs[0]['details']),
                  Text(eventDetail.docs[0]['limit']),
                  Text(eventDetail.docs[0]['address']),
                  Text(eventDetail.docs[0]['date'].toDate().toString()),
                  new Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: new AssetImage('assets/images/'+ eventDetail.docs[0]['image'])
                          )
                      )
                  )
                ],
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () {
            event.add({
//              'title': texeController.text,
            });
          },
        ),
      ),
    );
  }
}

//-------------event detail end


//-------------event list next 7 days start

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
    FirebaseFirestore.instance.collection('event') ;
    DateTime _now = DateTime.now();
    DateTime _next7Days = _now.add(Duration(days:37));

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Event list weekly'),
        ),
        body: Center(

          child: StreamBuilder(
            //stream: event.where('type',isEqualTo:'puzzle').snapshots(),//使用 type中固定的字段来填充 不能混大小写
            stream: event.where('date',isLessThan: _next7Days)
                .where('date',isGreaterThan: _now)
                .orderBy('date')
                .snapshots(),
            //.where('date', isGreaterThan: new DateTime.now())

            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
              if (!snapshot.hasData){
                return Center(child: Text('Loading'),);
              }
              if (snapshot.hasError){
                return Center(child: Text('Something went wrong'),);
              }
              final eventsList = snapshot.requireData;

              return ListView.builder(
                itemCount: eventsList.size, itemBuilder: (context, index){
                return ListTile(
                  title: Text(eventsList.docs[index]['title']),
                  subtitle: Text(eventsList.docs[index]['address']),
                  leading: Text(eventsList.docs[index]['date'].toDate().toString()),
                  onTap: () {
                    // 在这里跳转去detail页面 需要传入eventsList.docs[index]['eid']
                  },
                );
              },);
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
      ),
    );
  }
}

//-------------event list next 7 days  end