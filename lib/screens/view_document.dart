import 'dart:io';

import 'package:flutter/material.dart';

class ViewDocument extends StatelessWidget {
  static const routeName = '/view-document';
  final File image;
  const ViewDocument({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SizedBox(
            height: 400,
            width: 300,
            child: Image.file(
              File(image.path),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
