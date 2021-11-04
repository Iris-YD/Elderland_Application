import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oc_v1/sign/login_screen.dart';

import '../constant.dart';

import 'rounded_button.dart';

class HaveAccount extends StatelessWidget {
  const HaveAccount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedButton(
      press: (){
        HapticFeedback.heavyImpact(); // vibration
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen(),
          ),
        );
      },
      text: 'Log in',
      backgroundColor: mButtonColor.withOpacity(0.5),
      textColor: mPrimaryTextColor,
    );
    //   TextButton(
    //   onPressed: () {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => LoginScreen(),
    //       ),
    //     );
    //   },
    //   child: Text('Log in'),
    // );
  }
}
                    //   onPressed: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => LoginScreen();
                    //          ),
                    //   );
                    //    },
                    // child: Text ('Log in'),
                    // ),
  //     RichText(
  //     text: TextSpan(
  //         style: TextStyle(
  //             color: mPrimaryTextColor
  //         ),
  //         children: [
  //           TextSpan(
  //               text: 'Already have an account?'
  //           ),
  //           // TextSpan(
  //           //   text: ' Log in',
  //           //   style: TextStyle(
  //           //       color: mYellowColor
  //           //   ),
  //           // )
  //           TextSpan(
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                       builder: (context) => LoginScreen();
  //                       ),
  //                 );
  //                 },
  //               child: Text ('Log in'),
  //             ),
  //           ),
  //         ],
  //     ),
  //   );
  // }

