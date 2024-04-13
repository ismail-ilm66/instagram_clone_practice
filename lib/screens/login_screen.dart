import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone_practice/firebase/authentication.dart';
import 'package:instagram_clone_practice/responsive/mobile_screen.dart';
import 'package:instagram_clone_practice/responsive/responsive_layout.dart';
import 'package:instagram_clone_practice/responsive/web_screen.dart';
import 'package:instagram_clone_practice/screens/signup_screen.dart';
import 'package:instagram_clone_practice/utilities/colors.dart';
import 'package:instagram_clone_practice/utilities/size.dart';
import 'package:instagram_clone_practice/utilities/utils.dart';
import 'package:instagram_clone_practice/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signInUser() async {
    setState(() {
      isLoading = true;
    });
    if (emailController.text.isNotEmpty || passwordController.text.isNotEmpty) {
      String x = await AuthorizationMethods().signIn(
          email: emailController.text, password: passwordController.text);
      print(x);
      if (x == "Successfully Logged In") {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
          return const ResponsiveLayout(
            MobileScreen: MobileScreen(),
            WebScreen: WebScreen(),
          );
        }));
      } else {
        displaySnackBar(context, x);
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
      displaySnackBar(context, 'Please Fill All the required fields');
    }

    // print(x);
    // if (x == "Successfully Logged In") {
    //   // ignore: use_build_context_synchronously
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (_) {
    //         return const MainScreen();
    //       },
    //     ),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: MediaQuery.of(context).size.width >= webSize
              ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3,
                )
              : const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              SvgPicture.asset(
                'assets\/ic_instagram.svg',
                color: Colors.white,
              ),
              const SizedBox(
                height: 24,
              ),
              InputTextField(
                textEditingController: emailController,
                isPassword: false,
                hintText: 'Email',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 24,
              ),
              InputTextField(
                textEditingController: passwordController,
                isPassword: true,
                hintText: 'Password',
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: signInUser,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    //  alignment: Alignment.center,
                  ),
                  child: isLoading
                      ? Container(
                          height: 30,
                          width: 30,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Login',
                          style: TextStyle(
                            color: blueColor,
                          ),
                        ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text('Don\'t Have an Account? ')),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const SignUpScreen();
                          },
                        ),
                      );
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
