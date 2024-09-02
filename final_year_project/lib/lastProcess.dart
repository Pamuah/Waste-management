import 'package:final_year_project/models/details.dart';
import 'package:final_year_project/models/payment.dart';
import 'package:final_year_project/widget/requestDetailsWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinishScreen extends StatefulWidget {
  const FinishScreen({super.key});

  @override
  State<FinishScreen> createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  @override
  Widget build(BuildContext context) {
    final detailsModel = Provider.of<DetailsModel>(context);
    final selectedPaymentMethod =
        context.watch<PaymentProvider>().selectedPaymentMethod;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        toolbarHeight: 70,
        centerTitle: true,
        title: const Text(
          'Request Details',
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailsWidget(
                title: 'Details about the request:',
                response: '${detailsModel.bags}'),
            DetailsWidget(
                title: 'Type of Payment:', response: selectedPaymentMethod),
            DetailsWidget(title: 'Address:', response: detailsModel.address),
            DetailsWidget(
                title: 'Details:', response: '${detailsModel.description}'),
            DetailsWidget(
                title: 'Solid Waste Collector:',
                response: detailsModel.wastCollector)
          ],
        ),
      ),
    );
  }
}
