import 'package:final_year_project/lastProcess.dart';
import 'package:flutter/material.dart';

class PaymentWidget extends StatelessWidget {
  const PaymentWidget({
    Key? key,
    required this.title,
    required this.image,
    required this.onActionPressed,
  }) : super(key: key);

  final String title;
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
            height: 80,
            width: 80,
            child: Image.asset(image),
          ),
          title: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
