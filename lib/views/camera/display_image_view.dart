import 'dart:typed_data';
import 'package:crypto/crypto.dart'; 
import 'package:archive/archive.dart';
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
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    final config = FingerprintConfig(licenseKey: 'EHG8-67KT-8R53-BSFI');
    controller = FingerprintController(
      config: config,
      onFingerCapture: (images, error) async {
        setState(() {
          isLoading = false;
        });

        if (error != null) {
          setState(() {
            result = "Error: $error";
          });
        } else {
          try {
            final hash = await _convertToHash(images[0]);
            setState(() {
              result = "Fingerprint captured: $hash";
            });
          } catch (e) {
            setState(() {
              result = "Error converting to hash: $e";
            });
          }
        }
      },
      onStatusChanged: (FingerprintCaptureState state) {},
      onFingerDetected: (List<Rect> fingerRects) {},
    );
  }

  Future<String> _convertToHash(Uint8List image) async {
    try {
      final compressedData = GZipEncoder().encode(image);
      if (compressedData == null) throw Exception("Compression failed");

      final hash = sha256.convert(Uint8List.fromList(compressedData));
      return hash.toString(); 
    } catch (e) {
      throw Exception("Error during conversion: $e");
    }
  }

  void takeFingerprint() async {
    setState(() {
      isLoading = true; 
    });
    await controller.takeFingerprint();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: const Text('Fingerprint Demo', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator() 
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: takeFingerprint,
                      child: const Text('Capture Fingerprint'),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        result ?? "",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
