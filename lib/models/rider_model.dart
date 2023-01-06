class RiderModel {
  final String riderName;
  final String uid;
  final String phoneNumber;
  final String localities;
  final String currentAddress;
  final String pincode;
  final String bankAccountNumber;
  final String ifscNumber;
  final String photoUrl;
  final String dlUrl;
  final String panUrl;
  final String bankChequeUrl;
  final String aadharUrl;

  RiderModel({
    required this.riderName,
    required this.uid,
    required this.phoneNumber,
    required this.localities,
    required this.currentAddress,
    required this.pincode,
    required this.bankAccountNumber,
    required this.ifscNumber,
    required this.photoUrl,
    required this.dlUrl,
    required this.panUrl,
    required this.bankChequeUrl,
    required this.aadharUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': riderName,
      'uid': uid,
      'phoneNumber': phoneNumber,
      'locality': localities,
      'currentAddress': currentAddress,
      'pincode': pincode,
      'bankAccountNumber': bankAccountNumber,
      'ifscNumber': ifscNumber,
      'photoUrl': photoUrl,
      'dlUrl': dlUrl,
      'aadharUrl': aadharUrl,
      'bankChequeUrl': bankChequeUrl,
      'panUrl': panUrl,
    };
  }

  factory RiderModel.fromMap(Map<String, dynamic> map) {
    return RiderModel(
      riderName: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      uid: map['uid'] ?? '',
      localities: map['locality'] ?? '',
      currentAddress: map['currentAddress'] ?? '',
      pincode: map['pincode'] ?? '',
      bankAccountNumber: map['bankAccountNumber'] ?? '',
      ifscNumber: map['ifscNumber'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      dlUrl: map['dlUrl'] ?? '',
      panUrl: map['panUrl'] ?? '',
      aadharUrl: map['aadharUrl'] ?? '',
      bankChequeUrl: map['bankCheque'] ?? '',
    );
  }
}
