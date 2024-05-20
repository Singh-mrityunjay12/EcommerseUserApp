import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/heleper_functions.dart';
import '../custom_shapes/containers/circular_container.dart';

class MChoiceChip extends StatelessWidget {
  const MChoiceChip(
      {super.key, required this.text, required this.selected, this.onSelected});
  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColor = MHelperFunction.getColor(text) != null;
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: isColor ? const SizedBox() : Text(text),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? MColors.white : null),
        avatar: isColor
            ? MCircularContainer(
                width: 50,
                height: 50,
                backgroundColor: MHelperFunction.getColor(text)!,
              )
            : null,
        shape: isColor ? const CircleBorder() : null,
        labelPadding: isColor ? const EdgeInsets.all(0) : null,
        backgroundColor: isColor ? MHelperFunction.getColor(text)! : null,
        padding: isColor ? const EdgeInsets.all(0) : null,
      ),
    );
  }
}
