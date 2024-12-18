import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeView extends StatefulWidget {
  final String companyName;
  final int barcodeLength; // The length of the barcode to capture

  const BarcodeView(
      {super.key, required this.companyName, required this.barcodeLength});

  @override
  State<BarcodeView> createState() => _BarcodeViewState();
}

class _BarcodeViewState extends State<BarcodeView> {
  String result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.companyName} - Barcode Scanner',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[400],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Center(
              child: ElevatedButton(
                onPressed: () async {
                  String barcode = await FlutterBarcodeScanner.scanBarcode(
                      '#ff6666', 'Cancel', true, ScanMode.BARCODE);
                  setState(() {
                    if (barcode.isNotEmpty) {
                      if (widget.companyName == 'MPEC') {
                        if (barcode.length > 8) {
                          // Skip first 8 characters and take next 18 characters
                          result = barcode.length >= 26
                              ? barcode.substring(8, 26)
                              : barcode.substring(8);
                        } else {
                          result = barcode;
                        }
                      } else if (widget.companyName == 'Peshawat electric supply company') {
                        if (barcode.length > 8) {
                          // Skip first 8 characters and take next 16 characters
                          result = barcode.length >= 24
                              ? barcode.substring(8, 24)
                              : barcode.substring(8);
                        } else {
                          result = barcode;
                        }
                      } else if (widget.companyName == 'SUI Northen Gas Pipelines') {
                        if (barcode.length > 8) {
                          // Skip first 8 characters and take next 16 characters
                          result = barcode.length >= 24
                              ? barcode.substring(5, 16)
                              : barcode.substring(5);
                        } else {
                          result = barcode;
                        }
                      }
                      else if (widget.companyName == 'K-Electric') {
                        if (barcode.length > 8) {
                          // Skip first 8 characters and take next 16 characters
                          result = barcode.length >= 24
                              ? barcode.substring(5, 16)
                              : barcode.substring(5);
                        } else {
                          result = barcode;
                        }
                      }
                    }
                  });
                },
                child: const Text("Scan Barcode", style: TextStyle(fontSize: 20)),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Text(
                  result.isNotEmpty
                      ? 'Account Id: $result'
                      : 'Please scan a barcode',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
