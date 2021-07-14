import 'package:flutter/material.dart';
import 'package:helloworld/src/pages/widgets/widget.dart';
import 'package:helloworld/src/config/app_colors.dart';
import 'package:helloworld/src/pages/screens/signin/signin_view.dart';
import 'package:flutter/rendering.dart';
import 'package:helloworld/src/pages/screens/signup/signup_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    return Scaffold(
        appBar: appBarMain('Welcome', context),
        body: SingleChildScrollView(
          child: Container(
              // padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
            children: [
              SizedBox(
                height: 0.05 * screenHeight,
              ),
              Text('Welcome',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28.0 * screenWidth * 0.003,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto')),
              SizedBox(
                height: 0.1 * screenHeight,
              ),
              SizedBox(
                  // width: screenWidth * 0.9,
                  child: Container(
                height: screenWidth * 0.35,
                width: screenWidth * 0.35,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: colorGreen, borderRadius: BorderRadius.circular(28)),
                child: SvgPicture.asset('assets/images/phone.svg',
                    height: screenWidth * 0.3,
                    width: screenWidth * 0.3,
                    color: Colors.white,
                    allowDrawingOutsideViewBox: true),
              )),
              SizedBox(
                height: 0.02 * screenHeight,
              ),
              Text('C h a t  A p p',
                  style: TextStyle(
                    color: colorGreen,
                    fontSize: 24.0 * screenWidth * 0.003,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                height: 0.05 * screenHeight,
              ),
              SizedBox(
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            color: colorGreen,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20 * screenWidth * 0.003),
                        ),
                      )))
            ],
          )),
        ));
  }
}
