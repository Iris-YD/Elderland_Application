import 'package:flutter/material.dart';

import '../constant.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);
  final String text;
  final Function() press;

  @override
  Widget build(BuildContext context) {
     return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Stack(
        children: <Widget>[
          SizedBox(
            height: 80,
            width: 170,
            child: TextButton(
              child: Container(
                child: Text('$text',style: const TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,),
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(mButtonColor.withOpacity(0.5)),
              ),
              onPressed: press,
              // onPressed: () {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //       builder: (context) => SearchBranch()
              //       )
              //   );
              // }

            ),
          )

        ],
      ),
     );
  }
}