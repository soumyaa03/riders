import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  const UploadDoc({
    Key? key,
    required this.riderName,
    required this.phoneNumber,
    required this.locality,
    required this.currentAddress,
    required this.currentPincode,
    required this.accNumber,
    required this.ifscNumber,
  }) : super(key: key);

  static ValueNotifier<File?> aadharValue = ValueNotifier(null);
  static ValueNotifier<File?> dlValue = ValueNotifier(null);
  static ValueNotifier<File?> panValue = ValueNotifier(null);
  static ValueNotifier<File?> bankChequeValue = ValueNotifier(null);
  static ValueNotifier<File?> photoValue = ValueNotifier(null);

  @override
  ConsumerState<UploadDoc> createState() => _UploadDocState();
}

class _UploadDocState extends ConsumerState<UploadDoc> {
  Future storeUserData() async {
    String riderName = widget.riderName;
    String phoneNumber = widget.phoneNumber;
    String locality = widget.locality;
    String currentAddress = widget.currentAddress;
    String currentPincode = widget.currentPincode;
    String accNumber = widget.accNumber;
    String ifscNumber = widget.ifscNumber;
    File? aadhar = UploadDoc.aadharValue.value;
    File? pan = UploadDoc.panValue.value;
    File? bankCheque = UploadDoc.bankChequeValue.value;
    File? dl = UploadDoc.dlValue.value;
    File? photo = UploadDoc.photoValue.value;

    ref.read(postControllerProvider).saveRiderDataToFirebase(
          context,
          riderName,
          phoneNumber,
          locality,
          currentAddress,
          currentPincode,
          accNumber,
          ifscNumber,
          aadhar,
          dl,
          pan,
          bankCheque,
          photo,
        );
  }

  bool dataValidation() {
    if (UploadDoc.aadharValue.value == null) {
      showSnackBar(context: context, content: 'Uplaod Aadhar Card');
      return false;
    } else if (UploadDoc.bankChequeValue.value == null) {
      showSnackBar(context: context, content: 'Uplaod bank cheque');
      return false;
    } else if (UploadDoc.dlValue.value == null) {
      showSnackBar(context: context, content: 'Uplaod DL');
      return false;
    } else if (UploadDoc.panValue.value == null) {
      showSnackBar(context: context, content: 'Uplaod PAN card');
      return false;
    } else if (UploadDoc.photoValue.value == null) {
      showSnackBar(context: context, content: 'Uplaod Photo');
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // File? aadhar;
    // File? dl;
    // File? pan;
    // File? bankCheque;
    // File? photo;
    // List<File> doclList;
    return Scaffold(
      body: Container(
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
                height: 30,
              ),
              GestureDetector(
                onTap: () async {
                  if (dataValidation()) {
                    await storeUserData();
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
