// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  TextEditingController Emailc = TextEditingController();
  TextEditingController passwordc = TextEditingController();
  TextEditingController Remail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double tinggi =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    double lebar = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: tinggi,
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
                      height: tinggi * 0.20,
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
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 40),
                      child: Column(
                        children: [
                          SizedBox(
                            height: tinggi * 0.45,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            autocorrect: false,
                            controller: Emailc,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 0, 12, 0),
                                label: Text("Email"),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            autocorrect: false,
                            controller: passwordc,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 0, 12, 0),
                                label: Text("Password"),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OutlinedButton(
                                  style: ButtonStyle(
                                      side: MaterialStatePropertyAll(BorderSide(
                                          color: Colors.blue, width: 3)),
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      fixedSize: MaterialStatePropertyAll(
                                          Size(120, 25))),
                                  onPressed: () => controller.login(
                                      Emailc.text, passwordc.text),
                                  child: Text(
                                    "login",
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 20),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Get.defaultDialog(
                                        title: "riset password",
                                        content: Column(
                                          children: [
                                            TextField(
                                              controller: Remail,
                                              autocorrect: false,
                                              decoration: InputDecoration(
                                                  label: Text("Email"),
                                                  border: OutlineInputBorder()),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () =>
                                                  controller.riset(Remail.text),
                                              child: Text("Riset password"))
                                        ]);
                                  },
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text("Lupa password?"))),
                            ],
                          )
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 80,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
