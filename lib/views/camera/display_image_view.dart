import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DisplayImageScreen extends StatefulWidget {
  const DisplayImageScreen({Key? key}) : super(key: key);

  @override
  _DisplayImageScreenState createState() => _DisplayImageScreenState();
}

class _DisplayImageScreenState extends State<DisplayImageScreen> {
  String? base64String;
  bool isLoading = false;
  File? imageFile;

  @override
  void initState() {
    super.initState();
  }

  Future<void> loadBase64String(String imagePath) async {
    setState(() {
      isLoading = true;
    });

    List<int> imageBytes = await File(imagePath).readAsBytes();
    String encoded = base64Encode(imageBytes);
    setState(() {
      base64String = encoded;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Captured Image', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[400],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) 
          : SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            final ImagePicker picker = ImagePicker();
                            final XFile? image = await picker.pickImage(source: ImageSource.camera);
                                          
                            if (image != null) {
                              setState(() {
                                imageFile = File(image.path);
                              });
                              loadBase64String(image.path);
                            }
                          },
                          child: const Text('Open Camera'),
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (imageFile != null)
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          margin: const EdgeInsets.only(top: 20),
                          height: 400,
                          child: ClipRect(
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Image.file(
                                imageFile!,
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 400,
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 40),
                      const Text('Base 64 Code:',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text(
                          base64String ?? 'No data',
                          style: const TextStyle(fontSize: 12),
                          maxLines: 8,
                          overflow: TextOverflow.ellipsis, 
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
