import 'package:flutter/material.dart';

class ViewRiderScreen extends StatelessWidget {
  static const routeName = '/view-rider-screen';
  final String riderName;
  final String phoneNumber;
  final String address;
  final String locality;
  const ViewRiderScreen({
    Key? key,
    required this.riderName,
    required this.phoneNumber,
    required this.address,
    required this.locality,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'View Rider',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              Text(
                riderName,
                style: const TextStyle(fontSize: 15, color: Colors.blue),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                address,
                style: const TextStyle(fontSize: 15, color: Colors.blue),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                phoneNumber,
                style: const TextStyle(fontSize: 15, color: Colors.blue),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                locality,
                style: const TextStyle(fontSize: 15, color: Colors.blue),
              ),
              const SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
