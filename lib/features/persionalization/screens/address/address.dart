import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../controller/address_controller.dart';
import 'add_new_address.dart';
import 'widgets/single_address.dart';

class UserAdressScreen extends StatelessWidget {
  const UserAdressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: MColors.primary,
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: const Icon(
          Iconsax.add,
          color: MColors.white,
        ),
      ),
      appBar: MAppBar(
        title: Text(
          'Addresses',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(MSizes.defaultSpace),
            child: Obx(() => FutureBuilder(
                //Use key to trigger refresh
                key: Key(controller.refreshData.value.toString()),
                future: controller.getAllUserAddress(),
                builder: (context, snapshot) {
                  //Handle Loader ,No Record, OR Error message
                  final response = MCloudHelperFunction.checkMultiRecordState(
                      snapshot: snapshot);
                  if (response != null) return response;
                  final addresses = snapshot.data!;

                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) {
                        return MSingleAddresses(
                          address: addresses[index],
                          onTap: () =>
                              controller.selectAddress(addresses[index]),
                        );
                      });
                }))),
      ),
    );
  }
}
