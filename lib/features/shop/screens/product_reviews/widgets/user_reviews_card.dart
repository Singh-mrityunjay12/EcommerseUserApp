import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../../../common/ratings/rating_indicator.dart';
import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/heleper_functions.dart';

class UserReviewsCard extends StatelessWidget {
  const UserReviewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunction.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(MImage.userProfileImage1),
                ),
                const SizedBox(
                  width: MSizes.spaceBtwItems,
                ),
                Text(
                  "Narangi Lal",
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        const SizedBox(
          width: MSizes.spaceBtwItems,
        ),

        //Review
        Row(
          children: [
            const MRatingBarIndicator(rating: 4),
            const SizedBox(
              width: MSizes.spaceBtwItems,
            ),
            Text(
              "01 Nov, 2023",
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
        const SizedBox(
          width: MSizes.spaceBtwItems,
        ),
        const ReadMoreText(
          "asdfdgfhgjhjkgfdsazxcvbnmnbvcxsdfghjkjhgfdsdfghjkjhgfdsdcvbnmbvsdfghjgfdsdfghjfdsdfghfdsdfg",
          trimLines: 1,
          trimMode: TrimMode.Line,
          trimExpandedText: ' show less',
          trimCollapsedText: ' show more',
          moreStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: MColors.primary),
          lessStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: MColors.primary),
        ),

        const SizedBox(
          width: MSizes.spaceBtwItems,
        ),
        //Company reviews
        MRoundedContainer(
          backgroundColor: dark ? MColors.darkGrey : MColors.grey,
          child: Padding(
            padding: const EdgeInsets.all(MSizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "T's Store",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "02 Nov, 2023",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(
                  height: MSizes.spaceBtwItems,
                ),
                const ReadMoreText(
                  "asdfdgfhgjhjkgfdsazxcvbnmnbvcxsdfghjkjhgfdsdfghjkjhgfdsdcvbnmbvsdfghjgfdsdfghjfdsdfghfdsdfg",
                  trimLines: 1,
                  trimMode: TrimMode.Line,
                  trimExpandedText: ' show less',
                  trimCollapsedText: ' show more',
                  moreStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: MColors.primary),
                  lessStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: MColors.primary),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: MSizes.spaceBtwSection,
        )
      ],
    );
  }
}
