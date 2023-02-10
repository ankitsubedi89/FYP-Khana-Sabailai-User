import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khana_sabailai_user/controllers/signup_controller.dart';
import 'package:khana_sabailai_user/routes.dart';
import 'package:khana_sabailai_user/widgets/custom_button.dart';
import 'package:khana_sabailai_user/widgets/custom_text_field.dart';
import 'package:khana_sabailai_user/widgets/rich_text_bar.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SignupController>(builder: (controller) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                SvgPicture.asset(
                  'assets/svg/logo.svg',
                  width: 80,
                  color: Colors.black,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 30,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    CustomFormField(
                      label: 'Full Name',
                      prefixIcon: const Icon(Icons.person),
                      controller: controller.nameController,
                    ),
                    const SizedBox(height: 10),
                    CustomFormField(
                      label: 'Contact',
                      prefixIcon: const Icon(Icons.phone),
                      controller: controller.contactController,
                    ),
                    const SizedBox(height: 10),
                    CustomFormField(
                      label: 'Address',
                      prefixIcon: const Icon(Icons.location_pin),
                      controller: controller.addressController,
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 10),
                    CustomFormField(
                      label: 'Email',
                      prefixIcon: const Icon(Icons.mail),
                      controller: controller.emailController,
                    ),
                    const SizedBox(height: 10),
                    CustomFormField(
                      label: 'Password',
                      prefixIcon: const Icon(Icons.key),
                      controller: controller.passwordController,
                      isObscure: true,
                    ),
                    const SizedBox(height: 10),
                    CustomFormField(
                      label: 'Confirm Password',
                      prefixIcon: const Icon(Icons.key),
                      isObscure: true,
                      controller: controller.confirmPasswordController,
                    ),
                    const SizedBox(height: 15),
                    CustomButton(
                        label: 'Sign Up',
                        onPressed: () {
                          controller.checkSignup();
                        })
                  ],
                ),
                const SizedBox(height: 40),
                RichTextBar(
                  normal: 'Already have an account? ',
                  rich: 'Login',
                  onPressed: () {
                    Get.offAllNamed(GetRoutes.login);
                  },
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        );
      }),
    );
  }
}
