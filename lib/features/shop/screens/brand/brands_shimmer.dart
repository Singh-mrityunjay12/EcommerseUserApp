import 'package:flutter/material.dart';

import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/shimmer/loadingIndicator.dart';

class MBrandsShimmer extends StatelessWidget {
  const MBrandsShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return MGridLayOut(
        mainAxisExtend: 80,
        itemCount: itemCount,
        itemBuilder: (_, __) => const MShimmerEffect(width: 300, height: 80));
  }
}
