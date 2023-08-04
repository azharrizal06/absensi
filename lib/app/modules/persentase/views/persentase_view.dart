import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/persentase_controller.dart';

class PersentaseView extends GetView<PersentaseController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                ),
                Expanded(
                  child: TextField(
                    autocorrect: false,
                    controller: controller.email,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        onPressed: () =>
                            controller.search(controller.email.text),
                        icon: Icon(
                          Icons.search,
                        ),
                      ),
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                // ElevatedButton(
                //   onPressed: () => controller.search(controller.email.text),
                //   child: Text('Cari'),
                // ),
              ],
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.filteredList.length,
                  itemBuilder: (context, index) {
                    var data = controller.filteredList[index];
                    return ListTile(
                      leading: data['image'] != null
                          ? ClipOval(
                              child: Container(
                                height: 40,
                                width: 40,
                                child: Image.network(
                                  data['image'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : ClipOval(
                              child: Container(
                                height: 40,
                                width: 40,
                                child: Image.network(
                                  'https://ui-avatars.com/api/?name=${data["Nama"]}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      title: Text("${data['Nama']}"),
                      subtitle: Text("${data['Email']}"),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
