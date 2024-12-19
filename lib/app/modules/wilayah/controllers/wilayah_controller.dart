import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:samitraen_frontend/app/modules/auth/controllers/auth_controller.dart';

class WilayahController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  var isLoading = false.obs;

  // Menyimpan data wilayah dalam RxList
  var wilayahList = <Map<String, dynamic>>[].obs;

  Future<void> fetchWilayah() async {
    isLoading.value = true;
    const String apiUrl =
        'http://192.168.18.61/samitraen-backend/public/api/petugas/wilayah';
    final String token = authController.accessToken.value;

    if (token.isEmpty) {
      print("Error: Token tidak tersedia. Pastikan Anda sudah login.");
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      // Log untuk memeriksa respons API
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        print("Decoded response body: $responseBody");

        // Memastikan respons memiliki data yang benar
        if (responseBody['status'] == 'success' &&
            responseBody['data'] != null) {
          // Menyimpan data wilayah ke dalam wilayahList
          wilayahList.value =
              List<Map<String, dynamic>>.from(responseBody['data']);
          print("WilayahList after update: $wilayahList");
        } else {
          print("Error: ${responseBody['message']}");
        }
      } else {
        print("Error: ${response.statusCode}");
        print("Response Body: ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
