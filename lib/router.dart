import 'package:flutter/material.dart';
import 'package:riders/screens/add_rider.dart';
import 'package:riders/screens/hone_screen.dart';
import 'package:riders/screens/upload_doc.dart';
import 'package:riders/screens/view_document.dart';
import 'package:riders/screens/view_rider_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AddRider.routeName:
      return MaterialPageRoute(builder: (((context) => const AddRider())));
    case UploadDoc.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final riderName = arguments['riderName'];
      final phoneNumber = arguments['phoneNumber'];
      final locality = arguments['locality'];
      final ifscNumber = arguments['ifscNumber'];
      final currentPincode = arguments['currentPincode'];
      final currentAddress = arguments['currentAddress'];
      final accNumber = arguments['accNumber'];
      final List<String> localities = arguments['localities'];
      return MaterialPageRoute(
          builder: (((context) => UploadDoc(
                accNumber: accNumber,
                currentAddress: currentAddress,
                currentPincode: currentPincode,
                ifscNumber: ifscNumber,
                locality: locality,
                phoneNumber: phoneNumber,
                riderName: riderName,
                localities: localities,
              ))));

    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (context) => const HomeScreen());

    case ViewDocument.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final image = arguments['image'];
      return MaterialPageRoute(
          builder: (context) => ViewDocument(
                image: image,
              ));

    case ViewRiderScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final address = arguments['address'];
      final phoneNumber = arguments['phoneNumber'];
      final locality = arguments['locality'];
      final riderName = arguments['riderName'];
      final aadharFile = arguments['aadharFile'];
      final dlFile = arguments['dlFile'];
      final panFile = arguments['panFile'];
      final bankChequeFile = arguments['bankChequeFile'];
      final photoFile = arguments['photoFile'];
      final localities = arguments['localities'];
      return MaterialPageRoute(
          builder: (context) => ViewRiderScreen(
                localities: localities,
                address: address,
                locality: locality,
                phoneNumber: phoneNumber,
                riderName: riderName,
                aadharFile: aadharFile,
                dlFile: dlFile,
                panFile: panFile,
                bankChequeFile: bankChequeFile,
                photoFile: photoFile,
              ));

    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(
            child: Text('error'),
          ),
        ),
      );
  }
}
