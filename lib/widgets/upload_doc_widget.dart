import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riders/common/repository/documents_storage_repository.dart';
import 'package:riders/common/utils/utils.dart';
import 'package:riders/screens/view_document.dart';

class UploadDocumentWidget extends ConsumerStatefulWidget {
  static File? image;
  final String fileType;
  const UploadDocumentWidget({super.key, required this.fileType});

  @override
  ConsumerState<UploadDocumentWidget> createState() =>
      _UploadDocumentWidgetState();
}

class _UploadDocumentWidgetState extends ConsumerState<UploadDocumentWidget> {
  File? viewImage;
  @override
  void initState() {
    super.initState();
    UploadDocumentWidget.image = null;
  }

  void selectImage() async {
    UploadDocumentWidget.image = await pickImageFromGallery(context);
    viewImage = UploadDocumentWidget.image;
    switch (widget.fileType) {
      case "aadhar":
        ref
            .read(documentStorageRepositoryProvider)
            .getDocument(UploadDocumentWidget.image, widget.fileType);
        // UploadDoc.aadharValue.value = UploadDocumentWidget.image;

        break;
      case "dl":
        ref
            .read(documentStorageRepositoryProvider)
            .getDocument(UploadDocumentWidget.image, widget.fileType);

        break;
      case "pan":
        ref
            .read(documentStorageRepositoryProvider)
            .getDocument(UploadDocumentWidget.image, widget.fileType);

        break;
      case "bankCheque":
        ref
            .read(documentStorageRepositoryProvider)
            .getDocument(UploadDocumentWidget.image, widget.fileType);

        break;
      case "photo":
        ref
            .read(documentStorageRepositoryProvider)
            .getDocument(UploadDocumentWidget.image, widget.fileType);

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
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: viewImage == null
                ? const Icon(Icons.done)
                : const Icon(
                    Icons.done_all,
                    color: Colors.blue,
                  ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 90,
            child: Text(
              widget.fileType,
            ),
          ),
          const SizedBox(width: 45),
          GestureDetector(
            onTap: () {
              selectImage();
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 20,
              width: 80,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                shape: BoxShape.rectangle,
              ),
              child: const Center(child: Text('Upload')),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (viewImage != null) {
                Navigator.pushNamed(context, ViewDocument.routeName,
                    arguments: {'image': viewImage});
              } else {
                showSnackBar(
                    context: context, content: 'Upload the Document first');
              }
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 20,
              width: 80,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                shape: BoxShape.rectangle,
              ),
              child: const Center(child: Text('View')),
            ),
          )
        ],
      ),
    );
  }
}
