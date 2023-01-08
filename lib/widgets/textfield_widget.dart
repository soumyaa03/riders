import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final double? borderRadius;
  final int? maxLines;
  final int? keyBoardType;

  const TextFieldWidget(
      {Key? key,
      required this.textController,
      required this.hintText,
      this.borderRadius = 30,
      this.maxLines = 1,
      this.keyBoardType = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType:
          keyBoardType == 1 ? TextInputType.number : TextInputType.multiline,
      maxLines: maxLines,
      controller: textController,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
              borderSide: const BorderSide(color: Colors.blueGrey, width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
              borderSide: const BorderSide(color: Colors.blue, width: 1))),
    );
  }
}
