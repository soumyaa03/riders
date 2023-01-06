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
              stream:
                  ref.watch(postControllerProvider).getRiderDataFromFireBase(),
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
                                } else {
                                  //REJECT RIDER
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
                                      'address':
                                          snapshot.data![index].currentAddress,
                                      'phoneNumber':
                                          snapshot.data![index].phoneNumber,
                                      'locality':
                                          snapshot.data![index].localities,
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
