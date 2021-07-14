import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:helloworld/src/pages/widgets/widget.dart';
import 'package:helloworld/src/config/app_colors.dart';
import 'package:helloworld/src/pages/screens/signin/signin_view.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'changePassword_viewmodel.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
  final String email;

  ChangePassword({Key? key, required this.email}) : super(key: key);
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _currentpasswordVisible = false;
  bool _newpasswordVisible = false;
  bool _repeatnewpasswordVisible = false;
  TextEditingController _textFieldController = TextEditingController();
  bool show = true;
  _openDialog(context, ChangePasswordViewModel changePasswordViewModel,
      String email, bool show) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Verify code"),
                  TextField(
                    // onChanged: (String value) {
                    //   changePasswordViewModel.changeCurrentPassword(value);
                    // },
                    controller: _textFieldController,
                    decoration: InputDecoration(
                      hintText: "Verify code",
                      // errorText:
                      //     changePasswordViewModel.currentpassword.error
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  var result = await changePasswordViewModel.login(
                      email, _textFieldController.text);
                  if (result == true) {
                    Navigator.of(context).pop('dialog');
                  }
                  show = false;
                },
                child: Text("ACCEPT", style: TextStyle(color: colorGreen)),
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    // bool show = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    final changePasswordViewModel =
        Provider.of<ChangePasswordViewModel>(context);

    if (show) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _openDialog(context, changePasswordViewModel, widget.email, show);
      });
      show = false;
    }

    // Orientation orientation = MediaQuery.of(context).orientation;
    // if (orientation == Orientation.landscape) {
    //   screenWidth = mediaQueryData.size.height;
    //   screenHeight = mediaQueryData.size.width;
    // }
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    // Future.delayed(
    //     Duration.zero, showInformationDialog(context, changePasswordViewModel));
    // showInformationDialog(context, changePasswordViewModel);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBarMain('Change Password', context),
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
                                      'Change Password',
                                      style: TextStyle(
                                          color: colorDarkGray,
                                          fontSize: 24 * screenWidth * 0.003),
                                    )))),
                        // SizedBox(
                        //   height: 0.02 * screenHeight,
                        // ),
                        // SizedBox(
                        //     height: screenHeight * 0.1,
                        //     // width: screenWidth * 0.9,
                        //     child: TextField(
                        //         obscureText: !_currentpasswordVisible,
                        //         style: TextStyle(color: colorGray),
                        //         // style: hindTextStyle(),
                        //         onChanged: (String value) {
                        //           changePasswordViewModel
                        //               .changeCurrentPassword(value);
                        //         },
                        //         decoration: InputDecoration(
                        //           errorText: changePasswordViewModel
                        //               .currentpassword.error,
                        //           hintText: 'Current Password',
                        //           hintStyle: TextStyle(color: colorLightGray),
                        //           // hintStyle: TextStyle(color: Colors.white),
                        //           fillColor: Colors.white,
                        //           filled: true,

                        //           prefixIcon: Icon(Icons.lock),
                        //           border: OutlineInputBorder(
                        //               borderSide: new BorderSide(
                        //                   width: 1, color: Colors.white)),
                        //           suffixIcon: IconButton(
                        //               icon: Icon(
                        //                 // Based on passwordVisible state choose the icon
                        //                 _currentpasswordVisible
                        //                     ? Icons.visibility
                        //                     : Icons.visibility_off,
                        //                 color: colorGray,
                        //               ),
                        //               onPressed: () {
                        //                 // Update the state i.e. toogle the state of passwordVisible variable
                        //                 setState(() {
                        //                   _currentpasswordVisible =
                        //                       !_currentpasswordVisible;
                        //                 });
                        //               }),
                        //         ))),
                        SizedBox(
                          height: 0.02 * screenHeight,
                        ),
                        SizedBox(
                            height: screenHeight * 0.1,
                            // width: screenWidth * 0.9,
                            child: TextField(
                                obscureText: !_newpasswordVisible,
                                style: TextStyle(color: colorGray),
                                // style: hindTextStyle(),
                                onChanged: (String value) {
                                  changePasswordViewModel
                                      .changeNewPassword(value);
                                },
                                decoration: InputDecoration(
                                  errorText:
                                      changePasswordViewModel.newpassword.error,
                                  hintText: 'New Password',
                                  hintStyle: TextStyle(color: colorLightGray),
                                  // hintStyle: TextStyle(color: Colors.white),
                                  fillColor: Colors.white,
                                  filled: true,

                                  prefixIcon: Icon(Icons.lock),
                                  border: OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          width: 1, color: Colors.white)),
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        _newpasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: colorGray,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          _newpasswordVisible =
                                              !_newpasswordVisible;
                                        });
                                      }),
                                ))),
                        SizedBox(
                          height: 0.02 * screenHeight,
                        ),
                        SizedBox(
                            height: screenHeight * 0.1,
                            // width: screenWidth * 0.9,
                            child: TextField(
                                obscureText: !_repeatnewpasswordVisible,
                                style: TextStyle(color: colorGray),
                                // style: hindTextStyle(),
                                onChanged: (String value) {
                                  changePasswordViewModel
                                      .changeRepeatNewPassword(value);
                                },
                                decoration: InputDecoration(
                                  errorText: changePasswordViewModel
                                      .repeatnewpassword.error,
                                  hintText: 'Repeat New Password',
                                  hintStyle: TextStyle(color: colorLightGray),
                                  // hintStyle: TextStyle(color: Colors.white),
                                  fillColor: Colors.white,
                                  filled: true,

                                  prefixIcon: Icon(Icons.lock),
                                  border: OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          width: 1, color: Colors.white)),
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        _repeatnewpasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: colorGray,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          _repeatnewpasswordVisible =
                                              !_repeatnewpasswordVisible;
                                        });
                                      }),
                                ))),
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
                              onPressed:
                                  // () {
                                  //   print(widget.email);
                                  changePasswordViewModel.isValid
                                      ? () {
                                          changePasswordViewModel.submitData();
                                        }
                                      : null,
                              child: Text(
                                'Change Password',
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
                            ))
                      ],
                    )))));
  }
}
