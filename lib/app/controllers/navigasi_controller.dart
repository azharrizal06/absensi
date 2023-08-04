import 'package:absensi/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';

class NavigasiController extends GetxController {
  RxInt indexh = 0.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fristore = FirebaseFirestore.instance;
  final RxString Matakuliah = ''.obs;
  final RxString Pertemuanke = '0'.obs;

  void setSelectedValue(String value) {
    Matakuliah.value = value;
  }

  void Pertemuan(String value) {
    Pertemuanke.value = value;
  }

  void halaman(int i) async {
    switch (i) {
      case 1:
        Position posisi = await determinePosition();
        List<Placemark> placemarks =
            await placemarkFromCoordinates(posisi.latitude, posisi.longitude);
        // print(placemarks);
        String alamat =
            '${placemarks[0].subAdministrativeArea}, ${placemarks[0].country}';
        await updateposisi(
          posisi,
          alamat,
        );
        await absensi(posisi, alamat, Pertemuanke.value);

      case 2:
        indexh.value = i;
        Get.offAllNamed(Routes.PROFIL);
        break;
      default:
        indexh.value = i;
        Get.offAllNamed(Routes.HOME);
    }
  }

  Future<void> absensi(
      Position posisi, String alamat, String Pertemuanke) async {
    String uid = auth.currentUser!.uid;
    String mk = Matakuliah.value;
    String docidwaktu =
        DateFormat.yMd().format(DateTime.now()).replaceAll("/", "-");
    CollectionReference<Map<String, dynamic>> absen =
        fristore.collection('mahasiswa').doc(uid).collection('absen');

    QuerySnapshot<Map<String, dynamic>> Snapabsen = await absen.get();
    double jarak = Geolocator.distanceBetween(
        -6.7367492, 108.5272734, posisi.latitude, posisi.longitude);
    print('imi${jarak}');
    // print(posisi.longitude);
    // print(posisi.latitude);
    String Setatus = 'Diluar Area';
    if (jarak <= 50) {
      Setatus = 'Di Dalam Area';
    }

    if (Snapabsen.docs.length == 0) {
      return Get.defaultDialog(
          title: 'Masuk',
          middleText: 'apaka anda ingin absen Masuk?',
          actions: [
            OutlinedButton(
              onPressed: () {
                Get.back();
                Get.snackbar("Gagal", "Gagal absen Masuk");
              },
              child: Text("Cencel"),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (Setatus == 'Diluar Area') {
                    return Get.defaultDialog(
                        title: "Gagal absen Masuk",
                        textConfirm: 'oke',
                        onConfirm: () => Get.back(),
                        middleText:
                            'Maaf anda tidak dapat absen Masuk karena diluar area');
                  } else {
                    await absen.doc(docidwaktu).set({
                      'waktu': DateTime.now().toIso8601String(),
                      'masuk': {
                        'lot': posisi.latitude,
                        'long': posisi.longitude,
                        'waktu': DateTime.now().toIso8601String(),
                        'lokasi': alamat,
                        'Setatus': Setatus,
                        'tanggal': docidwaktu,
                        'matakuliah': mk,
                        'jarak': jarak
                      }
                    });
                    Get.back();
                    Get.snackbar("Berhasil", "Berhasil absen Masuk");
                    ;
                  }
                },
                child: Text("Oke"))
          ]);
    } else {
      DocumentSnapshot<Map<String, dynamic>> hariini =
          await absen.doc(docidwaktu).get();
      if (hariini.exists == true) {
        Map<String, dynamic>? dataabsen = await hariini.data();

        if (dataabsen?['keluar'] == null) {
          return Get.defaultDialog(
              title: 'keluar',
              middleText: 'apaka anda ingin absen keluar?',
              actions: [
                OutlinedButton(
                  onPressed: () {
                    Get.back();
                    Get.snackbar("Gagal", "Gagal absen Keluar");
                  },
                  child: Text("Cencel"),
                ),
                ElevatedButton(
                    onPressed: () async {
                      Get.back();
                      if (Setatus == 'Diluar Area') {
                        return Get.defaultDialog(
                            title: "Gagal absen Keluar",
                            textConfirm: 'oke',
                            onConfirm: () => Get.back(),
                            middleText:
                                'Maaf anda tidak dapat absen Keluar karena diluar area');
                      } else {
                        absen.doc(docidwaktu).update({
                          'keluar': {
                            'matakuliah': Matakuliah.value,
                            'lot': posisi.latitude,
                            'long': posisi.longitude,
                            'waktu': DateTime.now().toIso8601String(),
                            'lokasi': alamat,
                            'Setatus': Setatus,
                            'tanggal': docidwaktu,
                            'jarak': jarak
                          }
                        });
                        Get.back();
                        Get.snackbar("Berhasil", "Berhasil absen keluar");
                      }
                    },
                    child: Text("Oke"))
              ]);
        } else {
          print("berhasil");
        }
      } else {
        return Get.defaultDialog(
            title: 'Masuk',
            middleText: 'apaka anda ingin absen Masuk?',
            actions: [
              OutlinedButton(
                onPressed: () {
                  Get.back();
                  Get.snackbar("Gagal", "Gagal absen Masuk");
                },
                child: Text("Cencel"),
              ),
              ElevatedButton(
                  onPressed: () async {
                    Get.back();
                    if (Setatus == 'Diluar Area') {
                      return Get.defaultDialog(
                          title: "Gagal absen Masuk",
                          textConfirm: 'oke',
                          onConfirm: () => Get.back(),
                          middleText:
                              'Maaf anda tidak dapat absen Masuk karena  diluar area');
                    } else {
                      await absen.doc(docidwaktu).set({
                        'waktu': DateTime.now().toIso8601String(),
                        'masuk': {
                          'lot': posisi.latitude,
                          'long': posisi.longitude,
                          'waktu': DateTime.now().toIso8601String(),
                          'lokasi': alamat,
                          'Setatus': Setatus,
                          'tanggal': docidwaktu,
                          'matakuliah': mk,
                          'jarak': jarak
                        }
                      });
                      Get.back();
                      Get.snackbar("Berhasil", "Berhasil absen Masuk");
                    }
                  },
                  child: Text("Oke"))
            ]);
      }
    }
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception('GPS tidak aktif');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Memulai pembaruan lokasi periodik
    Stream<Position> positionStream = Geolocator.getPositionStream();

    // Mendapatkan posisi terkini
    Position currentPosition = await Geolocator.getCurrentPosition();

    // Memperbarui posisi saat terjadi pembaruan lokasi
    positionStream.listen((Position newPosition) {
      currentPosition = newPosition;
    });

    return currentPosition;
  }

  Future<void> updateposisi(Position posisi, String alamat) async {
    String uid = auth.currentUser!.uid;
    await fristore.collection('mahasiswa').doc(uid).update({
      'lokasi': alamat,
      'posisi': {
        'lat': posisi.latitude,
        'long': posisi.longitude,
      }
    });
  }
}
