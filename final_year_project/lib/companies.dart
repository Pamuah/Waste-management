import 'package:final_year_project/models/details.dart';
import 'package:final_year_project/payment.dart';
import 'package:final_year_project/widget/companiesWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        toolbarHeight: 70,
        centerTitle: true,
        title: const Text(
          'Companies',
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
          Companies(
            title: 'ZoomLion Ghana Limited',
            subtitle: 'Kumasi Adum Road',
            image: 'assets/zoomlion.jpg',
            onActionPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PaymentScreen()));
              context
                  .read<DetailsModel>()
                  .wastecollector('ZoomLion Ghana Limited');
            },
          ),
          Companies(
            title: 'AKA Cleaning Services',
            subtitle: 'Kumasi Adum Road',
            image: 'assets/akacleaning.jpg',
            onActionPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PaymentScreen()));
              context
                  .read<DetailsModel>()
                  .wastecollector("AKA Cleaning Services");
            },
          ),
          Companies(
            title: 'Recycle Up',
            subtitle: 'Plot 33 Totte, Kumasi',
            image: 'assets/recycleUp.jpg',
            onActionPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PaymentScreen()));
              context.read<DetailsModel>().wastecollector("Recycle Up");
            },
          ),
        ],
      ),
    );
  }
}
