import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/Network/network_manager.dart';
import '../../../common/widgets/loadders/loadders.dart';
import '../../../common/widgets/popups/full_screen_loader.dart';
import '../../../common/widgets/texts/section_heading.dart';
import '../../../data/address/address_repository.dart';
import '../../../utils/constants/image_string.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/cloud_helper_functions.dart';
import '../model/adress/adress_model.dart';
import '../screens/address/add_new_address.dart';
import '../screens/address/widgets/single_address.dart';

class AddressEditController extends GetxController {
  static AddressEditController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();

  RxBool refreshData = true.obs;

  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  //Fetch all user specific address

  Future<List<AddressModel>> getAllUserAddress() async {
    try {
      print('/////////////////////////////////bbbbbb');
      final addresses = await addressRepository.fetchNewUserAddress();
      print('/////////////////////////////////AAAAAAAAAA');
      selectedAddress.value = addresses.firstWhere(
          (element) => element.selectAddress,
          orElse: () => AddressModel.empty());
      print('/////////////////////////////////AAAAAAAAAA1233');
      return addresses;
    } catch (e) {
      MLoader.errorSnackBar(title: 'Address not found', message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      //Open Dialog
      Get.defaultDialog(
          title: '',
          onWillPop: () async {
            return false;
          },
          barrierDismissible: false,
          backgroundColor: Colors.transparent,
          content: const Center(
            child: CircularProgressIndicator(),
          ));

      //Clear the 'selected'address
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
            selectedAddress.value.id, false);
      }
      //Assign selected address
      newSelectedAddress.selectAddress = true;
      selectedAddress.value = newSelectedAddress;
      //Set the 'selected' field to true for the newly selected address
      await addressRepository.updateSelectedField(
          selectedAddress.value.id, true);

      //It is used to closed the CircularProgressIndicator(Closed the Dialog)
      Get.back();
    } catch (e) {
      MLoader.errorSnackBar(title: 'Error in selection', message: e.toString());
    }
  }

  //Add new address
  Future addNewAddresses(String docId) async {
    try {
      //Start loading
      MFullScreenLoader.openLoadingDialog(
          "Starting Address....", MImage.loadingGif);

      //Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MFullScreenLoader.stopLoading();
        return;
      }

      //Form validation
      if (!addressFormKey.currentState!.validate()) {
        MFullScreenLoader.stopLoading();
        return;
      }

      //Save Address data
      final address = AddressModel(
          id: '',
          name: name.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          street: street.text.trim(),
          city: city.text.trim(),
          state: state.text.trim(),
          postalCode: postalCode.text.trim(),
          country: country.text.trim(),
          selectAddress: true);

      await addressRepository.addEditAddress(address, docId);

      //Update selected address status
      // address.id = id;
      // await selectAddress(address);
      //Remove loader
      MFullScreenLoader.stopLoading();
      //Show success message
      MLoader.successSnackBar(
          title: "Congratulations",
          message: 'Your address has been saved successfully');
      //Refresh Addresses data
      refreshData.toggle();

      //Reset fields
      resetFormField();

      //Redirect
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   Navigator.of(Get.context!).push(MaterialPageRoute(
      //       builder: (_) => MSingleAddresses(address: address, onTap: () {})
      //       ));
      // });
      Navigator.of(Get.context!).pop();
    } catch (e) {
      //Remove loader
      MFullScreenLoader.stopLoading();
      MLoader.errorSnackBar(title: 'Address not found', message: e.toString());
    }
  }

  //Show Addresses MobileBottomSheet at CheckOut

  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(MSizes.lg),
          child: Column(
            children: [
              const MSectionHeading(
                title: "Select Address",
                showActionButton: false,
              ),
              FutureBuilder(
                  future: getAllUserAddress(),
                  builder: (_, snapshot) {
                    final response = MCloudHelperFunction.checkMultiRecordState(
                        snapshot: snapshot);
                    if (response != null) {
                      return response;
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) {
                          return MSingleAddresses(
                              address: snapshot.data![index],
                              onTap: () async {
                                await selectAddress(snapshot.data![index]);
                                Get.back();
                              });
                        });
                  }),
              const SizedBox(
                height: MSizes.defaultSpace * 2,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => Get.to(() => const AddNewAddressScreen()),
                    child: const Text("Add New Address")),
              )
            ],
          ),
        ),
      ),
    );
  }

  //Functions to reset form field
  void resetFormField() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState!.reset();
  }
}
