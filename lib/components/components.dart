import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../classes/Item.dart';
import '../classes/app_controller.dart';

class Components {
  static Widget mySpace(bool isVertical) {
    return SizedBox(
      height: isVertical ? 20 : 0,
      width: isVertical ? 0 : 20,
    );
  }

  static Future showMyDialog(
      {required String title,
      String? itemTitle = '',
      required String content,
      required VoidCallback onOk,
      required VoidCallback onCancell}) async {
    return Get.dialog(
        transitionDuration: Duration(milliseconds: 500),
        AlertDialog(
          title: RichText(
            text: TextSpan(
              text: title,
              style: TextStyle(color: Colors.black, fontSize: 14),
              children: [TextSpan(text: itemTitle, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))],
            ),
          ),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: onCancell,
              child: Text('إلغاء', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 175, 12, 0)),
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
              onPressed: onOk,
              child: Text('تأكيد حذف', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ));
  }

  static void showErrorSnackBar({required String title, required String msg}) {
    Get.snackbar(
      'خطأ',
      'يجب ادخال عنوان العنصر',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      colorText: Colors.black,
      borderRadius: 10,
      margin: EdgeInsets.all(10),
      // borderColor: Colors.red.withOpacity(.5),
      borderWidth: 1,
      duration: Duration(seconds: 2),
      icon: Icon(Icons.error, color: Colors.red),
      boxShadows: [
        BoxShadow(color: Colors.grey, offset: Offset(0, 0), blurRadius: 5, spreadRadius: 5),
      ],
    );
  }

  static bool isImageInDevice(String path) {
    File? file = File(path);

    if (file.existsSync())
      return true;
    else
      return false;
  }

  static String getItemTypeArabicText(ItemType type) {
    String text = '';
    if (type == ItemType.all) text = 'الكل';
    if (type == ItemType.kitchen)
      text = 'مطبخ';
    else if (type == ItemType.table)
      text = 'طاولة';
    else if (type == ItemType.chair)
      text = 'كرسي';
    else if (type == ItemType.bed)
      text = 'سرير';
    else if (type == ItemType.wardrobe)
      text = 'خزانة';
    else if (type == ItemType.other) text = 'أخرى';
    return text;
  }

  static Widget drawerItem({
    required BuildContext context,
    required String title,
    required Widget icon,
    required ItemType itemType,
    required int itemCount,
    required VoidCallback onTap,
  }) {
    AppController appCtr = Get.find<AppController>();
    return Column(
      children: [
        ListTile(
          leading: icon,
          selected: itemType == appCtr.selectedMustShowType.value,
          title: Text(title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          trailing: Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(color: Colors.grey, offset: Offset(0, 0), blurRadius: 5, spreadRadius: 5),
              ],
            ),
            child: Text('$itemCount', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
          onTap: onTap,
        ),
        Divider(thickness: 2, indent: 20, endIndent: 20),
      ],
    );
  }

  static Widget getItemTypeIcon(ItemType type) {
    IconData icon = Icons.add_card;
    if (type == ItemType.all) icon = Icons.select_all;
    if (type == ItemType.kitchen)
      icon = Icons.kitchen;
    else if (type == ItemType.table)
      icon = Icons.table_bar_outlined;
    else if (type == ItemType.chair)
      icon = Icons.chair_outlined;
    else if (type == ItemType.bed)
      icon = Icons.bed;
    else if (type == ItemType.wardrobe)
      icon = CupertinoIcons.wand_stars_inverse;
    else if (type == ItemType.other) icon = Icons.assignment_late_outlined;
    return Icon(
      icon,
      color: Colors.black,
    );
  }

  static getShownItemArabixTxt(ShownItem element) {
    String text = '';
    if (element == ShownItem.all)
      text = 'الكل';
    else if (element == ShownItem.added)
      text = 'المضافة';
    else if (element == ShownItem.notAdded) text = 'غير مضافة';

    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static Future<bool> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print('connectivityResult $connectivityResult');
    if (connectivityResult == ConnectivityResult.none) {
      Components.showErrorSnackBar(
          title: 'مشكلو في الانترنت', msg: 'انت غير متصل بالانترنت حاليا ، يرجى التأكد من الاتصال بالانترنت');
      return false;
    }
    return true;
  }
}
