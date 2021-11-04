import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constant.dart';
import 'profile.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {

  final nameController = TextEditingController();
  final genderController = TextEditingController();
  final phoneController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  // String uid = user!.uid;
  // String uid = '1';
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {

    CollectionReference userCollection =
    FirebaseFirestore.instance.collection('user') ;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mButtonColor.withOpacity(0.5),
        automaticallyImplyLeading: true,
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
              'Edit your profile:',
              style: TextStyle(
                // color: mPrimaryTextColor,
                fontFamily: 'Montserrat',
                fontSize: 24,
              ),
            ),
            SizedBox(
              height: 56,
            ),
            Form(
              // key: _key,
              child: Center(
                child: Column(
                  children: [
                    TextFormField(controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name *',
                        labelStyle: TextStyle(
                          color: mPrimaryTextColor,
                          fontSize: 19,
                          fontFamily: 'Montserrat',
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(36)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(36)),
                          borderSide: BorderSide(color: Color(0xFF5063FF),
                              width: 2.0
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 36,
                    ),
                    TextFormField(controller: genderController,
                      decoration: const InputDecoration(
                        labelText: 'Gender *',
                        labelStyle: TextStyle(
                          color: mPrimaryTextColor,
                          fontSize: 19,
                          fontFamily: 'Montserrat',
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(36)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(36)),
                          borderSide: BorderSide(color: Color(0xFF5063FF),
                              width: 2.0
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 36,
                    ),
                    TextFormField(controller: phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Mobile number *',
                        labelStyle: TextStyle(
                          color: mPrimaryTextColor,
                          fontSize: 19,
                          fontFamily: 'Montserrat',
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(36)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(36)),
                          borderSide: BorderSide(color: Color(0xFF5063FF),
                              width: 2.0
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 26,
                    ),
                    Center(
                      child: Text(errorMessage,
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Montserrat',
                          fontSize: 19,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 46,
                    ),
                    TextButton(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Text('Save',
                          style: TextStyle(
                            color: mPrimaryTextColor,
                            fontFamily: 'Montserrat',
                            fontSize: 19,
                          ),
                        ),
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(36),
                            )
                        ),
                        backgroundColor:
                        MaterialStateProperty.all(Color(0xFF5063FF).withOpacity(0.5)),
                        //mButtonColor.withOpacity(0.5),
                      ),
                      onPressed: () async {
                        if (user != null) {
                          userCollection.doc(user!.uid).set({
                            'uid': user!.uid,
                            'email' : user!.email,
                            //'email': 'profile@123.com',
                            'name': nameController.text,
                            'gender': genderController.text,
                            'phone': phoneController.text,
                          });
                          HapticFeedback.heavyImpact();
                          // after editing, go back to profile page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Profile()
                            ),
                          );
                        } else {
                          errorMessage = 'User does not exit';
                        }

                      },
                    ),
                  ],
                ),
              ),
            ),
            // Roundedinput(
            //   onChange: (value){},
            //   hintText: 'First Name', suffixText: '',
            // ),
            // SizedBox(
            //   height: 26,
            // ),
            // Roundedinput(
            //   onChange: (value){},
            //   hintText: 'Last Name', suffixText: '',
            // ),
            // SizedBox(
            //   height: 26,
            // ),
            // Roundedinput(
            //   onChange: (value){},
            //   hintText: 'Gender',
            //   suffixText: '',
            // ),
            // SizedBox(
            //   height: 26,
            // ),
            // Roundedinput(
            //   onChange: (value){},
            //   hintText: 'Age',
            //   suffixText: '',
            // ),

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