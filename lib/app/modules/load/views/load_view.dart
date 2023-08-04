import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/load_controller.dart';

class LoadView extends GetView<LoadController> {
  const LoadView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      const Color.fromARGB(255, 0, 140, 255),
                      Color.fromARGB(255, 100, 181, 246)
                    ])),
              ),
              Center(
                  child: Container(
                // color: Colors.amber,
                height: 200,
                width: 200,
                child: Image.asset(
                  "gambar/logo.png",
                  fit: BoxFit.cover,
                ),
              )),
            ],
          ),
        ));
  }
}
