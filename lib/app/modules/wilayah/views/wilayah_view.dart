import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/wilayah_controller.dart';

class WilayahView extends GetView<WilayahController> {
  const WilayahView({super.key});

  @override
  void onInit() {
    controller
        .fetchWilayah(); // Memanggil fetchWilayah saat halaman pertama kali diinisialisasi
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wilayah'),
        centerTitle: true,
      ),
      body: Obx(() {
        // Menampilkan indikator loading saat data sedang dimuat
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // Jika data sudah tersedia
        if (controller.wilayahList.isEmpty) {
          return const Center(
            child: Text("Tidak ada data wilayah."),
          );
        }

        return ListView.builder(
          itemCount: controller.wilayahList.length,
          itemBuilder: (context, index) {
            final wilayah = controller.wilayahList[index];

            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  wilayah['nama_wilayah'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Latitude: ${wilayah['latitude']}"),
                    Text("Longitude: ${wilayah['longitude']}"),
                    Text("Jumlah Unit: ${wilayah['jumlah_unit']}"),
                    Text("Jumlah Pelaporan: ${wilayah['jumlah_pelaporan']}"),
                  ],
                ),
                leading: Icon(
                  Icons.location_on,
                  color: Theme.of(context).primaryColor,
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Action when tapped, can navigate to another screen if needed
                  print("Tapped on ${wilayah['nama_wilayah']}");
                },
              ),
            );
          },
        );
      }),
    );
  }
}
