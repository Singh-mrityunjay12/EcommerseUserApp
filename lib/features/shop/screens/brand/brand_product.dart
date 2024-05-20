import 'package:flutter/material.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/brands/t_brand_card.dart';
import '../../../../common/widgets/shimmer/vertical_product_shimmer.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../controllers/brand_controller.dart';
import '../../models/brand_model.dart';
import '../sortable/sortable_product.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: MAppBar(
        title: Text(
          brand.name,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MSizes.spaceBtwProduct),
          child: Column(
            children: [
              //Brand Detail
              MBrandCard(
                showBorder: true,
                brand: brand,
              ),
              const SizedBox(
                height: MSizes.spaceBtwSection,
              ),
              FutureBuilder(
                  future: controller.getBrandProducts(brandId: brand.id),
                  builder: (context, snapshot) {
                    //Check the state of the FutureBuilder snapshot
                    //Handle Loader,No Record, OR Error Message
                    const loader = MVerticalProductShimmer();
                    final widget = MCloudHelperFunction.checkMultiRecordState(
                        snapshot: snapshot, loader: loader);

                    //Return appropriate Widget based on snapshot state
                    if (widget != null) return widget;

                    //Record Found!
                    final brandProducts = snapshot.data!;
                    return MSortableProducts(
                      products: brandProducts,
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
