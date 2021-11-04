import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async{
  // Modify from here
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AuthState());
  // to here.
}

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