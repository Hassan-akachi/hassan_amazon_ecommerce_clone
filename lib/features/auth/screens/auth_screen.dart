import 'package:amazon_clone/common/widget/email_text_field.dart';
import 'package:amazon_clone/constant/color.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../common/widget/custom_edittext_box.dart';
import '../services/auth_service.dart';
import '../widgets/passwordEditText.dart';
import '../../../common/widget/sign_button.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen'; //the screen routeName
  final GestureTapCallback? onClickedSignUp;

  const AuthScreen({super.key, this.onClickedSignUp});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool showText = true;

  void showPassword() {
    setState(() {
      showText = !showText;
    });
  }

  void signInUser() {
    authService.signInUser(
        context: context,
        email: emailcontroller.text,
        password: passwordcontroller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("sign in"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Form(
                key: formKey,
                child: AutofillGroup(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AuthTextField(
                        hint: "email",
                        inputType: TextInputType.emailAddress,
                        controller: emailcontroller,
                        autofillHints: const [AutofillHints.email],
                      ),
                      const SizedBox(height: 20),
                      PasswordEditText(
                        showText: showText,
                        hint: "Password",
                        inputType: TextInputType.number,
                        controller: passwordcontroller,
                        autofillHint: const [AutofillHints.password],
                        onPressed: showPassword,
                        onEditComplete: () => TextInput.finishAutofillContext(),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: CustomButton(
                                buttoncolor: GlobalColor.secondaryColor,
                                textcolor: Colors.white,
                                buttonText: "login",
                                onPressed: () {
                                  if(formKey.currentState!.validate()){
                                    signInUser();}
                                  // AuthService().signin(
                                  //     emailcontroller.text.trim(),
                                  //     passwordcontroller.text.trim(),
                                  //     context,
                                  //     formKey);
                                },
                                iconData: Icons.lock),
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(230, 230, 230, 1),
                                    borderRadius: BorderRadius.circular(15)),
                                child: IconButton(
                                    onPressed: () {},
                                    // onPressed: ()async {
                                    //   final isAuthentication =await LocalAuthApi.authenticate();
                                    //   if(isAuthentication){
                                    //     navigatorKey.currentState!.pushReplacementNamed(HomeScreen.routeName);
                                    //   }
                                    // },
                                    icon: const Icon(Icons.fingerprint)),
                              ))
                        ],
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, bottom: 20),
                        child: GestureDetector(
                          child: const Text(
                            "forget Password",
                            style: TextStyle(
                                fontSize: 20,
                                color: GlobalColor.secondaryColor,
                                decoration: TextDecoration.underline),
                          ),
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //         const ForgetPasswordScreen()));
                          },
                        ),
                      ),
                      RichText(
                          text: TextSpan(
                              text: "don't have an account",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                              children: [
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = widget.onClickedSignUp,
                                text: " sign up",
                                style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: GlobalColor.secondaryColor))
                          ])),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                        buttoncolor: Colors.white,
                        textcolor: GlobalColor.secondaryColor,
                        buttonText: "Sign up Google",
                        onPressed: () {

                          // Provider.of<AuthProvider>(context,listen: false).googleLogIn();
                        },
                        iconData: FontAwesomeIcons.google,
                      ),
                    ],
                  ),
                ),
              )),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }
}
