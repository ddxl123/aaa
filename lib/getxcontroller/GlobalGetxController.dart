import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetIdBuilder extends StatelessWidget {
  const GetIdBuilder({Key? key, required this.getBuilder}) : super(key: key);
  final GetBuilder getBuilder;


  @override
  Widget build(BuildContext context) {
    return getBuilder;
  }
}
