import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/updetpassword_controller.dart';

class UpdetpasswordView extends GetView<UpdetpasswordController> {
  @override
  Widget build(BuildContext context) {
    double tinggi =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    double lebar = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: ListView(
        children: [
          Container(
            // color: Colors.amber,
            height: tinggi,
            child: Stack(children: [
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
                    SizedBox(
                      height: 150,
                    ),
                    TextField(
                      controller: controller.password,
                      // obscureText: true,
                      autocorrect: false,
                      decoration: InputDecoration(
                          label: Text("Password Lama"),
                          hintText: "Password Lama",
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: controller.new_password,
                      // obscureText: true,
                      autocorrect: false,
                      decoration: InputDecoration(
                          label: Text(
                            "New Password",
                          ),
                          hintText: "New Password",
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: controller.confpassword,
                      // obscureText: true,
                      autocorrect: false,
                      decoration: InputDecoration(
                          label: Text("Confirmasi Password"),
                          hintText: "Password Lama",
                          border: OutlineInputBorder()),
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.blue[200])),
                        onPressed: () => controller.ubhpw(),
                        child: Text("Ubah password"))
                  ],
                ),
              ),
            ]),
          ),
        ],
      )),
    );
  }
}
