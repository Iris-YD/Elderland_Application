import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async{
  // Modify from here
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProfileState());
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
            stream: event.where('type',isEqualTo:'physical').snapshots(),
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
              // return ListView(
              //   children: snapshot.data!.docs.map((event) {
              //     return Center(
              //       child: ListTile(
              //         title: Text(event['title']),
              //         onLongPress: (){
              //           event.reference. delete();
              //         },
              //       ),
              //     );
              //   }).toList(),
              // );
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
            stream: event.where('eid',isEqualTo:'1').snapshots(), //用eventlist里的eid去替换'1'
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

//-------------portfolio start
class ProfileState extends StatefulWidget {
  const ProfileState({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileState> {

  @override
  Widget build(BuildContext context) {
    CollectionReference user =
    FirebaseFirestore.instance.collection('user');
    //User? user = FirebaseAuth.instance.currentUser;
    //String uid = user.uid;
    String uid = 'AuvQQW5ce8YGI7IXtJUtw9iv3RA2';//连上Auth后注释掉
    final Stream<QuerySnapshot> _portfolioStream =
    user.where('uid',isEqualTo:uid).snapshots(includeMetadataChanges: true);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Center(
            child: StreamBuilder(
                stream: _portfolioStream,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (!snapshot.hasData) {
                    return Text('Please write your profile');
                    //Navigator.pushNamed(context, portfolioChange);
                  }
                  final profileData = snapshot.requireData;

                  return Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Expanded(
                              flex:1,
                              child: Container(
                                  child: Text("email")
                              )),
                          Expanded(
                              flex:1,
                              child: Container(
                                  child: Text(profileData!.docs[0]['email'])
                              )),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              flex:1,
                              child: Container(
                                  child: Text("gender")
                              )),
                          Expanded(
                              flex:1,
                              child: Container(
                                  child: Text(profileData!.docs[0]['gender'])
                              )),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              flex:1,
                              child: Container(
                                  child: Text("name")
                              )),
                          Expanded(
                              flex:1,
                              child: Container(
                                  child: Text(profileData!.docs[0]['name'])
                              )),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              flex:1,
                              child: Container(
                                  child: Text("phone ")
                              )),
                          Expanded(
                              flex:1,
                              child: Container(
                                  child: Text(profileData!.docs[0]['phone'])
                              )),
                        ],
                      ),
                    ],);
                }
            )
        ),
      ),
    );
  }
}
//-------------event detail end