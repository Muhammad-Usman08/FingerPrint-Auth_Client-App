import 'package:flutter/material.dart';
import 'package:my_app/views/qr_code/qr_code_view.dart';

class CompaniesView extends StatelessWidget {
  const CompaniesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Companies',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[400],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buttonWidet(context, 'Peshawar electric supply company', 16),
              buttonWidet(context, 'MPEC', 16),
              buttonWidet(context, 'LESCO', 16),
              buttonWidet(context, 'SUI Northen Gas Pipelines', 11),
              buttonWidet(context, 'K-Electric', 16),          
              buttonWidet(context, 'Faisalabad electric supply company', 16),          
              buttonWidet(context, 'Quetta electric supply company', 16),          
              buttonWidet(context, 'Sukkur electric power company', 16),          
              buttonWidet(context, 'Hyderabad electric supply company', 16),          
              buttonWidet(context, 'gujranwala electric power company', 16),          
            ],
          ),
        ),
      ),
    );
  }

  buttonWidet( BuildContext context , String buttonName, int barcodeLength) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  BarcodeView(companyName: buttonName, barcodeLength: barcodeLength),
            ),
          );
        },
        child: Text(buttonName),
      ),
    );
  }
}
