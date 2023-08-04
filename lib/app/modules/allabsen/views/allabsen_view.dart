import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// import '../../../routes/app_pages.dart';
import '../../../routes/app_pages.dart';
import '../controllers/allabsen_controller.dart';

class AllabsenView extends GetView<AllabsenController> {
  @override
  Widget build(BuildContext context) {
    double tingi =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    double lebar = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: GetBuilder<AllabsenController>(
              builder: (c) => Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        width: lebar,
                        height: tingi * 0.45,
                        // color: Colors.red,
                        child: Image.asset(
                          "gambar/gambar2.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: lebar,
                            height: tingi * 0.35,

                            // color: Colors.amber,
                            child: Image.asset(
                              "gambar/gambar1.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            // color: Colors.blue,
                            width: lebar,
                            height: tingi * 0.25,
                            child: Image.asset(
                              "gambar/gambar3.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                        child: FutureBuilder<
                                QuerySnapshot<Map<String, dynamic>>>(
                            future: c.alllist(),
                            builder: (context, Snapshot) {
                              if (Snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }
                              var listt = Snapshot.data?.docs;
                              // print(Snapshot.data?.docs.length);
                              return ListView.builder(
                                itemCount: listt?.length,
                                itemBuilder: (context, index) {
                                  if (!Snapshot.hasData) {
                                    return Text("kosong");
                                  }
                                  Map<String, dynamic> data =
                                      Snapshot.data!.docs[index].data();
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
                                                    data['masuk']?[
                                                                'matakuliah'] ==
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
                                                        CrossAxisAlignment
                                                            .start,
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
                                                      Text(data['masuk']?[
                                                                  'Setatus'] ==
                                                              null
                                                          ? '-'
                                                          : 'Area :  ${data['masuk']['Setatus']}'),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                      Text(data['keluar']?[
                                                                  'Setatus'] ==
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
                            }),
                      ),
                    ],
                  )),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Get.dialog(Dialog(
              child: Container(
                height: 250,
                child: SfDateRangePicker(
                  showActionButtons: true,
                  onCancel: () => Get.back(),
                  onSubmit: (obj) {
                    if (obj != null) {
                      if ((obj as PickerDateRange).endDate != null) {
                        controller.filter(obj.startDate, obj.endDate);
                        print(obj);
                      }
                    }
                  },
                  monthViewSettings:
                      DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                  selectionMode: DateRangePickerSelectionMode.range,
                ),
              ),
            )),
            child: Icon(
              Icons.format_list_bulleted,
            ),
          )),
    );
  }
}
