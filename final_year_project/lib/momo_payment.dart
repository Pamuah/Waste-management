import 'package:final_year_project/transaction.dart';
import 'package:final_year_project/widget/customTextfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MomoScreen extends StatefulWidget {
  const MomoScreen({super.key});

  @override
  State<MomoScreen> createState() => _MomoScreenState();
}

class _MomoScreenState extends State<MomoScreen> {
  TextEditingController _amountController = TextEditingController();
  TextEditingController _referrenceController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        toolbarHeight: 70,
        centerTitle: true,
        title: const Text(
          'Momo Payment',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextField(
                  hintText: 'Amount',
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  controller: _amountController,
                  contentPadding: const EdgeInsets.only(top: 5, left: 16.0)),
              CustomTextField(
                  hintText: 'Reference',
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  controller: _referrenceController,
                  contentPadding: const EdgeInsets.only(top: 5, left: 16.0)),
              CustomTextField(
                  hintText: 'Email',
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  controller: _emailController,
                  contentPadding: const EdgeInsets.only(top: 5, left: 16.0)),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TransactionPage(
                            amount: _amountController.text,
                            reference: _referrenceController.text,
                            email: _emailController.text,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Proceed to make payment',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
