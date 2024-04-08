import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toder/models/user_model.dart';
import 'package:toder/services/helpers/auth_helper.dart';

import '../../controllers/controller_one.dart';
import '../../utils/routes.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
                "lib/views/assets/register.png",
                width: 300,
              ),
              const SizedBox(
                height: 30,
              ),
              const Row(
                children: [
                  Text(
                    "Register",
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
                    "Please register to login",
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
                  Icons.mail_outlined,
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
                    onTap: () async{
                      UserModel account = await AuthHelper.authHelper.signInWithGoogle();
                      if(account.email!=""){
                        Navigator.of(context).pushReplacementNamed(MyRoutes.home,arguments: account);
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
                onTap: () async{
                 final check = await  AuthHelper.authHelper.signUpWithPasswordUsername(
                      email: emailController.text, password: pswController.text);

                 UserModel acc = UserModel(image: '', name: '', email: emailController.text);


                 if (check!.contains('Success')) {
                   Navigator.of(context).pushReplacementNamed(MyRoutes.home,arguments: acc);
                 }
                 ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                     content: Text(check),
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
                    "Sign Up",
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
                  const Text("Already Have An Account ? "),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(MyRoutes.login);
                      },
                      child: const Text("Sign In"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
