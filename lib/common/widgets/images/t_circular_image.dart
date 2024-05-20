import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/heleper_functions.dart';
import '../shimmer/loadingIndicator.dart';

class MCircularImage extends StatelessWidget {
  const MCircularImage(
      {super.key,
      this.height = 60,
      this.width = 60,
      this.overLayColor,
      this.backgroundColor,
      required this.image,
      this.fit = BoxFit.cover,
      this.padding = MSizes.sm,
      this.isNetworkImage = false});

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overLayColor;
  final Color? backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          color: backgroundColor ??
              (MHelperFunction.isDarkMode(context)
                  ? MColors.black
                  : MColors.grey),
          borderRadius: BorderRadius.circular(100)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Center(
          child: isNetworkImage
              ?
              // ? Image.network(
              //     image,
              //     fit: BoxFit.cover,
              //     width: 100,
              //   )
              CachedNetworkImage(
                  fit: fit,
                  // height: 100,
                  width: 60,
                  imageUrl: image,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      const MShimmerEffect(
                        width: 80,
                        height: 80,
                        radius: 80,
                      ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  color: overLayColor)
              : Image(
                  fit: fit,
                  image: AssetImage(image),
                  color: overLayColor,
                ),
        ),
      ),
    );
  }
}
