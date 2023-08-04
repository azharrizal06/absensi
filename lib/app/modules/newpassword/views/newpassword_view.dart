// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/newpassword_controller.dart';

class NewpasswordView extends GetView<NewpasswordController> {
  TextEditingController ubh = TextEditingController(text: '123123123');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('NewpasswordView'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            SizedBox(height: 10),
            TextField(
              autocorrect: false,
              controller: ubh,
              decoration: InputDecoration(
                  label: Text("Password"), border: OutlineInputBorder()),
            ),
            OutlinedButton(
                onPressed: () => controller.newpw(ubh.text),
                child: Text("New password")),
          ],
        ));
  }
}
