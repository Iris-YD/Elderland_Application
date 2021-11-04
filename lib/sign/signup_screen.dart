import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oc_v1/profile/profile_edit.dart';

import '../constant.dart';






class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';

  // bool _passwordVisible = false;
  // void passwordStatus() {
  //   setState(() {
  //     _passwordVisible = !_passwordVisible;
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

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
          ), // Auth User (Logged ' + (user == null ? 'out' : 'in') + ')
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  Text(
                    'Register',
                    style: TextStyle(
                      color: mPrimaryTextColor,
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Register with your email and password',
                  ),
                  SizedBox(
                    height: 56,
                  ),
                  Form(
                    key: _key,
                    child: Center(
                      child: Column(
                        children: [
                          TextFormField(controller: emailController,
                            validator: validateEmail,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.email, color: Color(0xFF5063FF)),
                              hintText: 'Email Address',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(36)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(36)),
                                borderSide: BorderSide(color: Color(0xFF5063FF),
                                    width: 2.0
                                ),
                              ),
                              // labelText: 'Email *',
                              // labelStyle: TextStyle(
                              //     color: mPrimaryTextColor,
                              //     fontSize: 24,
                              //     fontFamily: 'Montserrat',
                              // ),
                            ),
                          ),
                          SizedBox(
                            height: 36,
                          ),
                          TextFormField(controller: passwordController,
                            validator: validatePassword,
                            // obscureText: _passwordVisible ? false : true,
                            obscureText: true,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.lock, color: Color(0xFF5063FF)),
                              hintText: 'Password',
                              // suffixIcon: IconButton(
                              //   onPressed: () => passwordStatus(),
                              //   icon:
                              //     Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                              // ),
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
                              child: Text('Register',
                                style: TextStyle(
                                  color: mPrimaryTextColor,
                                  fontFamily: 'Montserrat',
                                  fontSize: 19,
                                ),
                              ),
                            ),
                            // child: Text('Register'),
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
                              if (_key.currentState!.validate()) {
                                try {
                                  await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passwordController.text
                                  );
                                  errorMessage = '';
                                  HapticFeedback.heavyImpact(); // vibration
                                  // create a user and then jump to profile
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfileEdit()
                                    ),
                                  );
                                } on FirebaseAuthException catch (error) {
                                  errorMessage = error.message!;
                                }
                                setState(() {});
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ]
            )
        )
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



//     return Scaffold(
//       appBar: buildAppBar(),
//       body: Container(
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               'Sign up',
//               style: TextStyle(
//                 color: mPrimaryTextColor,
//                 fontSize: 38,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(
//               height: 16,
//             ),
//             Text(
//               'Sign up with your email and password',
//             ),
//             SizedBox(
//               height: 36,
//             ),
//             Roundedinput(
//               onChange: (value){},
//               hintText: 'Username', suffixText: '',
//             ),
//             const SizedBox(
//               height: 26,
//             ),
//
//             // Roundedinput(
//             //   onChange: (value){},
//             //   hintText: 'Email Address', suffixText: '',
//             // ),
//             SizedBox(
//               height: 26,
//             ),
//             Roundedinput(
//               onChange: (value){},
//               hintText: 'Password',
//               suffixText: 'Show',
//             ),
//             SizedBox(
//               height: 26,
//             ),
//             Roundedinput(
//               onChange: (value){},
//               hintText: 'Confirm Password',
//               suffixText: 'Show',
//             ),
//             SizedBox(
//               height: 66,
//             ),
//             RoundedButton(
//               press: (){
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => Profile()
//                   ),
//                 );
//               },
//               text: 'Sign up',
//               backgroundColor: mButtonColor.withOpacity(0.5),
//               textColor: mPrimaryTextColor,
//             ),
//             // SizedBox(
//             //   height: 100,
//             // ),
//             // HaveAccount(),
//           ],
//         ),),
//     );
//   }
//
//   AppBar buildAppBar() {
//     return AppBar(
//       backgroundColor: mButtonColor.withOpacity(0.5),
//       automaticallyImplyLeading: true,
//       elevation: 0,
//       title: Text(
//         'The Elder Community',
//         style: TextStyle(
//           color: mPrimaryTextColor,
//           fontFamily: 'Montserrat',
//         ),
//       ),
//     );
//   }
// }

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