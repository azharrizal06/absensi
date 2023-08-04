import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PersentaseController extends GetxController {
  FirebaseFirestore fristore = FirebaseFirestore.instance;
  TextEditingController email = TextEditingController();
  RxList<Map<String, dynamic>> listdata = RxList<Map<String, dynamic>>([]);
  RxList<Map<String, dynamic>> filteredList = RxList<Map<String, dynamic>>([]);

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await fristore.collection('mahasiswa').orderBy('Nama').get();
    listdata.value = snapshot.docs.map((e) => e.data()).toList();
    filteredList.value = listdata;
    print(filteredList);
  }

  void search(String keyword) {
    if (keyword.isEmpty) {
      filteredList.value = listdata;
      print(filteredList);
    } else {
      filteredList.value = listdata.where((item) {
        String nama = item.toString().toLowerCase();
        return nama.contains(keyword.toLowerCase());
      }).toList();
      print(filteredList);
    }
  }
}
