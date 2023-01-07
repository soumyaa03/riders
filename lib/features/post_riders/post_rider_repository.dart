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
    required bool isApproved,
  }) async {
    try {
      // String uid = riderName;
      // if (aadhar != null) {
      //   log(aadhar.path.toString());
      // }
      // if (pan != null) {
      //   log(pan.path.toString());
      // }
      // if (dl != null) {
      //   log(dl.path.toString());
      // }
      // if (bankCheque != null) {
      //   log(bankCheque.path.toString());
      // }
      // if (photo != null) {
      //   log(photo.path.toString());
      // }
      String photoUrl = await ref
          .read(commonFirebaseStorageRepositoryProvider)
          .storeFileToFireBase(
              'photoDocuments/photos', photo!.path.toString(), photo);
      String bankChequeUrl = await ref
          .read(commonFirebaseStorageRepositoryProvider)
          .storeFileToFireBase('bankChequeDocuments/photos',
              bankCheque!.path.toString(), bankCheque);
      String panUrl = await ref
          .read(commonFirebaseStorageRepositoryProvider)
          .storeFileToFireBase(
              'panDocuments/photos', pan!.path.toString(), pan);
      String dlUrl = await ref
          .read(commonFirebaseStorageRepositoryProvider)
          .storeFileToFireBase('dlDocuments/photos', dl!.path.toString(), dl);
      String aadharUrl = await ref
          .read(commonFirebaseStorageRepositoryProvider)
          .storeFileToFireBase(
              'aadharDocuments/photos', aadhar!.path.toString(), aadhar);

      var rider = RiderModel(
        riderName: riderName,
        uid: riderName,
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

      await FirebaseFirestore.instance
          .collection('UnapprovedRiders')
          .add(rider.toMap());
    } catch (e) {
      log(e.toString());
    }
  }

  saveApprovedRiderDataToFireBase({required RiderModel approvedRider}) async {
    try {
      await FirebaseFirestore.instance
          .collection('ApprovedRiders')
          .add(approvedRider.toMap());
    } catch (e) {
      log(e.toString());
    }
  }

  Stream<List<RiderModel>> getUnapprovedRiderDataFromFireBase() {
    return firestore
        .collection('UnapprovedRiders')
        .snapshots()
        .asyncMap((event) async {
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

  Stream<List<RiderModel>> getApprovedRiderDataFromFireBase() {
    return firestore
        .collection('ApprovedRiders')
        .snapshots()
        .asyncMap((event) async {
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
