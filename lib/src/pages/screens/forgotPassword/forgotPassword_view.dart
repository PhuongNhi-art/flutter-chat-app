import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:helloworld/src/pages/screens/changePassword/changePassword_view.dart';
import 'package:helloworld/src/pages/screens/forgotPassword/forgotPassword_viewmodel.dart';
import 'package:helloworld/src/pages/widgets/widget.dart';
import 'package:helloworld/src/config/app_colors.dart';
import 'package:helloworld/src/pages/screens/signin/signin_view.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:progress_dialog/progress_dialog.dart'
    show ProgressDialog, ProgressDialogType;

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool _passwordVisible = false;
  bool _repasswordVisible = false;

  late ProgressDialog progressDialog;
  var percentage = 0.0;

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    final forgotPasswordViewModel =
        Provider.of<ForgotPasswordViewModel>(context);

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBarMain('Forgot Password', context),
        body: SingleChildScrollView(
            child: Container(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 0.04 * screenHeight,
                        ),
                        SizedBox(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                child: Container(
                              height: screenWidth * 0.15,
                              width: screenWidth * 0.15,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                  color: colorGreen,
                                  borderRadius: BorderRadius.circular(20)),
                              child: SvgPicture.asset('assets/images/phone.svg',
                                  height: screenWidth * 0.1,
                                  width: screenWidth * 0.1,
                                  color: Colors.white,
                                  allowDrawingOutsideViewBox: true),
                            )),
                            SizedBox(
                              width: 0.04 * screenWidth,
                            ),
                            Text(
                              "C h a t  A p p ",
                              style: TextStyle(
                                color: colorGreen,
                                fontSize: 28 * screenWidth * 0.0025,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )),
                        SizedBox(
                          height: 0.03 * screenHeight,
                        ),
                        SizedBox(
                          height: 0.03 * screenHeight,
                        ),
                        SizedBox(
                            child: Container(
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Forgot password',
                                      style: TextStyle(
                                          color: colorDarkGray,
                                          fontSize: 24 * screenWidth * 0.003),
                                    )))),
                        SizedBox(
                          height: 0.02 * screenHeight,
                        ),
                        SizedBox(
                            height: screenHeight * 0.1,
                            child: TextField(
                              onChanged: (String value) {
                                forgotPasswordViewModel.changeEmail(value);
                              },
                              style: hindTextStyle(),
                              decoration: textFieldInputDecoration(
                                  'Your Email', Icons.email),
                            )),
                        SizedBox(
                          height: 0.03 * screenHeight,
                        ),
                        SizedBox(
                            // width: screenWidth * 0.9,
                            width: screenWidth * 0.9,
                            child: RaisedButton(
                              color: colorGreen,
                              padding: EdgeInsets.symmetric(vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onPressed: forgotPasswordViewModel.isValid
                                  ? () async {
                                      var result = await forgotPasswordViewModel
                                          .forgotPassword();
                                      if (result == true) {
                                        progressDialog.show();
                                        Future.delayed(Duration(seconds: 2))
                                            .then((value) => {
                                                  percentage =
                                                      percentage + 100.0,
                                                  progressDialog.update(
                                                      progress: percentage),
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChangePassword(
                                                              email: forgotPasswordViewModel
                                                                  .email.value
                                                                  .toString()),
                                                    ),
                                                  ),
                                                });
                                      }
                                    }
                                  : null,
                              child: Text(
                                'Continue',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18 * screenWidth * 0.003),
                              ),
                            )),
                        SizedBox(
                          height: 0.03 * screenHeight,
                        ),
                        SizedBox(
                            width: screenWidth * 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Have Already An Account? ",
                                  style: TextStyle(
                                    color: colorDarkGray,
                                    fontSize: 18 * screenWidth * 0.0025,
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignIn()),
                                      );
                                    },
                                    child: Text("Sign In Here",
                                        style: TextStyle(
                                          color: colorGreen,
                                          fontSize: 19 * screenWidth * 0.0025,
                                          fontWeight: FontWeight.bold,
                                        )))
                              ],
                            )),
                        SizedBox(
                          height: 0.03 * screenHeight,
                        ),
                        // LinearProgressIndicator(
                        //   backgroundColor: Colors.green,
                        // )
                      ],
                    )))));
  }
}
