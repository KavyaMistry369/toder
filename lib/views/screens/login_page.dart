import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toder/controllers/controller_one.dart';
import 'package:toder/utils/routes.dart';

import '../../models/user_model.dart';
import '../../services/helpers/auth_helper.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController pswController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                "lib/views/assets/login.png",
                width: 300,
              ),
              const SizedBox(
                height: 30,
              ),
              const Row(
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 30,
                        color: CupertinoColors.activeBlue,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const Row(
                children: [
                  Text(
                    "Please Sign in to continue",
                    style: TextStyle(
                      fontSize: 18,
                      color: CupertinoColors.activeBlue,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              CupertinoTextField(
                controller: emailController,
                placeholder: "Email",
                prefix: const Icon(
                  Icons.email_outlined,
                  size: 30,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: CupertinoColors.systemGrey6,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CupertinoTextField(
                controller: pswController,
                placeholder: "Password",
                obscureText: Provider.of<ControllerOne>(context).isVisible,
                suffix: IconButton(
                    onPressed: () {
                      Provider.of<ControllerOne>(context, listen: false)
                          .changeVisible();
                    },
                    icon: Provider.of<ControllerOne>(context).isVisible
                        ? const Icon(Icons.visibility_off_outlined)
                        : const Icon(Icons.visibility_outlined)),
                prefix: const Icon(
                  Icons.lock_outline,
                  size: 30,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: CupertinoColors.systemGrey6,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "OR",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                    onTap: () async {
                      UserModel account =
                          await AuthHelper.authHelper.signInWithGoogle();
                      if (account.email != "") {
                        Navigator.of(context).pushReplacementNamed(
                            MyRoutes.home,
                            arguments: account);
                      }
                    },
                    child: Image.asset(
                      "lib/views/assets/google.png",
                      width: 50,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  final message = await AuthHelper.authHelper
                      .signInWithPasswordUsername(
                          email: emailController.text,
                          password: pswController.text);

                  String email = emailController.text;
                  String name = email
                      .substring(0, email.indexOf('@'))
                      .replaceAll(RegExp(r'[0-9]'), ' ')
                      .trim();
                  print(name); // Output: kavya mistry

                  UserModel acc = UserModel(
                      image:
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPjGnnelatTe1FbI6RHusiWG4wkbtmnjVC9uTBkSBX_g&s',
                      name: name,
                      email: emailController.text);

                  if (message!.contains('Success')) {
                    Navigator.of(context)
                        .pushReplacementNamed(MyRoutes.home, arguments: acc);
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                    ),
                  );

                  emailController.clear();
                  pswController.clear();
                },
                child: Container(
                  height: 50,
                  width: 500,
                  decoration: BoxDecoration(
                      color: CupertinoColors.activeBlue,
                      borderRadius: BorderRadius.circular(50)),
                  alignment: Alignment.center,
                  child: const Text(
                    "Sign In",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't Have An Account ? "),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(MyRoutes.register);
                      },
                      child: const Text("Sign Up"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
