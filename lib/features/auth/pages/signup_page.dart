import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:thread_clone/core/themes/app_pallate.dart';
import 'package:thread_clone/features/auth/controllers/auth_controller.dart';
import 'package:thread_clone/features/auth/widgets/auth_field.dart';
import 'package:thread_clone/features/auth/widgets/auth_gradient_btn.dart';
import 'package:thread_clone/routes/route_names.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final cPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final authController = Get.put(AuthController());

  void submit() {
    if (formKey.currentState!.validate()) {
      authController.signUp(
        userNameController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      debugPrint("Good to go Chief 🫡");
    }
  }

  // @override
  // void dispose() {
  //   emailController.dispose();
  //   userNameController.dispose();
  //   passwordController.dispose();
  //   cPasswordController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    height: 60,
                    width: 60,
                  ),
                  const SizedBox(height: 30),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Welcome to thread",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  AuthField(
                    hintText: "Enter User Name",
                    label: "User Name",
                    controller: userNameController,
                    validatorCallback: ValidationBuilder()
                        .required()
                        .minLength(6)
                        .maxLength(20)
                        .build(),
                  ),
                  const SizedBox(height: 22),
                  AuthField(
                    hintText: "Enter Email Id",
                    label: "Email Id",
                    controller: emailController,
                    validatorCallback:
                        ValidationBuilder().required().email().build(),
                  ),
                  const SizedBox(height: 22),
                  AuthField(
                    hintText: "Enter Password",
                    label: "Password",
                    isObscureText: true,
                    controller: passwordController,
                    validatorCallback: ValidationBuilder()
                        .required()
                        .minLength(6)
                        .maxLength(20)
                        .build(),
                  ),
                  const SizedBox(height: 22),
                  AuthField(
                    hintText: "Enter Confirm Password",
                    label: "Confirm Password",
                    isObscureText: true,
                    controller: cPasswordController,
                    validatorCallback: (arg) {
                      if (passwordController.text != arg) {
                        return "Confirm Password Not Match! ";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  Obx(
                    () => AuthGradientBtn(
                      btnText: authController.signUpLoading.value
                          ? "Processing..."
                          : "Sign Up",
                      onPressed: submit,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Get.toNamed(RouteNames.logIn),
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account ? ',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: ' Sign In',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
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
          ),
        ),
      ),
    );
  }
}
