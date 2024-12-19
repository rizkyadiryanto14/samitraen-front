import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:samitraen_frontend/app/modules/auth/controllers/auth_controller.dart';
import 'package:samitraen_frontend/app/modules/wilayah/controllers/wilayah_controller.dart';

import 'app/routes/app_pages.dart';

void main() {
  Get.put(AuthController());
  Get.lazyPut(() => WilayahController());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
