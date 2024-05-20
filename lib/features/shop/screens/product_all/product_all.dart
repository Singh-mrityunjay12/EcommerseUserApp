import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/appbar.dart';

import '../../../../common/widgets/shimmer/vertical_product_shimmer.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../controllers/product/all_product_controller.dart';
import '../../models/product_model.dart';
import '../sortable/sortable_product.dart';

class AllProduct extends StatelessWidget {
  const AllProduct(
      {super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    //Initialize controller for managing product fetching
    final controller = Get.put(AllProductsController());
    return Scaffold(
      appBar: MAppBar(
        title: Text(title),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(MSizes.spaceBtwProduct),
            child: FutureBuilder(
                future: futureMethod ?? controller.fetchProductsByQuery(query),
                builder: (context, snapshot) {
                  //Check the state of the FutureBuilder snapshot
                  const loader = MVerticalProductShimmer();
                  final widget = MCloudHelperFunction.checkMultiRecordState(
                      snapshot: snapshot, loader: loader);

                  //Return appropriate Widget based on snapshot state
                  if (widget != null) return widget;

                  //Product found!
                  final products = snapshot.data!;

                  return MSortableProducts(
                    products: products,
                  );
                })),
      ),
    );
  }
}
