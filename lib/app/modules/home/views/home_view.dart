import 'package:absensi/app/controllers/navigasi_controller.dart';
import 'package:absensi/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final navc = Get.find<NavigasiController>();
  @override
  Widget build(BuildContext context) {
    double tinggi = MediaQuery.of(context).size.height;
    double lebar = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: controller.getdatauser(),
            builder: (contex, Snapshot) {
              if (Snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: LottieBuilder.asset("lottie/loading.json"),
                );
              }
              print(Snapshot);
              Map<String, dynamic>? user = Snapshot.data?.data();
              // String kosong = 'https://ui-avatars.com/api/?name=${user?["Nama"]}';

              return Stack(
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
                  ListView(
                    padding: EdgeInsets.all(20),
                    children: [
                      Row(
                        children: [
                          ClipOval(
                            child: Container(
                                height: 80,
                                width: 80,
                                child: Image.asset(
                                  "gambar/logo.png",
                                  fit: BoxFit.cover,
                                )),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'STMIK IKMI CIREBON',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text('Teknik Informatika',
                                  style: TextStyle(fontSize: 16)),
                              Text(
                                user?['lokasi'] == null
                                    ? 'kosong'
                                    : '${user?['lokasi']}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[300]!.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user?['Nama'] == null
                                    ? 'kosong'
                                    : '${user?['Nama']}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                user?['Nim'] == null
                                    ? 'kosong'
                                    : '${user?['Nim']}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                user?['Kelas'] == null
                                    ? 'kosong'
                                    : '${user?['Kelas']}',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[300]!.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20)),
                        padding: EdgeInsets.all(20),
                        child: StreamBuilder<
                                DocumentSnapshot<Map<String, dynamic>>>(
                            stream: controller.Sekarang(),
                            builder: (context, Snapshot) {
                              if (Snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }
                              var data = Snapshot.data?.data();
                              // print(Snapshot.data?.data());

                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text('Masuk'),
                                      Text(data?['masuk'] == null
                                          ? "-"
                                          : DateFormat.jms().format(
                                              DateTime.parse(
                                                  "${data!['masuk']['waktu']}"))),
                                    ],
                                  ),
                                  Container(
                                    height: 40,
                                    width: 2,
                                    color: Colors.grey[600],
                                  ),
                                  Column(
                                    children: [
                                      Text('Keluar'),
                                      Text(data?['keluar'] == null
                                          ? "-"
                                          : DateFormat.jms().format(DateTime.parse(
                                              "${data!['keluar']['waktu']}"))),
                                    ],
                                  ),
                                ],
                              );
                            }),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.grey[300],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("last 4 days"),
                          TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.ALLABSEN);
                            },
                            child: Text("See more"),
                          )
                        ],
                      ),
                      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: controller.list5(),
                          builder: (context, snp) {
                            if (snp.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child:
                                    LottieBuilder.asset("lottie/loading.json"),
                              );
                            }
                            if (snp.hasError) {
                              return Center(
                                child: Text("Error occurred"),
                              );
                            }
                            var list = snp.data?.docs;
                            if (snp.data?.docs.length == 0) {
                              return Container(
                                height: 100,
                                child: Center(
                                  child: Text("Kosong"),
                                ),
                              );
                            }

                            // print(list);
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: list?.length,
                              itemBuilder: (context, index) {
                                // print(snp.data?.docs.length);

                                Map<String, dynamic> data =
                                    snp.data!.docs[index].data();
                                // print(data);
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey[300]!.withOpacity(0.5),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {
                                        Get.toNamed(Routes.DETAIL,
                                            arguments: data);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  data['masuk']
                                                              ?['matakuliah'] ==
                                                          null
                                                      ? '-'
                                                      : '${data['masuk']?['matakuliah']}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                                Text(
                                                  "${DateFormat.yMMMEd().format(DateTime.parse('${data['waktu']}'))}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Masuk",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                    Text(data['masuk']
                                                                ?['waktu'] ==
                                                            null
                                                        ? '-'
                                                        : "Jam : ${DateFormat.jms().format(DateTime.parse('${data['masuk']['waktu']}'))}"),
                                                    Text(data['masuk']
                                                                ?['Setatus'] ==
                                                            null
                                                        ? '-'
                                                        : 'Area :  ${data['masuk']['Setatus']}'),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Keluar",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                    Text(data['keluar']
                                                                ?['waktu'] ==
                                                            null
                                                        ? '-'
                                                        : "Jam : ${DateFormat.jms().format(DateTime.parse('${data['keluar']['waktu']}'))}"),
                                                    Text(data['keluar']
                                                                ?['Setatus'] ==
                                                            null
                                                        ? '-'
                                                        : 'Area :  ${data['keluar']['Setatus']}'),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          })
                    ],
                  ),
                ],
              );
            }),
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
