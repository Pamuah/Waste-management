import 'package:final_year_project/companies.dart';
import 'package:final_year_project/models/details.dart';
import 'package:final_year_project/widget/customTextfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  TextEditingController bagsController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        toolbarHeight: 70,
        centerTitle: true,
        title: const Text(
          'Details',
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
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CustomTextField(
                hintText: 'Number of bags',
                height: 50,
                width: MediaQuery.of(context).size.width,
                controller: bagsController,
                contentPadding: const EdgeInsets.only(top: 5, left: 16.0)),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0, top: 50.0),
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: 'Details',
                  hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<DetailsModel>(context, listen: false)
                      .setDescription(descriptionController.text);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CompanyScreen()));
                },
                child: Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
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
          ],
        ),
      ),
    );
  }
}
