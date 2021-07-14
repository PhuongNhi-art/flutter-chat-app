import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:helloworld/src/pages/models/user_model.dart';
import 'package:helloworld/src/pages/screens/chat/chat_view.dart';
import 'package:helloworld/src/pages/screens/forgotPassword/forgotPassword_view.dart';
import 'package:helloworld/src/pages/screens/home/home_view.dart';
import 'package:helloworld/src/pages/screens/home/home_viewmodel.dart';
import 'package:helloworld/src/pages/screens/signin/signin_viewmodel.dart';
import 'package:helloworld/src/pages/widgets/widget.dart';
import 'package:helloworld/src/config/app_colors.dart';
import 'package:helloworld/src/pages/screens/signup/signup_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helloworld/src/share_preference/user_preference.dart';

import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _passwordVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    UserPreferences userPref = new UserPreferences();

    //remove user before
    if (userPref.getUser() != null) userPref.removeUser();
    //viewmodel signin
    final signInViewModel = Provider.of<SignInViewModel>(context);
    final homeViewModel = new HomeViewModel();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBarMain('Login', context),
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
                            height: screenHeight * 0.1,
                            // width: screenWidth * 0.9,
                            child: TextField(
                                onChanged: (String value) {
                                  signInViewModel.changeEmail(value);
                                },
                                style: hindTextStyle(),
                                decoration: InputDecoration(
                                  errorText: signInViewModel.email.error,
                                  hintText: 'Example@gmail.com',
                                  hintStyle: TextStyle(color: colorLightGray),
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: Icon(Icons.email),
                                  border: OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          width: 1, color: Colors.white)),
                                ))),
                        SizedBox(
                          height: 0.03 * screenHeight,
                        ),
                        SizedBox(
                            height: screenHeight * 0.1,
                            // width: screenWidth * 0.9,
                            child: TextField(
                                obscureText: !_passwordVisible,
                                style: TextStyle(color: colorGray),
                                // style: hindTextStyle(),
                                onChanged: (String value) {
                                  signInViewModel.changePassword(value);
                                },
                                decoration: InputDecoration(
                                  hintText: '*******',
                                  errorText: signInViewModel.password.error,
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
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: colorGray,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      }),
                                ))),
                        SizedBox(
                          height: 0.03 * screenHeight,
                        ),
                        SizedBox(
                            child: Container(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ForgotPassword()),
                                          );
                                        },
                                        child: Text(
                                          'Forgot password ?',
                                          style: TextStyle(

                                              // fontWeight: FontWeight.bold,
                                              color: colorDarkGray,
                                              fontSize:
                                                  16 * screenWidth * 0.003),
                                        ))))),
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
                              onPressed: signInViewModel.isValid
                                  ? () async {
                                      await signInViewModel.submitData();
                                      UserModel userPrefModel =
                                          await userPref.getUser();
                                      if (userPrefModel.id != null) {
                                        await homeViewModel
                                            .getUserWithLastMsg();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Home(
                                                  chatModel:
                                                      homeViewModel.usersTemp)),
                                        );
                                      }
                                    }
                                  : null,
                              child: Text(
                                'Login',
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
                                  "Don't Have An Account? ",
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
                                            builder: (context) => SignUp()),
                                      );
                                    },
                                    child: Text("Sign In Up Now",
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
