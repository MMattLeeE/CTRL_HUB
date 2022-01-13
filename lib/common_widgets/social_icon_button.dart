import 'package:flutter/material.dart';

class SocialIconButton extends StatelessWidget {
  const SocialIconButton({
    Key? key,
    this.alignment: Alignment.center,
    this.padding: EdgeInsets.zero,
    this.height: 40,
    this.width: 225,
    this.fillColor: Colors.white,
    this.textColor: Colors.black,
    this.iconWidth: 50,
    this.image,
    this.onPressed,
    this.textStyle,
    this.text: 'custom button',
  }) : super(key: key);

  final Alignment alignment;
  final EdgeInsets padding;
  final double height;
  final double width;
  final Color fillColor;
  final Color textColor;
  final double iconWidth;
  final Image? image;
  final String text;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: this.alignment,
      child: Padding(
        padding: this.padding,
        child: SizedBox(
          height: this.height,
          width: this.width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: this.fillColor,
              onPrimary: this.textColor,
            ),
            onPressed: this.onPressed,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: double.infinity,
                  width: this.iconWidth,
                  child: this.image,
                ),
                Text(
                  this.text,
                  style: this.textStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
