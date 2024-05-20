import 'package:flutter/material.dart';

import '../../../../features/shop/models/cart_item_model.dart';
import '../../../../utils/constants/colors.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/heleper_functions.dart';
import '../../images/m_launched_images.dart';
import '../../texts/product_title_text.dart';
import '../../texts/t_brand_title_text_with_verified_icon.dart';

class MCartItem extends StatelessWidget {
  const MCartItem({
    required this.cartItem,
    super.key,
  });

  final CartItemModel cartItem;
  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunction.isDarkMode(context);
    return Row(
      children: [
        //Image
        MRoundedImages(
          imageUrl: cartItem.image ?? '',
          width: 60,
          height: 60,
          isNetworkImage: true,
          padding: const EdgeInsets.all(MSizes.sm),
          backgroundColor: dark ? MColors.darkerGrey : MColors.light,
        ),
        const SizedBox(
          width: MSizes.spaceBtwItems,
        ),
        //Title,Price & Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MBrandTitleWithVerifiedIcon(title: cartItem.brandName ?? ''),

              Flexible(
                child: MProductTitleText(
                  title: cartItem.title,
                  maxLines: 1,
                ),
              ),

              //Attribute
              Text.rich(TextSpan(
                  children: (cartItem.selectedVariations ?? {})
                      .entries
                      .map((e) => TextSpan(children: [
                            TextSpan(
                                text: '${e.key} ',
                                style: Theme.of(context).textTheme.bodySmall),
                            TextSpan(
                                text: '${e.value} ',
                                style: Theme.of(context).textTheme.bodyLarge)
                          ]))
                      .toList()))
            ],
          ),
        ),
      ],
    );
  }
}
