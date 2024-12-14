import 'package:flutter/material.dart';
import 'package:my_app/views/camera/display_image_view.dart';
import 'package:my_app/views/qr_code/qr_code_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Screen',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[400],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DisplayImageScreen(),
                  ),
                );
              },
              child: const Text('Camera View'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QrCodeView(),
                  ),
                );
              },
              child: const Text('Qr Code Scanner'),
            ),
          ],
        ),
      ),
    );
  }
}
