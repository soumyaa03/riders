import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riders/features/post_riders/post_rider_controller.dart';
import 'package:riders/models/rider_model.dart';
import 'package:riders/screens/add_rider.dart';
import 'package:riders/screens/view_rider_screen.dart';
import 'package:riders/widgets/rider_widget.dart';

class HomeScreen extends ConsumerWidget {
  static const routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Riders',
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.left,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                              key: ObjectKey(index),
                              onDismissed: (DismissDirection direction) async {
                                if (direction == DismissDirection.startToEnd) {
                                  //APPROVE RIDER

                                  RiderModel approvedRider = RiderModel(
                                    riderName: snapshot.data![index].riderName,
                                    uid: snapshot.data![index].riderName,
                                    phoneNumber:
                                        snapshot.data![index].phoneNumber,
                                    localities:
                                        snapshot.data![index].localities,
                                    currentAddress:
                                        snapshot.data![index].currentAddress,
                                    pincode: snapshot.data![index].pincode,
                                    bankAccountNumber:
                                        snapshot.data![index].bankAccountNumber,
                                    ifscNumber:
                                        snapshot.data![index].ifscNumber,
                                    photoUrl: snapshot.data![index].photoUrl,
                                    dlUrl: snapshot.data![index].dlUrl,
                                    panUrl: snapshot.data![index].panUrl,
                                    bankChequeUrl:
                                        snapshot.data![index].bankChequeUrl,
                                    aadharUrl: snapshot.data![index].aadharUrl,
                                  );

                                  ref
                                      .read(postControllerProvider)
                                      .saveApprovedRiderDataToFireBase(
                                          approvedRider);
                                } else {
                                  //REJECT RIDER

                                }
                              },
                              child: InkWell(
                                onTap: () {
                                  // var url =
                                  //     'https://firebasestorage.googleapis.com/v0/b/riders-4f8dd.appspot.com/o/aadharDocuments%2Fphotos%2Fdata%2Fuser%2F0%2Fcom.example.riders%2Fcache%2Fimage_picker2400482709162048794.jpg?alt=media&token=49533b9e-4fe2-4a6d-bc9c-2d711d710207';
                                  // if (url ==
                                  //     snapshot.data![index].bankChequeUrl) {
                                  //   log('bank url working');
                                  // } else {
                                  //   log('not working');
                                  // }
                                  // log(snapshot.data![index].bankChequeUrl);
                                  // log('');
                                  // log('next');
                                  Navigator.pushNamed(
                                    context,
                                    ViewRiderScreen.routeName,
                                    arguments: {
                                      'riderName':
                                          snapshot.data![index].riderName,
                                      'address':
                                          snapshot.data![index].currentAddress,
                                      'phoneNumber':
                                          snapshot.data![index].phoneNumber,
                                      'locality':
                                          snapshot.data![index].localities,
                                      'aadharFile':
                                          snapshot.data![index].aadharUrl,
                                      'dlFile': snapshot.data![index].dlUrl,
                                      'panFile': snapshot.data![index].panUrl,
                                      'bankChequeFile':
                                          snapshot.data![index].bankChequeUrl,
                                      'photoFile':
                                          snapshot.data![index].photoUrl,
                                    },
                                  );
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: RiderWidget(
                                      text: snapshot.data![index].riderName,
                                      color: Colors.blueAccent,
                                    )),
                              ));
                        }))
                    : Container();
              },
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddRider.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
