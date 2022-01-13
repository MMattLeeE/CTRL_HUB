import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  /// A custom text widget with direct properties for Alignment, padding,
  /// font type, color, highlight, size
  const CustomText({
    Key? key,
    this.text: 'CustomText',
    this.alignment: Alignment.centerLeft,
    this.padding: EdgeInsets.zero,
  }) : super(key: key);

  final String text;
  final Alignment alignment;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: this.alignment,
      child: Padding(
        padding: this.padding,
        child: Text(
          this.text,
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}
