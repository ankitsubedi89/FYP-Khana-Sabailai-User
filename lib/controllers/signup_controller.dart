import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:khana_sabailai_user/baseurl.dart';
import 'package:khana_sabailai_user/routes.dart';
import 'package:khana_sabailai_user/utils/utils.dart';

class SignupController extends GetxController {
  late TextEditingController nameController,
      contactController,
      addressController,
      emailController,
      passwordController,
      confirmPasswordController;

  @override
  void onInit() {
    super.onInit();

    nameController = TextEditingController();
    contactController = TextEditingController();
    addressController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();

    nameController.dispose();
    contactController.dispose();
    addressController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  checkSignup() {
    if (nameController.text.isEmpty) {
      customGetSnackbar('*Name', 'Please enter your name.', 'error');
    } else if (contactController.text.isEmpty) {
      customGetSnackbar('*Contact', 'Please enter your contact.', 'error');
    } else if (addressController.text.isEmpty) {
      customGetSnackbar('*Address', 'Please enter your address.', 'error');
    } else if (emailController.text.isEmpty) {
      customGetSnackbar('*Email', 'Please enter your email.', 'error');
    } else if (GetUtils.isEmail(emailController.text) == false) {
      customGetSnackbar('*Email', 'Please enter valid email.', 'error');
    } else if (passwordController.text.isEmpty) {
      customGetSnackbar('*Password', 'Please enter your password.', 'error');
    } else if (confirmPasswordController.text != passwordController.text) {
      customGetSnackbar(
          '*Confirm Password', 'Password doesnot match!', 'error');
    } else {
      signup();
      // Get.showOverlay(
      //     asyncFunction: () => signup(), loadingWidget: const Loader());
    }
  }

  signup() async {
    var response =
        await http.post(Uri.parse('${baseurl}users/signup.php'), body: {
      'name': nameController.text,
      'contact': contactController.text,
      'address': addressController.text,
      'email': emailController.text,
      'password': passwordController.text,
    });
    var res = await json.decode(response.body);
    if (res['success']) {
      Get.offAllNamed(GetRoutes.login);
      nameController.clear();
      contactController.clear();
      addressController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();

      customGetSnackbar('Sign up Success!',
          'User has been successfully signed in!', 'success');
    } else {
      customGetSnackbar('Sign up failed!', res['message'][0], 'error');
    }
  }
}
