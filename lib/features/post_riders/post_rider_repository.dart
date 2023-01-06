import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riders/common/repository/store_file_firebase.dart';
import 'package:riders/models/rider_model.dart';

final postRepositoryProvider = Provider(
    ((ref) => PostRiderRepository(firestore: FirebaseFirestore.instance)));

class PostRiderRepository {
  final FirebaseFirestore firestore;
  PostRiderRepository({
    required this.firestore,
  });

  void saveRiderDataToFireBase({
    required String riderName,
    required String phoneNumber,
    required String locality,
    required String currentAddress,
    required String currentPincode,
    required String accNumber,
    required String ifscNumber,
    required ProviderRef ref,
    required BuildContext context,
    required File? aadhar,
    required File? dl,
    required File? pan,
    required File? bankCheque,
    required File? photo,
  }) async {
    try {
      String uid = riderName;

      String photoUrl = await ref
          .read(commonFirebaseStorageRepositoryProvider)
          .storeFileToFireBase('photoDocuments/', photo!);
      String bankChequeUrl = await ref
          .read(commonFirebaseStorageRepositoryProvider)
          .storeFileToFireBase('photoDocuments/', bankCheque!);
      String panUrl = await ref
          .read(commonFirebaseStorageRepositoryProvider)
          .storeFileToFireBase('photoDocuments/', pan!);
      String dlUrl = await ref
          .read(commonFirebaseStorageRepositoryProvider)
          .storeFileToFireBase('photoDocuments/', dl!);
      String aadharUrl = await ref
          .read(commonFirebaseStorageRepositoryProvider)
          .storeFileToFireBase('photoDocuments/', aadhar!);

      var rider = RiderModel(
        riderName: riderName,
        uid: uid,
        phoneNumber: phoneNumber,
        localities: locality,
        currentAddress: currentAddress,
        pincode: currentPincode,
        bankAccountNumber: accNumber,
        ifscNumber: ifscNumber,
        photoUrl: photoUrl,
        dlUrl: dlUrl,
        panUrl: panUrl,
        bankChequeUrl: bankChequeUrl,
        aadharUrl: aadharUrl,
      );

      await FirebaseFirestore.instance.collection('riders').add(rider.toMap());
    } catch (e) {
      log(e.toString());
    }
  }

  Stream<List<RiderModel>> getRiderDataFromFireBase() {
    return firestore.collection('riders').snapshots().asyncMap((event) async {
      List<RiderModel> riders = [];
      for (var document in event.docs) {
        var riderData = RiderModel.fromMap(document.data());
        riders.add(RiderModel(
            riderName: riderData.riderName,
            uid: riderData.uid,
            phoneNumber: riderData.phoneNumber,
            localities: riderData.localities,
            currentAddress: riderData.currentAddress,
            pincode: riderData.pincode,
            bankAccountNumber: riderData.bankAccountNumber,
            ifscNumber: riderData.ifscNumber,
            photoUrl: riderData.photoUrl,
            dlUrl: riderData.dlUrl,
            panUrl: riderData.panUrl,
            bankChequeUrl: riderData.bankChequeUrl,
            aadharUrl: riderData.aadharUrl));
      }
      return riders;
    });
  }
}
