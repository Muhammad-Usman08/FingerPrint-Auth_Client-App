import 'dart:typed_data';
import 'dart:convert';
import 'package:crypto/crypto.dart'; // For hashing
import 'package:archive/archive.dart'; // For GZIP compression
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
          isLoading = false; // Stop loader after capture
        });

        if (error != null) {
          setState(() {
            result = "Error: $error";
          });
        } else {
          try {
            // Convert the first image into a hash
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

  /// Compress the fingerprint data using GZIP and generate a hash
  Future<String> _convertToHash(Uint8List image) async {
    try {
      // Compress the image data
      final compressedData = GZipEncoder().encode(image);
      if (compressedData == null) throw Exception("Compression failed");

      // Generate a hash of the compressed data
      final hash = sha256.convert(Uint8List.fromList(compressedData));
      return hash.toString(); // Return hash as a hexadecimal string
    } catch (e) {
      throw Exception("Error during conversion: $e");
    }
  }

  /// Trigger fingerprint capture
  void takeFingerprint() async {
    setState(() {
      isLoading = true; // Start loader before capture
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
            ? const CircularProgressIndicator() // Show loader during scanning
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
