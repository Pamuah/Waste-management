import 'package:final_year_project/payment.dart';
import 'package:flutter/material.dart';

class Companies extends StatelessWidget {
  const Companies({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.onActionPressed,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String image;
  final VoidCallback onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: onActionPressed,
        child: ListTile(
          leading: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: Image.asset(image),
          ),
          title: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
