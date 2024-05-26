import 'package:e_commerce/features/shop/controllers/product/product_controller.dart';

import 'package:e_commerce/features/shop/screens/product_details/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:get/get_navigation/get_navigation.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../../../../utils/constants/colors.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  SearchScreen({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    return Scaffold(
      backgroundColor: MColors.white,
      appBar: AppBar(
        title: title!.text.color(MColors.black).make(),
      ),
      body: FutureBuilder(
          future: controller.searchProducts(title),
          builder: (BuildContext context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (snapshot.data!.isEmpty) {
              return "No Product is found".text.makeCentered();
            } else {
              var data = snapshot.data!;
              // Gets a list of all the documents included in this snapshot.(means snapshot me jitane bhi document honge un sabhi ko list me convert kar deta h docs)
              var filtered = data
                  .where(
                    //where ka use karake ham log data ko filter karate h
                    (element) => element.title
                        .toString()
                        .toLowerCase()
                        .contains(title!
                            .toLowerCase()), //aise hamlog search ke through data access karate  and filter the data that what should we
                  )
                  .toList();
              // print(data[0]['p_name']);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      mainAxisExtent: 325),
                  children: filtered
                      .mapIndexed(
                        (currentValue, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              filtered[index].thumbnail,
                              width: 200,
                              fit: BoxFit.fill,
                            ),
                            Spacer(), //equal space provide
                            "${filtered[index].title}"
                                .text
                                // .fontFamily(semibold)
                                .color(MColors.black)
                                .make(),
                            10.heightBox,
                            "${filtered[index].price}"
                                .numCurrency
                                .text
                                // .fontFamily(bold1)
                                .color(MColors.error)
                                .make()
                          ],
                        )
                            .box
                            .white
                            .margin(EdgeInsets.symmetric(horizontal: 4))
                            .outerShadowMd
                            .padding(EdgeInsets.all(12))
                            .roundedSM
                            .make()
                            .onTap(() {
                          // var controller = Get.put(
                          //     ProductController()); //here hame ProductController() isliye initialized karvana pada kyoki ItemDetails() screen me ham ProductController() ko find kar rahe h
                          //initialized nahi kar rah h fiind kar rahe h
                          Get.to(() =>
                              ProductDetailsScreen(product: filtered[index]));
                        }),
                      )
                      .toList(), //jab GridView.builder() jab use nahi karate h to aise value get karete h
                ),
              );
            }
          }),
    );
  }
}
