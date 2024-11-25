import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../themes/fonts.dart';

class RoundedButton extends StatelessWidget {
  final Function()? get;
  final Color color;
  final String text;
  final double height;
  final double width;
  const RoundedButton({
    super.key,
    required this.get,
    required this.color,
    required this.text,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        get?.call();
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
        ),
        child: Center(
          child: Text(
            text,
            style: buttonLinkSBold,
          ),
        ),
      ),
    );
  }
}
