import 'dart:io';

import 'package:flutter/material.dart';
import 'package:riders/features/post_riders/post_rider_repository.dart';
import 'package:riders/models/rider_model.dart';
import 'package:riverpod/riverpod.dart';

final postControllerProvider = Provider(((ref) {
  final riderRepository = ref.watch(postRepositoryProvider);
  return PostRiderController(postRiderRepository: riderRepository, ref: ref);
}));

class PostRiderController {
  final PostRiderRepository postRiderRepository;
  final ProviderRef ref;

  PostRiderController({required this.postRiderRepository, required this.ref});

  void saveRiderDataToFirebase(
      BuildContext context,
      String riderName,
      String phoneNumber,
      String locality,
      String currentAddress,
      String currentPincode,
      String accNumber,
      String ifscNumber,
      File? aadhar,
      File? dl,
      File? pan,
      File? bankCheque,
      File? photo,
      bool isApproved) {
    postRiderRepository.saveRiderDataToFireBase(
      riderName: riderName,
      phoneNumber: phoneNumber,
      locality: locality,
      currentAddress: currentAddress,
      currentPincode: currentPincode,
      accNumber: accNumber,
      ifscNumber: ifscNumber,
      aadhar: aadhar,
      dl: dl,
      pan: pan,
      bankCheque: bankCheque,
      photo: photo,
      ref: ref,
      context: context,
      isApproved: isApproved,
    );
  }

  saveApprovedRiderDataToFireBase(RiderModel approvedRider) {
    return postRiderRepository.saveApprovedRiderDataToFireBase(
        approvedRider: approvedRider);
  }

  Stream<List<RiderModel>> getUnapprovedRiderDataFromFireBase() {
    return postRiderRepository.getUnapprovedRiderDataFromFireBase();
  }

  Stream<List<RiderModel>> getApprovedRiderDataFromFireBase() {
    return postRiderRepository.getApprovedRiderDataFromFireBase();
  }
}
