import 'package:flutter/material.dart';

import '../../../../common/ratings/rating_indicator.dart';
import '../../../../common/widgets/appbar/appbar.dart';

import '../../../../utils/constants/sizes.dart';

import 'widgets/rating_progress_indicator.dart';
import 'widgets/user_reviews_card.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      //Appbar
      appBar: MAppBar(
        title: Text("Reviews & Ratings"),
        showBackArrow: true,
      ),
      //Body
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Rating and reviews are verified and are from people who use the same type of device that you use"),
              SizedBox(
                height: MSizes.spaceBtwItems,
              ),

              ///Overall Product Ratings
              MOverallProductRating(),
              MRatingBarIndicator(
                rating: 3.5,
              ),
              //User Reviews List
              SizedBox(
                height: MSizes.spaceBtwItems / 2,
              ),
              UserReviewsCard(),
              UserReviewsCard(),
              UserReviewsCard()
            ],
          ),
        ),
      ),
    );
  }
}
