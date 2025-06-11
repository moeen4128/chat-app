import 'package:flutter/material.dart';

import '../../core/theme/app_sizes.dart';

class TextWithAction extends StatelessWidget {
  final String text;
  final String actionText;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final TextStyle? actionTextStyle;
  final double spacing;

  const TextWithAction({
    super.key,
    required this.text,
    required this.actionText,
    required this.onPressed,
    this.textStyle,
    this.actionTextStyle,
    this.spacing = 4.0, // default spacing between text and button
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: textStyle),
        SizedBox(width: spacing),
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: EdgeInsets.only(left: AppSizes.spaceXS),
            minimumSize: Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(actionText, style: actionTextStyle),
        ),
      ],
    );
  }
}
