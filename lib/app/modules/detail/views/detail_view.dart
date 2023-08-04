import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  @override
  Widget build(BuildContext context) {
    double tinggi = MediaQuery.of(context).size.height;
    double lebar = MediaQuery.of(context).size.width;
    double bodyy = tinggi - MediaQuery.of(context).padding.top;
    var data = Get.arguments;
    print(data);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: bodyy,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: lebar,
                    height: tinggi * 0.35,
                    child: Image.asset(
                      "gambar/gambar1.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    width: lebar,
                    margin: EdgeInsets.only(top: 40),
                    height: tinggi * 0.25,
                    // color: Colors.black,
                    child: Image.asset(
                      "gambar/gambar3.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: lebar,
              margin: EdgeInsets.only(top: 40),
              height: tinggi * 0.45,
              // color: Colors.black,
              child: Image.asset(
                "gambar/gambar2.png",
                fit: BoxFit.fill,
              ),
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: lebar * 0.8,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[300]!.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            data['masuk']?['matakuliah'] == null
                                ? '-'
                                : '${data['masuk']?['matakuliah']}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Masuk",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Text(
                              "${DateFormat.yMMMEd().format(DateTime.parse('${data['waktu']}'))}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                        Text(data['masuk']?['waktu'] == null
                            ? '-'
                            : "jam : ${DateFormat.jms().format(DateTime.parse('${data['masuk']['waktu']}'))}"),
                        Text(data['masuk']?['Setatus'] == null
                            ? '-'
                            : 'Status : ${data['masuk']['Setatus']}'),
                        Text(data['masuk']?['lokasi'] == null
                            ? '-'
                            : 'Lokasi : ${data['masuk']['lokasi']}'),
                        Text(data['masuk']?['jarak'] == null
                            ? '-'
                            : 'Jarak : ${data['masuk']['jarak'].toString().split('.').first} meter'),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Keluar",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(data['keluar']?['waktu'] == null
                            ? '-'
                            : "Jam : ${DateFormat.jms().format(DateTime.parse('${data['keluar']['waktu']}'))}"),
                        Text(data['keluar']?['Setatus'] == null
                            ? '-'
                            : 'Setatus : ${data['keluar']['Setatus']}'),
                        Text(data['keluar']?['lokasi'] == null
                            ? '-'
                            : 'lokasi : ${data['keluar']['lokasi']}'),
                        Text(data['keluar']?['jarak'] == null
                            ? '-'
                            : 'Jarak : ${data['keluar']['jarak'].toString().split('.').first} meter'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
