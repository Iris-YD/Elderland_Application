import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oc_v1/sign/signup_screen.dart';
import 'package:oc_v1/widget/rounded_button.dart';
import 'package:oc_v1/constant.dart';
import 'package:oc_v1/widget/have_account.dart';



class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 66,
            ),
            Image.asset('assets/images/openp2.jpeg'),
            SizedBox(
              height: 100,
            ),
            HaveAccount(), // log in
            SizedBox(
              height: 20,
            ),
            RoundedButton(
              press: (){
                HapticFeedback.heavyImpact(); // vibration
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignupScreen()
                  ),
                );
              },
              text: 'Register',
              backgroundColor: mButtonColor.withOpacity(0.5),
              textColor: mPrimaryTextColor,
            ),

          ],
        ),

      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: mBackgroundColor,
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
