import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:urm_app/Screens/result_screen.dart';
import 'package:urm_app/widget/common_drawer.dart';
// import 'package:urm_app/widget/qr_scanner_overlay.dart';
// import 'package:urm_app/Screens/signin_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MobileScannerController cameraController = MobileScannerController(); // MobileScannerController
  bool _screenOpened = false; // Flag to check if the result screen is opened
  bool isScanned = false;  // Flag to check if the QR code is scanned
  bool useFrontCamera = false; // Flag to check if the front camera is used
  bool useFlashlight = false;// Flag to check if the flashlight is used

  void closeScanner() {   // Function to close the scanner
    setState(() {
      isScanned = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('H O M E'),
        backgroundColor: Colors.blue,
        actions: [IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state as TorchState) {  // Switch case to toggle the torch
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey); // Torch off
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow); // Torch on
                }
              },
            ),
            iconSize: 32.0,   // Icon size
            onPressed: () => cameraController.toggleTorch(),// Toggle torch
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState, // Switch case to toggle the camera
              builder: (context, state, child) {
                switch (state as CameraFacing) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      drawer: CommonDrawer(),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Place The Qr Code Here",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Scanning will start automatically",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                letterSpacing: 1,
              ),
            ),
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  MobileScanner(
                    allowDuplicates: true,
                    // useFrontCamera: cameraController.toggleTorch(),     //These functions are depricated in MobileScanner Module
                    // useFlashlight: useFlashlight,
                    onDetect: (barcode, args) {
                      if (!isScanned) {
                        setState(() {
                          isScanned = true;
                          String code = barcode.rawValue ?? "---";   // QR code value
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultScreen(   // Navigate to the result screen
                                closeScreen: closeScanner,
                                code: code,
                              ),
                            ),
                          );
                        });
                      }
                    },
                  ),
                  // CustomQRScannerOverlay(
                  //   borderColor: Colors.blue,
                  //   borderRadius: 10,
                  //   borderLength: 30,
                  //   borderWidth: 10,
                  //   cutOutSize: 300,
                  // ),
                ],
              ),
            ),
            Expanded(                   // Expanded widget to increase the space between the scanner and the button
              child: Container(
                color: Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20), // Increases space above the button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/manual');
                      },
                      child: Container(
                        height: 60, //  height for the button
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          'Enter Manually',
                          style: TextStyle(
                            fontSize: 18, // Set the desired font size
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary:
                            Colors.blue, // Change the button color as needed
                      ),
                    ),
                    SizedBox(height: 20), // Increased space below the button
                    Text(
                      "Made with ❤️ by C&IT Interns",    // Text below the button  :)
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 8, 0, 0),
                      ),
                    ),
                  ],
                ),
              ),
            ),



          ],
        ),
      ),
    );
  }
}
