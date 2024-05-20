import 'package:flutter/material.dart';

import '../../../../utils/constants/enums.dart';
import '../../../features/shop/models/brand_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/heleper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';
import '../images/t_circular_image.dart';
import '../texts/t_brand_title_text_with_verified_icon.dart';

class MBrandCard extends StatelessWidget {
  const MBrandCard(
      {super.key, required this.showBorder, this.onTap, required this.brand});

  final BrandModel brand;
  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      //Container Design

      child: MRoundedContainer(
        showBorder: showBorder,
        height: 60,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(MSizes.sm),
        child: Row(children: [
          //Icon
          Flexible(
            child: MCircularImage(
              isNetworkImage: true,
              image: brand.image,
              backgroundColor: Colors.transparent,
              overLayColor: MHelperFunction.isDarkMode(context)
                  ? MColors.white
                  : MColors.black,
            ),
          ),
          const SizedBox(
            height: MSizes.spaceBtwItems / 2,
          ),

          //Text
          //[Expanded] & Column [MainAixSize.min] is important to keep the element in the vertical center and also
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MBrandTitleWithVerifiedIcon(
                title: brand.name,
                brandTextSizes: TextSizes.large,
              ),
              const SizedBox(
                height: MSizes.xMin,
              ),
              Text(
                '${brand.productsCount ?? 0} products',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelMedium,
              )
            ],
          )
        ]),
      ),
    );
  }
}
