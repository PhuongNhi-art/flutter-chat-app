import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:helloworld/src/pages/models/user_model.dart';
import 'package:helloworld/src/pages/screens/home/home_view.dart';
import 'package:helloworld/src/pages/screens/signup/signup_viewmodel.dart';
import 'package:helloworld/src/pages/widgets/widget.dart';
import 'package:helloworld/src/config/app_colors.dart';
import 'package:helloworld/src/pages/screens/signin/signin_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helloworld/src/share_preference/user_preference.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late bool _passwordVisible = false;
  late bool _repasswordVisible = false;

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

    //viewmodel signup
    final signUpViewModel = Provider.of<SignUpViewModel>(context);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBarMain('Register', context),
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
                            child: TextField(
                              style: hindTextStyle(),
                              onChanged: (String value) {
                                signUpViewModel.changeUsername(value);
                              },
                              decoration: InputDecoration(
                                hintText: 'Your name',
                                errorText: signUpViewModel.username.error,
                                hintStyle: TextStyle(color: colorLightGray),
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        width: 1, color: Colors.white)),
                              ),
                            )),
                        SizedBox(
                          height: 0.03 * screenHeight,
                        ),
                        SizedBox(
                          height: screenHeight * 0.1,
                          child: TextField(
                              style: hindTextStyle(),
                              onChanged: (String value) {
                                signUpViewModel.changeEmail(value);
                              },
                              decoration: InputDecoration(
                                errorText: signUpViewModel.email.error,
                                hintText: 'Your email',
                                hintStyle: TextStyle(color: colorLightGray),
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        width: 1, color: Colors.white)),
                              )),
                        ),
                        SizedBox(
                          height: 0.03 * screenHeight,
                        ),
                        SizedBox(
                            height: screenHeight * 0.1,
                            child: TextField(
                                style: TextStyle(color: colorGray),
                                obscureText: !_passwordVisible,
                                onChanged: (String value) {
                                  signUpViewModel.changePassword(value);
                                },
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  errorText: signUpViewModel.password.error,
                                  hintStyle: TextStyle(color: colorLightGray),
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: Icon(Icons.lock),
                                  border: OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          width: 1, color: Colors.white)),
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: colorGray,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      }),
                                ))),
                        SizedBox(
                          height: 0.03 * screenHeight,
                        ),
                        SizedBox(
                            height: screenHeight * 0.1,
                            child: TextField(
                                obscureText: !_repasswordVisible,
                                style: hindTextStyle(),
                                onChanged: (String value) {
                                  signUpViewModel.changeRepassword(value);
                                },
                                decoration: InputDecoration(
                                  errorText: signUpViewModel.repassword.error,
                                  hintText: 'Repeat your password',
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintStyle: TextStyle(color: colorLightGray),
                                  prefixIcon: Icon(Icons.lock),
                                  border: OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          width: 1, color: Colors.white)),
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        _repasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: colorGray,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          _repasswordVisible =
                                              !_repasswordVisible;
                                        });
                                      }),
                                ))),
                        SizedBox(
                          height: 0.03 * screenHeight,
                        ),
                        SizedBox(
                            width: screenWidth * 0.9,
                            child: RaisedButton(
                              color: colorGreen,
                              padding: EdgeInsets.symmetric(vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onPressed: signUpViewModel.isValid
                                  ? () async {
                                      await signUpViewModel.submitData();
                                      UserModel userPrefModel =
                                          await userPref.getUser();
                                      print(userPrefModel.id);
                                      if (userPrefModel.id != null) {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) => Home()),
                                        // );
                                      }
                                    }
                                  : null,
                              child: Text(
                                'Register',
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
                                    child: Text("Sign in here",
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
