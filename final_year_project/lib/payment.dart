import 'package:final_year_project/lastProcess.dart';
import 'package:final_year_project/models/payment.dart';
import 'package:final_year_project/widget/companiesWidget.dart';
import 'package:final_year_project/widget/paymentWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        toolbarHeight: 70,
        centerTitle: true,
        title: const Text(
          'Payment',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          PaymentWidget(
            title: 'Cash',
            image: 'assets/cash.jpg',
            onActionPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FinishScreen()));

              context.read<PaymentProvider>().selectPaymentMethod('Cash');
            },
          ),
          PaymentWidget(
            title: 'Mobile Money',
            image: 'assets/mobile_money.jpg',
            onActionPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FinishScreen()));

              context
                  .read<PaymentProvider>()
                  .selectPaymentMethod('Mobile Money');
            },
          ),
          PaymentWidget(
            title: 'Visa Card',
            image: 'assets/visa-gold-card.jpg',
            onActionPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FinishScreen()));

              context.read<PaymentProvider>().selectPaymentMethod('Visa Card');
            },
          )
        ],
      ),
    );
  }
}
