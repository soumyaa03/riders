import 'dart:io';

import 'package:flutter/material.dart';
import 'package:riders/common/utils/utils.dart';
import 'package:riders/screens/upload_doc.dart';

class UploadDocumentWidget extends StatefulWidget {
  static File? image;
  final String fileType;
  const UploadDocumentWidget({super.key, required this.fileType});

  @override
  State<UploadDocumentWidget> createState() => _UploadDocumentWidgetState();
}

class _UploadDocumentWidgetState extends State<UploadDocumentWidget> {
  @override
  void initState() {
    UploadDocumentWidget.image = null;
    super.initState();
  }

  void selectImage() async {
    UploadDocumentWidget.image = await pickImageFromGallery(context);
    switch (widget.fileType) {
      case "aadhar":
        UploadDoc.aadharValue.value = UploadDocumentWidget.image;
        break;
      case "dl":
        UploadDoc.dlValue.value = UploadDocumentWidget.image;
        break;
      case "pan":
        UploadDoc.panValue.value = UploadDocumentWidget.image;
        break;
      case "bankCheque":
        UploadDoc.bankChequeValue.value = UploadDocumentWidget.image;
        break;
      case "photo":
        UploadDoc.photoValue.value = UploadDocumentWidget.image;
        break;

      default:
        debugPrint('unlikely error in switch case');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 10,
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black),
        shape: BoxShape.rectangle,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UploadDocumentWidget.image == null
              ? const Icon(Icons.done)
              : const Icon(
                  Icons.done_all,
                  color: Colors.blue,
                ),
          const SizedBox(width: 10),
          Text(widget.fileType),
          const SizedBox(width: 45),
          GestureDetector(
            onTap: () {
              selectImage();
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 20,
              width: 150,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                shape: BoxShape.rectangle,
              ),
              child: const Center(child: Text('Upload')),
            ),
          )
        ],
      ),
    );
  }
}
