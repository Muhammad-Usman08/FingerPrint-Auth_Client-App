import 'package:biopassid_fingerprint_sdk/biopassid_fingerprint_sdk.dart';
import 'package:flutter/material.dart';

class DisplayImageScreen extends StatefulWidget {
  const DisplayImageScreen({super.key});

  @override
  State<DisplayImageScreen> createState() => _DisplayImageScreenState();
}

class _DisplayImageScreenState extends State<DisplayImageScreen> {
  late FingerprintController controller;
  String? result = "No fingerprint captured yet."; 

  @override
  void initState() {
    super.initState();
    final config = FingerprintConfig(licenseKey: 'EHG8-67KT-8R53-BSFI');
    controller = FingerprintController(
      config: config,
      onFingerCapture: (images, error) {
        if (error != null) {
          setState(() {
            result = "Error: $error";
          });
        } else {
          print('onFingerCaptured: ${images[0][0]}');
          setState(() {
            result = "Fingerprint captured: ${images[0][0]}"; 
          });
        }
      },
      onStatusChanged: (FingerprintCaptureState state) {
      },
      onFingerDetected: (List<Rect> fingerRects) {
      },
    );
  }

  void takeFingerprint() async {
    await controller.takeFingerprint();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: const Text('Fingerprint Demo', style: TextStyle(color: Colors.white)),
        iconTheme:const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: takeFingerprint,
                child: const Text('Capture Fingers'),
              ),
              const SizedBox(height: 20), 
              Text(
                'Result: $result', 
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
