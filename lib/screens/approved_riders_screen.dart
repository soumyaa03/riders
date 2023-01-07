import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riders/features/post_riders/post_rider_controller.dart';
import 'package:riders/models/rider_model.dart';
import 'package:riders/screens/add_rider.dart';
import 'package:riders/widgets/rider_widget.dart';

class ApprovedRiderScreen extends ConsumerWidget {
  const ApprovedRiderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
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
                    .getApprovedRiderDataFromFireBase(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  return snapshot.hasData
                      ? ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: ((context, index) {
                            return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: RiderWidget(
                                  text: snapshot.data![index].riderName,
                                  color: Colors.blueAccent,
                                ));
                          }))
                      : const CircularProgressIndicator();
                },
              ),
            ),
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
