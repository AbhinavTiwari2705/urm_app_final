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
  MobileScannerController cameraController = MobileScannerController();
  bool _screenOpened = false;
  bool isScanned = false;
  bool useFrontCamera = false;
  bool useFlashlight = false;

  void closeScanner() {
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
                switch (state as TorchState) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
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
                    // useFrontCamera: cameraController.toggleTorch(),
                    // useFlashlight: useFlashlight,
                    onDetect: (barcode, args) {
                      if (!isScanned) {
                        setState(() {
                          isScanned = true;
                          String code = barcode.rawValue ?? "---";
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultScreen(
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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     Text('Front Camera'),
            //     Switch(
            //       value: useFrontCamera,
            //       onChanged: (value) {
            //         setState(() {
            //           useFrontCamera = value;
            //         });
            //       },
            //     ),
            //     Text('Flashlight'),
            //     Switch(
            //       value: useFlashlight,
            //       onChanged: (value) {
            //         setState(() {
            //           useFlashlight = value;
            //         });
            //       },
            //     ),
            //   ],
            // ),
Expanded(
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
                      "Made with ❤️ by C&IT Interns",
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
