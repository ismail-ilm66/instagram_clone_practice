import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone_practice/firebase/authentication.dart';
import 'package:instagram_clone_practice/utilities/utils.dart';
import 'package:instagram_clone_practice/widgets/text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  double? height;
  //final AuthorizationMethods authorizationMethods = AuthorizationMethods();
  Uint8List? image;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    bioController.dispose();
  }

  void getheight() {
    height = getheightofDevice(context);
  }

  void pickImage() async {
    var i = await chooseImage();
    if (i == null && image == null) {
      displaySnackBar(context, 'No Image Is Selected!');
    } else {
      setState(() {
        image = i;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              SvgPicture.asset(
                'assets\/ic_instagram.svg',
                // ignore: deprecated_member_use
                color: Colors.white,
              ),
              const SizedBox(
                height: 24,
              ),
              Stack(
                children: [
                  image != null
                      ? CircleAvatar(
                          radius: 64, backgroundImage: MemoryImage(image!))
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://st3.depositphotos.com/4111759/13425/v/1600/depositphotos_134255710-stock-illustration-avatar-vector-male-profile-gray.jpg'),
                        ),
                  Positioned(
                    left: 80,
                    bottom: -10,
                    child: IconButton(
                      onPressed: () {
                        pickImage();
                      },
                      icon: Icon(Icons.add_a_photo),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              InputTextField(
                textEditingController: usernameController,
                isPassword: false,
                hintText: ' UserName',
                textInputType: TextInputType.text,
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
              InputTextField(
                textEditingController: bioController,
                isPassword: false,
                hintText: ' Bio',
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    String x = await AuthorizationMethods().signUp(
                      username: usernameController.text,
                      email: emailController.text,
                      password: passwordController.text,
                      bio: bioController.text,
                      image: image!,
                    );
                    displaySnackBar(context, x);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    //  alignment: Alignment.center,
                  ),
                  child: const Text('SignUp'),
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
                      child: const Text('Already Have an Account? ')),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          'Sign In',
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
