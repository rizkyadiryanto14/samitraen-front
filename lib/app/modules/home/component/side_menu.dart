import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samitraen_frontend/app/modules/auth/controllers/auth_controller.dart';
import 'package:samitraen_frontend/app/modules/wilayah/controllers/wilayah_controller.dart';
import 'package:samitraen_frontend/app/routes/app_pages.dart';
import 'package:ternav_icons/ternav_icons.dart';

class SideMenu extends StatelessWidget {
  SideMenu({super.key});

  final AuthController authController = Get.find<AuthController>();
  final WilayahController wilayahController = Get.find<WilayahController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width / 1.5,
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 100,
            child: DrawerHeader(
              child: Image.asset(
                "images/brand.png",
              ),
            ),
          ),
          DrawerListTile(
            icon: TernavIcons.lightOutline.home_2,
            title: "Wilayah",
            onTap: () {
              Get.toNamed(Routes.WILAYAH);
            },
          ),
          DrawerListTile(
            icon: TernavIcons.lightOutline.menu,
            title: "Unit",
            onTap: () {},
          ),
          DrawerListTile(
            icon: TernavIcons.lightOutline.bookmark,
            title: "Laporan",
            onTap: () {},
          ),
          DrawerListTile(
            icon: TernavIcons.lightOutline.logout,
            title: "Logout",
            onTap: () {
              authController.logout();
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      horizontalTitleGap: 0,
      leading: Icon(
        icon,
        color: Colors.grey,
        size: 19,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
