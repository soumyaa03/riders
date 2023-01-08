import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riders/common/utils/utils.dart';
import 'package:riders/screens/upload_doc.dart';
import 'package:riders/widgets/textfield_widget.dart';

class AddRider extends ConsumerStatefulWidget {
  static const routeName = '/add-rider';
  const AddRider({super.key});

  @override
  ConsumerState<AddRider> createState() => _AddRiderState();
}

class _AddRiderState extends ConsumerState<AddRider> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController localityController = TextEditingController();
  TextEditingController currentAddressController = TextEditingController();
  TextEditingController currentPincodeController = TextEditingController();
  TextEditingController banckAccountNumberController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  List<String> addedItems = [];

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
    localityController.dispose();
    currentAddressController.dispose();
    currentPincodeController.dispose();
    banckAccountNumberController.dispose();
    ifscController.dispose();
  }

  @override
  void initState() {
    addedItems = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool dataValidation() {
      if (addedItems.isEmpty) {
        showSnackBar(context: context, content: 'Select atleast one locality');
      }
      if (nameController.text.isEmpty) {
        showSnackBar(context: context, content: 'name field cannot be empty');
        return false;
      } else if (phoneController.text.isEmpty) {
        showSnackBar(context: context, content: 'phone field cannot be empty');
        return false;
      } else if (currentAddressController.text.isEmpty) {
        showSnackBar(
            context: context, content: 'address field cannot be empty');
        return false;
      } else if (currentPincodeController.text.isEmpty) {
        showSnackBar(
            context: context, content: 'pincode field cannot be empty');
        return false;
      } else if (banckAccountNumberController.text.isEmpty) {
        showSnackBar(
            context: context,
            content: 'bank account number field cannot be empty');
        return false;
      } else if (ifscController.text.isEmpty) {
        showSnackBar(context: context, content: 'ifsc field cannot be empty');
        return false;
      } else if (phoneController.text.length < 9) {
        showSnackBar(
            context: context,
            content: 'invalid phone number : number cannot be less than 9');
        return false;
      } else if (currentPincodeController.text.length < 6) {
        showSnackBar(
            context: context,
            content:
                'invalid area pincode : pincode cannot be less than 6 digits');
        return false;
      } else {
        return true;
      }
    }

    List<DropdownMenuItem> dropitems = [
      const DropdownMenuItem(
        value: 'Delhi',
        child: Center(
          child: Text('Delhi'),
        ),
      ),
      const DropdownMenuItem(
        value: 'Kolkota',
        child: Center(
          child: Text('Kolkota'),
        ),
      ),
      const DropdownMenuItem(
        value: 'Mumbai',
        child: Center(
          child: Text('Mumbai'),
        ),
      ),
      const DropdownMenuItem(
        value: 'Banglore',
        child: Center(
          child: Text('Banglore'),
        ),
      ),
    ];

    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 150,
                child: Center(
                  child: Text(
                    "Add New Rider",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Name",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                    textController: nameController,
                    hintText: 'Enter Name',
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Phone Number",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                    textController: phoneController,
                    hintText: 'Enter Phone Number',
                    keyBoardType: 1,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Locality",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: DropdownButton(
                            isExpanded: true,
                            hint: const Text('Select Locality'),
                            items: dropitems,
                            onChanged: (newValue) {
                              addedItems.length != 3
                                  ? setState(() {
                                      addedItems.add(newValue);
                                    })
                                  : showSnackBar(
                                      context: context,
                                      content:
                                          'cannot select more than three items');
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < addedItems.length; i++)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                  ),
                                  height: 60,
                                  width: 70,
                                  child: Center(
                                    child: Text(
                                      addedItems[i],
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        )
                      ],
                    ),
                  ),
                  // TextFieldWidget(
                  //     textController: localityController, hintText: 'enter'),
                  const SizedBox(height: 20),
                  const Text(
                    "Address",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                    textController: currentAddressController,
                    hintText: 'Enter Address',
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Pincode",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                    textController: currentPincodeController,
                    hintText: 'Enter Pincode',
                    keyBoardType: 1,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Account Number",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                    textController: banckAccountNumberController,
                    hintText: 'Enter Account Number',
                    keyBoardType: 1,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "IFSC number",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                    textController: ifscController,
                    hintText: 'Enter IFSC Code',
                    keyBoardType: 1,
                  ),
                  const SizedBox(height: 50),
                  InkWell(
                    onTap: (() {
                      if (dataValidation()) {
                        Navigator.pushNamed(
                          context,
                          UploadDoc.routeName,
                          arguments: {
                            'riderName': nameController.text.trim(),
                            'currentAddress':
                                currentAddressController.text.trim(),
                            'phoneNumber': phoneController.text.trim(),
                            'locality': localityController.text.trim(),
                            'currentPincode':
                                currentPincodeController.text.trim(),
                            'accNumber':
                                banckAccountNumberController.text.trim(),
                            'ifscNumber': ifscController.text.trim(),
                            'localities': addedItems,
                          },
                        );
                      }
                    }),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 14,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Next',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
