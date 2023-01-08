import 'package:flutter/material.dart';

class BuildIndicator extends StatelessWidget {
  final int index;
  const BuildIndicator({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return index == 0
        ? const Text(
            'Aadhar',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          )
        : index == 1
            ? const Text(
                'DL',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
              )
            : index == 2
                ? const Text(
                    'PAN',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  )
                : index == 3
                    ? const Text(
                        'Bank Cheque',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      )
                    : const Text(
                        'Photo',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      );
  }
}

buildIndicator(int index) {}
