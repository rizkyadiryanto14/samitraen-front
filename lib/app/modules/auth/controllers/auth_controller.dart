import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:samitraen_frontend/app/routes/app_pages.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final alamatController = TextEditingController();

  var userName = ''.obs;
  var userEmail = ''.obs;
  var userRole = ''.obs;
  var userWilayah = ''.obs;
  var userFotoProfil = ''.obs;

  var isLoading = false.obs;
  var accessToken = ''.obs;
  var errorMessage = ''.obs;

  final String loginUrl =
      'http://192.168.18.61/samitraen-backend/public/api/login';
  final String registerUrl =
      'http://192.168.18.61/samitraen-backend/public/api/register';

  Future<void> login() async {
    isLoading.value = true;
    errorMessage.value = '';

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        accessToken.value = responseBody['data']['access_token'];
        userName.value = responseBody['data']['user']['name'];
        userEmail.value = responseBody['data']['user']['email'];
        userRole.value = responseBody['data']['user']['role'];
        userWilayah.value = responseBody['data']['user']['wilayah'] ?? '';
        userFotoProfil.value =
            responseBody['data']['user']['foto_profil'] ?? '';

        print('Logged in as: ${userName.value} (${userRole.value})');
        Get.offAllNamed(Routes.HOME);
      } else {
        final responseBody = json.decode(response.body);
        errorMessage.value = responseBody['message'];

        Get.snackbar(
          'Login Gagal',
          errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      errorMessage.value = 'Terjadi Kesalahan';
      Get.snackbar(
        'Gagal',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register() async {
    isLoading.value = true;
    errorMessage.value = '';

    final email = emailController.text.trim();
    final name = nameController.text.trim();
    final alamat = alamatController.text.trim();
    final password = passwordController.text.trim();

    try {
      final response = await http.post(Uri.parse(registerUrl), body: {
        'email': email,
        'name': name,
        'alamat': alamat,
        'password': password
      });

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        Get.offAllNamed('/auth');
      } else {
        final responseBody = json.decode(response.body);
        errorMessage.value = responseBody['message'];

        Get.snackbar(
          'Login Gagal',
          errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      errorMessage.value = 'Terjadi Kesalahan';
      Get.snackbar(
        'Gagal',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      accessToken.value = '';
      userName.value = '';
      userEmail.value = '';
      userRole.value = '';
      userWilayah.value = '';
      userFotoProfil.value = '';

      // Navigate to the login page
      Get.offAllNamed(Routes.AUTH);
    } catch (e) {
      Get.snackbar(
        'Gagal Logout',
        'Terjadi kesalahan saat logout.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
