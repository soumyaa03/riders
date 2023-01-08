import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riders/common/utils/utils.dart';
import 'package:riders/features/post_riders/post_rider_controller.dart';
import 'package:riders/models/rider_model.dart';
import 'package:riders/screens/add_rider.dart';
import 'package:riders/screens/view_rider_screen.dart';
import 'package:riders/widgets/rider_widget.dart';

class UnapprovedRiderScreen extends ConsumerWidget {
  const UnapprovedRiderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                    child: StreamBuilder<List<RiderModel>>(
                  stream: ref
                      .watch(postControllerProvider)
                      .getUnapprovedRiderDataFromFireBase(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    return snapshot.hasData
                        ? ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: ((context, index) {
                              return Dismissible(
                                  key: UniqueKey(),
                                  onDismissed:
                                      (DismissDirection direction) async {
                                    if (direction ==
                                        DismissDirection.startToEnd) {
                                      //APPROVE RIDER

                                      RiderModel approvedRider = RiderModel(
                                        riderName:
                                            snapshot.data![index].riderName,
                                        uid: snapshot.data![index].uid,
                                        localities:
                                            snapshot.data![index].localities,
                                        phoneNumber:
                                            snapshot.data![index].phoneNumber,
                                        locality:
                                            snapshot.data![index].locality,
                                        currentAddress: snapshot
                                            .data![index].currentAddress,
                                        pincode: snapshot.data![index].pincode,
                                        bankAccountNumber: snapshot
                                            .data![index].bankAccountNumber,
                                        ifscNumber:
                                            snapshot.data![index].ifscNumber,
                                        photoUrl:
                                            snapshot.data![index].photoUrl,
                                        dlUrl: snapshot.data![index].dlUrl,
                                        panUrl: snapshot.data![index].panUrl,
                                        bankChequeUrl:
                                            snapshot.data![index].bankChequeUrl,
                                        aadharUrl:
                                            snapshot.data![index].aadharUrl,
                                      );

                                      DocumentReference docRef =
                                          FirebaseFirestore.instance
                                              .collection('UnapprovedRiders')
                                              .doc(snapshot.data![index].uid);
                                      docRef.delete();

                                      ref
                                          .read(postControllerProvider)
                                          .saveApprovedRiderDataToFireBase(
                                              approvedRider);
                                      showSnackBar(
                                          context: context,
                                          content: 'Rider Approved');
                                    } else {
                                      //REJECT RIDER

                                      DocumentReference docRef =
                                          FirebaseFirestore.instance
                                              .collection('UnapprovedRiders')
                                              .doc(snapshot.data![index].uid);
                                      docRef.delete();
                                      showSnackBar(
                                          context: context,
                                          content: 'Rider Rejected');
                                    }
                                  },
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        ViewRiderScreen.routeName,
                                        arguments: {
                                          'riderName':
                                              snapshot.data![index].riderName,
                                          'address': snapshot
                                              .data![index].currentAddress,
                                          'phoneNumber':
                                              snapshot.data![index].phoneNumber,
                                          'locality':
                                              snapshot.data![index].locality,
                                          'aadharFile':
                                              snapshot.data![index].aadharUrl,
                                          'dlFile': snapshot.data![index].dlUrl,
                                          'panFile':
                                              snapshot.data![index].panUrl,
                                          'bankChequeFile': snapshot
                                              .data![index].bankChequeUrl,
                                          'photoFile':
                                              snapshot.data![index].photoUrl,
                                          'localities':
                                              snapshot.data![index].localities,
                                        },
                                      );
                                    },
                                    child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        child: RiderWidget(
                                          text: snapshot.data![index].riderName,
                                          color: Colors.blueAccent,
                                        )),
                                  ));
                            }))
                        : const Center(
                            child: Text('error'),
                          );
                  },
                )),
              ],
            ),
          ),
          Positioned(
              bottom: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AddRider.routeName);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.shade700,
                      borderRadius: BorderRadius.circular(10)),
                  height: 70,
                  width: 120,
                  child: const Center(
                    child: Text(
                      'Add Rider',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
