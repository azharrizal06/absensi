import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../controllers/navigasi_controller.dart';
import '../../../routes/app_pages.dart';
import '../controllers/profil_controller.dart';

class ProfilView extends GetView<ProfilController> {
  final navc = Get.find<NavigasiController>();
  @override
  Widget build(BuildContext context) {
    double tinggi = MediaQuery.of(context).size.height;
    double lebar = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              // color: Colors.amber,
              width: lebar,
              height: tinggi * 0.45,
              child: Image.asset(
                "gambar/gambar2.png",
                fit: BoxFit.fill,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // color: Colors.black87,
                  width: lebar,
                  height: tinggi * 0.35,
                  child: Image.asset(
                    "gambar/gambar1.png",
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  // color: Colors.pink,
                  width: lebar,
                  height: tinggi * 0.20,
                  child: Image.asset(
                    "gambar/gambar3.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView(children: [
                StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: controller.getprofil(),
                    builder: (context, snp) {
                      print(snp.data?.data());
                      if (snp.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: LottieBuilder.asset("lottie/loading.json"));
                      }
                      Map<String, dynamic>? user = snp.data?.data();
                      // if (snp.hasData) {
                      // String kosong =
                      //     'https://ui-avatars.com/api/?name=${user?["Nama"]}';};
                      return Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.defaultDialog(title: "profil", actions: [
                                    OutlinedButton(
                                        onPressed: () {
                                          controller.Hapus();
                                          Get.back();
                                        },
                                        child: Text("Hapus")),
                                    ElevatedButton(
                                        onPressed: () {
                                          controller.photo();
                                          Get.back();
                                        },
                                        child: Text("Edit"))
                                  ]);
                                },
                                child: Stack(
                                  children: [
                                    ClipOval(
                                        child: Container(
                                      height: 100,
                                      width: 100,
                                      color: Colors.grey,
                                      // child: GetBuilder<ProfilController>(
                                      //     builder: (c) {
                                      //   var gambar = user?['image'];
                                      //   var load = c.isLoading;
                                      //   if (load == true) {
                                      //     return CircularProgressIndicator();
                                      //   }
                                      //   if (gambar == null) {
                                      //     return Image.network(
                                      //       'https://ui-avatars.com/api/?name=${user?["Nama"]}',
                                      //       fit: BoxFit.cover,
                                      //     );
                                      //   } else {
                                      //     return Image.network(
                                      //       "${user?['image']}",
                                      //       fit: BoxFit.cover,
                                      //     );
                                      //   }
                                      // }),
                                    )),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          height: 70,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: 60,
                                            ),
                                            Icon(
                                              Icons.add_a_photo,
                                              size: 30,
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${user?['Nama']}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "${user?['Email']}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          if (user?['rout'] == "admin")
                            Card(
                              color: Colors.white.withOpacity(0.8),
                              child: ListTile(
                                onTap: () => Get.toNamed(Routes.MAHASISWA),
                                leading: Icon(
                                  Icons.group_add_outlined,
                                ),
                                title: Text("Tambah data mahasiswa"),
                              ),
                            ),
                          Card(
                            color: Colors.white.withOpacity(0.8),
                            child: ListTile(
                              onTap: () {
                                Get.toNamed(Routes.PERSENTASE, arguments: user);
                              },
                              leading: Icon(
                                Icons.edit_outlined,
                              ),
                              title: Text("Persentase absen"),
                            ),
                          ),
                          Card(
                            color: Colors.white.withOpacity(0.8),
                            child: ListTile(
                              onTap: () {
                                Get.toNamed(Routes.UPDETPROFIL,
                                    arguments: user);
                              },
                              leading: Icon(
                                Icons.edit_outlined,
                              ),
                              title: Text("ubah profil"),
                            ),
                          ),
                          Card(
                            color: Colors.white.withOpacity(0.8),
                            child: ListTile(
                              onTap: () {
                                Get.toNamed(Routes.UPDETPASSWORD);
                              },
                              leading: Icon(
                                Icons.vpn_key_outlined,
                              ),
                              title: Text("updete password"),
                            ),
                          ),
                          Card(
                            color: Colors.white.withOpacity(0.8),
                            child: ListTile(
                              onTap: () async {
                                await FirebaseAuth.instance.signOut();
                                Get.offAllNamed(Routes.LOGIN);
                              },
                              leading: Icon(
                                Icons.logout_outlined,
                              ),
                              title: Text("logout"),
                            ),
                          ),
                        ],
                      );
                      //   } else {
                      //     return Text("gagal");
                      //   }
                      // }
                    })
              ]),
            ),
          ],
        ),
        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.fixedCircle,
          items: [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.fingerprint, title: 'Add'),
            TabItem(icon: Icons.people, title: 'Profile'),
          ],
          initialActiveIndex: navc.indexh.value,
          onTap: (int i) => navc.halaman(i),
        ),
      ),
    );
  }
}
