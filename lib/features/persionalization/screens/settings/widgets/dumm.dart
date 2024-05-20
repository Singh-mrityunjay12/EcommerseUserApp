import 'package:flutter/material.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/loadders/spinkit_loader.dart';

class Dummmm extends StatefulWidget {
  const Dummmm({super.key});

  @override
  State<Dummmm> createState() => _DummmmState();
}

class _DummmmState extends State<Dummmm> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MAppBar(
        title: Text("Dmmmm"),
        showBackArrow: true,
      ),
      body: Center(
        child: SpinkitLoader(),
      ),
    );
  }
}
