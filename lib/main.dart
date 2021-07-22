// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/src/pages/screens/changePassword/changePassword_viewmodel.dart';
import 'package:helloworld/src/pages/screens/chat/chat_viewmodel.dart';
import 'package:helloworld/src/pages/screens/forgotPassword/forgotPassword_viewmodel.dart';
import 'package:helloworld/src/pages/screens/selectContact/selectcontact_view.dart';
import 'package:helloworld/src/pages/screens/signin/signin_view.dart';
import 'package:helloworld/src/pages/screens/signin/signin_viewmodel.dart';
import 'package:helloworld/src/pages/screens/signup/signup_viewmodel.dart';
import 'package:helloworld/src/pages/screens/welcome/welcome_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignInViewModel()),
        ChangeNotifierProvider(create: (context) => SignUpViewModel()),
        ChangeNotifierProvider(create: (context) => ForgotPasswordViewModel()),
        ChangeNotifierProvider(create: (context) => ChangePasswordViewModel()),
        // ChangeNotifierProvider(create: (context) => ChatViewModel()),
        // ChangeNotifierProvider(create: (context) => HomeViewModel()),
      ],
      child: MaterialApp(
          title: 'Chat App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.lightGreen,
              visualDensity: VisualDensity.adaptivePlatformDensity),
          home: SignIn()),
    );
  }
}
