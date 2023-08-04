import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';

import '../controllers/mahasiswa_controller.dart';

class MahasiswaView extends GetView<MahasiswaController> {
  @override
  Widget build(BuildContext context) {
    double tinggi = MediaQuery.of(context).size.height;
    double lebar = MediaQuery.of(context).size.width;
    double bodyy = tinggi - MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Stack(
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.arrow_back,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: tinggi * 0.25,
                        // color: Colors.amber,
                        child: Center(
                          child: Text(
                            "Tambah Mahasiswa",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      DropdownSearch<String>(
                        popupProps: PopupProps.dialog(
                          constraints: BoxConstraints(
                            maxHeight: 300,
                            maxWidth: 300,
                          ),
                          showSelectedItems: true,
                        ),
                        items: [
                          "TI-2020-P1",
                          "TI-2020-P2",
                          "TI-2020-P3",
                          'TI-2020-P4',
                          'TI-2020-P5',
                          'TI-2020-P6',
                          'TI-2020-P7',
                          'TI-2020-P8',
                          'TI-2020-P9',
                          'TI-2020-P10',
                          'TI-2020-P11',
                          'TI-2020-P12',
                          'TI-2020-P13',
                          'TI-2020-P14',
                          'TI-2020-P15',
                        ],
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Kelas",
                            hintText: "country in menu mode",
                          ),
                        ),
                        onChanged: (value) {
                          controller.setSelectedValue(value!);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        autocorrect: false,
                        controller: controller.Namac,
                        decoration: InputDecoration(
                            label: Text("Nama"),
                            hintText: "Nama",
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        autocorrect: false,
                        controller: controller.NIMc,
                        decoration: InputDecoration(
                            label: Text("NIM"),
                            hintText: "NIM",
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        autocorrect: false,
                        controller: controller.Emailc,
                        decoration: InputDecoration(
                            label: Text("Email"),
                            hintText: "Email",
                            border: OutlineInputBorder()),
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              fixedSize: MaterialStatePropertyAll(Size(400, 0)),
                              overlayColor: MaterialStatePropertyAll(
                                Colors.blue[400],
                              ),
                              backgroundColor: MaterialStatePropertyAll(
                                  Colors.blue[200]!.withOpacity(0.5))),
                          onPressed: () => controller.addmhs(
                              controller.Namac.text,
                              controller.NIMc.text,
                              controller.Emailc.text),
                          child: Text("add"))
                    ],
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
