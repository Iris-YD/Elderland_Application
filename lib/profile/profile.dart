import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oc_v1/widget/rounded_button.dart';
import '../constant.dart';
import '../screen/event_screen.dart';
import '../sign/home_screen.dart';
import 'profile_edit.dart';




class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // final emailController = TextEditingController();
  // final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final genderController = TextEditingController();
  final phoneController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    CollectionReference userCollection =
    FirebaseFirestore.instance.collection('user');
    User? user = FirebaseAuth.instance.currentUser;
    //String uid = user.uid;
    //String uid = '1';//连上Auth后注释掉
    final Stream<QuerySnapshot> _portfolioStream =
    userCollection.where('uid',isEqualTo:user!.uid).snapshots(includeMetadataChanges: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mButtonColor.withOpacity(0.5),
        //automaticallyImplyLeading: true, // return button on top left
        leading: new IconButton(
          icon: Icon(Icons.home),iconSize: 28,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventScreen(),
              ),
            );
          },

        ),
        elevation: 0,
        title: Text('ElderLand',
          style: TextStyle(
            color: mPrimaryTextColor,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Profile',
              style: TextStyle(
                color: mPrimaryTextColor,
                fontSize: 38,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 36,
            ),
            Center(
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
                                  flex: 1,
                                  child: Container(
                                      child: Text("Name:",
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
                                      child: Text(profileData.docs[0]['name'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Montserrat',
                                          fontSize: 19,
                                        ),
                                      )
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 26,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                      child: Text("Gender:",
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
                                      child: Text(profileData.docs[0]['gender'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Montserrat',
                                          fontSize: 19,
                                        ),
                                      )
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 26,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Text("Email:",
                                    style: TextStyle(
                                      color: mTitleTextColor, // mPrimaryTextColor,
                                      fontFamily: 'Montserrat',
                                      fontSize: 19,
                                    ),
                                  ),


                                ),

                              ),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                      child: Text(profileData.docs[0]['email'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Montserrat',
                                          fontSize:19,
                                        ),
                                      )
                                  )
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 26,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                      child: Text("Phone:",
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
                                      child: Text(profileData.docs[0]['phone'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Montserrat',
                                          fontSize: 19,
                                        ),
                                      )
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 86,
                          ),
                        ],
                      );
                    }
                )
            ),
            RoundedButton(
              press: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileEdit(),
                  ),
                );
              },
              text: 'Edit',
              backgroundColor: mButtonColor.withOpacity(0.5),
              textColor: mPrimaryTextColor,
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: _key,
              child: TextButton(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Text('Log out',
                      style: TextStyle(
                        color: Colors.red, // mPrimaryTextColor,
                        fontFamily: 'Montserrat',
                        fontSize: 24,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    try{
                      await FirebaseAuth.instance.signOut();
                      errorMessage = '';
                      HapticFeedback.heavyImpact();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    } on FirebaseAuthException catch (error){
                      errorMessage = error.message!;
                    }
                    setState(() {});
                  }),
            ),
          ],
        ),),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: mButtonColor.withOpacity(0.5),
      automaticallyImplyLeading: true,
      elevation: 0,
      title: Text(
        'ElderLand',
        style: TextStyle(
          color: mPrimaryTextColor,
          fontFamily: 'Montserrat',
        ),
      ),
    );
  }
}

class Roundedinput extends StatelessWidget {
  const Roundedinput({
    Key? key,
    required this.hintText,
    required this.onChange,
    required String suffixText,

  }) : super(key: key);

  final String hintText;
  final ValueChanged<bool> onChange;
  final String suffixText = '';

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 16
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: mPrimaryTextColor,
        ),
        suffixText: suffixText,
        suffixStyle: TextStyle(
          color: mPrimaryTextColor,
          fontSize: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(36),
          borderSide: BorderSide(
            color: mSecondBackgroundColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(36),
          borderSide: BorderSide(
            color: mSecondBackgroundColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(36),
          borderSide: BorderSide(
            color: mSecondBackgroundColor,
          ),
        ),
      ),
    );
  }
}