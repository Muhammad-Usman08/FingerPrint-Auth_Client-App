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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Pass company name and specific barcode handling rules
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BarcodeView(companyName: 'Peshawat electric supply company', barcodeLength: 16),
                  ),
                );
              },
              child: Text('Peshawat electric supply company'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Pass company name and specific barcode handling rules
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BarcodeView(companyName: 'MPEC', barcodeLength: 12),
                  ),
                );
              },
              child: Text('MPEC'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Pass company name and specific barcode handling rules
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BarcodeView(companyName: 'SUI Northen Gas Pipelines', barcodeLength: 12),
                  ),
                );
              },
              child: Text('SUI Northen Gas Pipelines'),
            ),
             SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Pass company name and specific barcode handling rules
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BarcodeView(companyName: 'K-Electric', barcodeLength: 12),
                  ),
                );
              },
              child: Text('K-Electric'),
            ),
          ],
        ),
      ),
    );
  }
}
