import 'package:flutter/material.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';
import 'widgets/order_list.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MAppBar(
        title: Text(
          "My Orders",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: const Padding(
          padding: EdgeInsets.all(MSizes.defaultSpace),

          //Orders
          child: MOrderListItems()),
    );
  }
}
