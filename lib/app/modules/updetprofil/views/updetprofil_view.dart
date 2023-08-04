import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/updetprofil_controller.dart';

class UpdetprofilView extends GetView<UpdetprofilController> {
  final Map<String, dynamic> user = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.Namac.text = user['Nama'];
    controller.NIMc.text = user['Nim'];
    controller.Emailc.text = user['Email'];
    final uid = user['id'];
    double tinggi =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    double lebar = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: ListView(children: [
        Container(
          // color: Colors.amber,
          height: tinggi,
          child: Stack(
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
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    SizedBox(
                      height: 150,
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
                      readOnly: true,
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
                      readOnly: true,
                      autocorrect: false,
                      controller: controller.Emailc,
                      decoration: InputDecoration(
                          label: Text("Email"),
                          hintText: "Email",
                          border: OutlineInputBorder()),
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Colors.blue[200]!.withOpacity(0.5)),
                            fixedSize: MaterialStatePropertyAll(Size(400, 0))),
                        onPressed: () {
                          controller.updt(uid);
                        },
                        child: Text("Updet"))
                  ],
                ),
              ),
            ],
          ),
        ),
      ])),
    );
  }
}
