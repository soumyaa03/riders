import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final
final documentStorageRepositoryProvider = Provider((ref) {
  return DocumentStorageRepository();
});

var documentStorageChangeNotifierProvider =
    ChangeNotifierProvider<DocumentStorageRepository>(
        (_) => DocumentStorageRepository());

class DocumentStorageRepository extends ChangeNotifier {
  File? aadhar;
  File? pan;
  File? dl;
  File? bankCheque;
  File? photo;

  void getDocument(File? image, String fileType) async {
    if (fileType == 'aadhar') {
      if (image != null) {
        log('aadhar image path');
        log(image.path.toString());
      }
      aadhar = image;
    } else if (fileType == 'pan') {
      if (image != null) {
        log('pan image path');
        log(image.path.toString());
      }
      pan = image;
    } else if (fileType == 'dl') {
      if (image != null) {
        log('dl image path');
        log(image.path.toString());
      }
      dl = image;
    } else if (fileType == 'bankCheque') {
      if (image != null) {
        log('bankCheque image path');
        log(image.path.toString());
      }
      bankCheque = image;
    } else if (fileType == 'photo') {
      if (image != null) {
        log('photo image path');
        log(image.path.toString());
      }
      photo = image;
    }

    notifyListeners();
  }
}
