// Note: Custom QR Scanner Overlay
// NOT USED


// import 'package:flutter/material.dart';

// class CustomQRScannerOverlay extends StatelessWidget {
//   final Color borderColor;
//   final double borderRadius;
//   final double borderLength;
//   final double borderWidth;
//   final double cutOutSize;

//   CustomQRScannerOverlay({
//     required this.borderColor,
//     required this.borderRadius,
//     required this.borderLength,
//     required this.borderWidth,
//     required this.cutOutSize,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: borderColor,
//           width: borderWidth,
//         ),
//         borderRadius: BorderRadius.circular(borderRadius),
//       ),
//       child: Stack(
//         children: [
//           Positioned(
//             top: 0,
//             left: 0,
//             child: Container(
//               width: cutOutSize,
//               height: borderWidth,
//               color: borderColor,
//             ),
//           ),
//           Positioned(
//             top: 0,
//             left: 0,
//             child: Container(
//               width: borderWidth,
//               height: cutOutSize,
//               color: borderColor,
//             ),
//           ),
//           Positioned(
//             top: 0,
//             right: 0,
//             child: Container(
//               width: borderWidth,
//               height: cutOutSize,
//               color: borderColor,
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             child: Container(
//               width: cutOutSize + borderWidth,
//               height: borderWidth,
//               color: borderColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
