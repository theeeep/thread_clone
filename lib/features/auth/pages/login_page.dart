import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:thread_clone/core/themes/app_pallate.dart';
import 'package:thread_clone/features/auth/widgets/auth_field.dart';
import 'package:thread_clone/features/auth/widgets/auth_gradient_btn.dart';
import 'package:thread_clone/routes/route_names.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Image.asset(
                "assets/images/logo.png",
                height: 60,
                width: 60,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Form(
                  key: formKey,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Log In",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Welcome Back",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              AuthField(
                hintText: "Enter Email Id",
                label: "Email Id",
                controller: emailController,
              ),
              const SizedBox(height: 20),
              AuthField(
                hintText: "Enter Password",
                label: "Password",
                isObscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 25),
              AuthGradientBtn(
                btnText: "Log In",
                onPressed: () {},
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => Get.toNamed(RouteNames.signUp),
                child: RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account ? ',
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: ' Sign Up',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppPallete.gradient2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
