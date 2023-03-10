import 'package:flutter/material.dart';
import 'package:riders/widgets/build_indicator.dart';

class ViewRiderScreen extends StatefulWidget {
  static const routeName = '/view-rider-screen';
  final String riderName;
  final String phoneNumber;
  final String address;
  final String locality;
  final String aadharFile;
  final String dlFile;
  final String panFile;
  final String bankChequeFile;
  final String photoFile;
  final String localities;
  const ViewRiderScreen({
    Key? key,
    required this.riderName,
    required this.phoneNumber,
    required this.address,
    required this.locality,
    required this.aadharFile,
    required this.dlFile,
    required this.panFile,
    required this.bankChequeFile,
    required this.photoFile,
    required this.localities,
  }) : super(key: key);

  static ValueNotifier<int> currentIndexValue = ValueNotifier(0);

  @override
  State<ViewRiderScreen> createState() => _ViewRiderScreenState();
}

class _ViewRiderScreenState extends State<ViewRiderScreen> {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      widget.aadharFile,
      widget.dlFile,
      widget.panFile,
      widget.bankChequeFile,
      widget.photoFile
    ];

    // int currentIndex = 0;
    // print(bankChequeFile.toString());

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
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              // below container will be scrollable left to right
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      pageController.jumpToPage(
                          ViewRiderScreen.currentIndexValue.value - 1);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    width: 270,
                    child: PageView.builder(
                        controller: pageController,
                        onPageChanged: (index) {
                          setState(() {
                            ViewRiderScreen.currentIndexValue.value =
                                index % images.length;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SizedBox(
                              height: 200,
                              width: 250,
                              child: Image.network(
                                images[index % images.length],
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }),
                  ),
                  IconButton(
                    onPressed: () {
                      pageController.jumpToPage(
                          ViewRiderScreen.currentIndexValue.value + 1);
                    },
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),
              Center(
                  child: BuildIndicator(
                      index: ViewRiderScreen.currentIndexValue.value)),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.black,
                thickness: 1,
                height: 10,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 70,
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: SizedBox(
                            width: 100,
                            child: Text(
                              'Name',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            widget.riderName,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 70,
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: SizedBox(
                            width: 100,
                            child: Text(
                              'Phone Number',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            widget.phoneNumber,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 70,
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: SizedBox(
                            width: 100,
                            child: Text(
                              'Localities',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            widget.localities,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 70,
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: SizedBox(
                            width: 100,
                            child: Text(
                              'Address',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            widget.address,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
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
