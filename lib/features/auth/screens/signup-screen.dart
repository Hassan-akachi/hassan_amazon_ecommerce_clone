import 'package:amazon_clone/common/widget/email_text_field.dart';
import 'package:amazon_clone/constant/color.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../constant/style.dart';
import '../../../common/widget/custom_edittext_box.dart';
import '../widgets/passwordEditText.dart';
import '../../../common/widget/sign_button.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = "Sign-up-Screen";

  final GestureTapCallback? onClickedSignUp;

  const SignUpScreen({super.key, this.onClickedSignUp});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _userNamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmcontroller = TextEditingController();
  bool showText = true;
  bool conpass = false;

  bool confirmPassword() {
    setState(() {
      if (passwordcontroller.text == confirmcontroller.text) {
        conpass = true;
      }
    });
    return conpass;
  }

  void showPassword() {
    setState(() {
      showText = !showText;
    });
  }

  void signUpUser() {
    authService.signUpUser(
        context: context,
        email: emailcontroller.text,
        password: passwordcontroller.text,
        name: _userNamecontroller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("sign up"),
      //   centerTitle: true,
      // ),
      backgroundColor: Colors.white,
      body: Padding(
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
                    TextFormField(
                      decoration: kEmailEditTextDecoration.copyWith(
                          hintText: "userName", labelText: "UserName"),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      controller: _userNamecontroller,
                      autofillHints: const [AutofillHints.name],
                      //use to validate email
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthTextField(
                      hint: "type your email",
                      inputType: TextInputType.emailAddress,
                      controller: emailcontroller,
                      autofillHints: const [AutofillHints.email],
                    ),

                    // IntlPhoneField(
                    //   decoration: const InputDecoration(
                    //     labelText: 'Phone Number',
                    //     border: OutlineInputBorder(
                    //       borderSide: BorderSide(),
                    //     ),
                    //   ),
                    //   initialCountryCode: "NGN",
                    //   onChanged: (phone) {
                    //     // setState((){_phonecontroller.text=phone.completeNumber;});
                    //     _phonecontroller.text = phone.completeNumber;
                    //     print(
                    //         "${phone.completeNumber}\n${_phonecontroller.text}");
                    //   },
                    //   onCountryChanged: (country) {
                    //     print('Country changed to: ' + country.name);
                    //   },
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    PasswordEditText(
                      showText: showText,
                      hint: "type your password",
                      inputType: TextInputType.number,
                      controller: passwordcontroller,
                      autofillHint: const [AutofillHints.password],
                      onPressed: showPassword,
                    ),
                    const SizedBox(height: 20),
                    PasswordEditText(
                      showText: showText,
                      hint: "confirm  your password",
                      inputType: TextInputType.number,
                      controller: confirmcontroller,
                      autofillHint: const [AutofillHints.password],
                      onPressed: showPassword,
                    ),
                    const SizedBox(height: 20),
                    // confirmPassword() ?
                    Visibility(
                      visible: confirmPassword(),
                      child: CustomButton(
                          buttoncolor: GlobalColor.secondaryColor,
                          textcolor: Colors.white,
                          buttonText: "sign up",
                          onPressed: () {
                            final isValid = formKey.currentState!.validate();
                            bool conpass = passwordcontroller.text ==
                                confirmcontroller.text;
                            if (conpass && isValid) {
                              signUpUser();
                            }
                            // AuthService().signup(
                            //     context,
                            //     emailcontroller.text.trim(),
                            //     passwordcontroller.text.trim(),
                            //     _userNamecontroller.text.trim(),
                            //     formKey);
                            // Provider.of<AuthProvider>(context, listen: false)
                            //     .createUserWithPhone(_phonecontroller.text);
                            // navigatorKey.currentState!
                            //     .pushReplacement(MaterialPageRoute(
                            //     builder: (context) => OtpScreen(
                            //       phoneNumber:
                            //       _phonecontroller.text.trim(),
                            //     )));
                          },
                          iconData: Icons.lock_open),
                    )
                    // : const Text(
                    //     "password is not same",
                    //     style: TextStyle(color: Colors.red, fontSize: 20),
                    //   )
                    ,
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: RichText(
                          text: TextSpan(
                              text: "Already have an account? ",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                              children: [
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = widget.onClickedSignUp,
                                text: "sign in",
                                style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: GlobalColor.secondaryColor))
                          ])),
                    )
                  ]),
            ),
          )),
    );
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    _phonecontroller.dispose();
    _userNamecontroller.dispose();
    super.dispose();
  }
}
