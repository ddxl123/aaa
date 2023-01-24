import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future<void> showCategoriesSheet({required BuildContext context}) async {
  showMaterialModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Text(index.toString());
        },
      );
    },
  );
}
