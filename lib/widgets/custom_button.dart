import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.icon,
    this.textColor,
  });

  final String text;
  final IconData? icon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      icon: icon != null ? Icon(icon, color: textColor ?? Colors.white) : null,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.blue),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
      onPressed: () {},
      label: Text("asdhjksahjd")
    );
  }
}
