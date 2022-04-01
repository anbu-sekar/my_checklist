import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';



class CheckList extends StatelessWidget {
  final String checkListText;
  final bool checkListSatus;
  final ValueChanged<bool>? onChangeChecList;

  const CheckList({
    Key? key,
    this.checkListSatus = false,
    this.checkListText = '',
    required this.onChangeChecList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: checkListSatus, onChanged: null),
        Text(checkListText, style: const TextStyle(color: Colors.white, fontSize: 25))
      ],
    );

  }
}

