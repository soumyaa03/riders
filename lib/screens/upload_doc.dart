import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riders/common/repository/documents_storage_repository.dart';
import 'package:riders/common/utils/utils.dart';
import 'package:riders/features/post_riders/post_rider_controller.dart';
import 'package:riders/screens/hone_screen.dart';
import 'package:riders/widgets/upload_doc_widget.dart';

class UploadDoc extends ConsumerStatefulWidget {
  static const routeName = '/upload-doc';
  final String riderName;
  final String phoneNumber;
  final String locality;
  final String currentAddress;
  final String currentPincode;
  final String accNumber;
  final String ifscNumber;
  final List<String> localities;
  const UploadDoc(
      {Key? key,
      required this.riderName,
      required this.phoneNumber,
      required this.locality,
      required this.currentAddress,
      required this.currentPincode,
      required this.accNumber,
      required this.ifscNumber,
      required this.localities})
      : super(key: key);

  @override
  ConsumerState<UploadDoc> createState() => _UploadDocState();
}

class _UploadDocState extends ConsumerState<UploadDoc> {
  Future storeUserData(
      File? aadhar, File? pan, File? dl, File? bankCheque, File? photo) async {
    String riderName = widget.riderName;
    String phoneNumber = widget.phoneNumber;
    String locality = widget.locality;
    String currentAddress = widget.currentAddress;
    String currentPincode = widget.currentPincode;
    String accNumber = widget.accNumber;
    String ifscNumber = widget.ifscNumber;
    List<String> localities = widget.localities;
    if (aadhar != null) {
      log(aadhar.path.toString());
    }
    if (pan != null) {
      log(pan.path.toString());
    }
    if (dl != null) {
      log(dl.path.toString());
    }
    if (bankCheque != null) {
      log(bankCheque.path.toString());
    }
    if (photo != null) {
      log(photo.path.toString());
    }

    ref.read(postControllerProvider).saveRiderDataToFirebase(
          context,
          riderName,
          phoneNumber,
          locality,
          currentAddress,
          currentPincode,
          accNumber,
          ifscNumber,
          localities,
          aadhar,
          dl,
          pan,
          bankCheque,
          photo,
          false,
        );
  }

  bool dataValidation(
      File? aadhar, File? pan, File? dl, File? bankCheque, File? photo) {
    if (aadhar == null) {
      showSnackBar(context: context, content: 'Uplaod Aadhar Card');
      return false;
    } else if (bankCheque == null) {
      showSnackBar(context: context, content: 'Uplaod bank cheque');
      return false;
    } else if (dl == null) {
      showSnackBar(context: context, content: 'Uplaod DL');
      return false;
    } else if (pan == null) {
      showSnackBar(context: context, content: 'Uplaod PAN card');
      return false;
    } else if (photo == null) {
      showSnackBar(context: context, content: 'Uplaod Photo');
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 60,
              ),
              const UploadDocumentWidget(fileType: 'aadhar'),
              const SizedBox(
                height: 60,
              ),
              const UploadDocumentWidget(fileType: 'pan'),
              const SizedBox(
                height: 60,
              ),
              const UploadDocumentWidget(fileType: 'dl'),
              const SizedBox(
                height: 60,
              ),
              const UploadDocumentWidget(fileType: 'photo'),
              const SizedBox(
                height: 60,
              ),
              const UploadDocumentWidget(fileType: 'bankCheque'),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () async {
                  File? aadhar =
                      ref.watch(documentStorageRepositoryProvider).aadhar;
                  if (aadhar != null) {
                    log(aadhar.path.toString());
                  } else {
                    log('aadhar is empty');
                  }
                  File? pan = ref.watch(documentStorageRepositoryProvider).pan;
                  if (pan != null) {
                    log(pan.path.toString());
                  } else {
                    log('pan is empty');
                  }
                  File? dl = ref.watch(documentStorageRepositoryProvider).dl;
                  if (dl != null) {
                    log(dl.path.toString());
                  } else {
                    log('dl is empty');
                  }
                  File? bankCheque =
                      ref.watch(documentStorageRepositoryProvider).bankCheque;
                  if (bankCheque != null) {
                    log(bankCheque.path.toString());
                  } else {
                    log('bankCheque is empty');
                  }
                  File? photo =
                      ref.watch(documentStorageRepositoryProvider).photo;
                  if (photo != null) {
                    log(photo.path.toString());
                  } else {
                    log('photo is empty');
                  }

                  if (dataValidation(aadhar, pan, dl, bankCheque, photo)) {
                    await storeUserData(aadhar, pan, dl, bankCheque, photo);
                    showSnackBar(
                        context: context, content: 'Loading new Rider');
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  }
                },
                child: Container(
                  color: Colors.blue,
                  height: 50,
                  width: 100,
                  child: const Center(
                    child: Text(
                      'Save',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
