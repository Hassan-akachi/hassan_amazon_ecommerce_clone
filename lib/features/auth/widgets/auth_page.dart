import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/auth/screens/signup-screen.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin =true;
  @override

  Widget build(BuildContext context) {
    void toggle(){
      setState((){
        isLogin =!isLogin;
      });
    }
    return isLogin ? AuthScreen(onClickedSignUp: toggle,):
    SignUpScreen(onClickedSignUp: toggle,);
  }

}
