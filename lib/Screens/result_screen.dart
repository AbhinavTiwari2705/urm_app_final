import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:urm_app/widget/common_drawer.dart';
import 'package:urm_app/utils/submitdatatoITM.dart';

class ResultScreen extends StatelessWidget {
  final String code;
  final Function() closeScreen;
  String heatNo = '1';
  String section = '2';
  String strand = '3';
  String date = '4';
  String time = '5';
  String grade = '6';

  Map<String, String> convertToMap(String input) {
    String outputCode = input.replaceAllMapped(
      RegExp(r'GRADE-([^;]+)'),
      (Match match) => 'GRADE-${match[1]?.replaceAll('-', '_') ?? ""}',
    );

    List<String> pairs = outputCode.split(';');
    Map<String, String> resultMap = {};

    for (String pair in pairs) {
      List<String> keyValue = pair.split('-');
      if (keyValue.length == 2) {
        String key = keyValue[0].trim();
        String value = keyValue[1].trim();
        resultMap[key] = value;

        // Debug print for each key-value pair
        print('Parsed: $key - $value');
      }
    }

    print('Result Map: $resultMap');

    heatNo = resultMap["HEAT NO"] ?? "N/A";
    section = resultMap["SECTION"] ?? "N/A";
    strand = resultMap["STRAND"] ?? "N/A";
    date = resultMap["DATE"] ?? "N/A";
    time = resultMap["TIME"] ?? "N/A";

    // Extracting the grade value by combining "GRADE-" with the actual grade value
    grade = resultMap.entries
        .firstWhere((entry) => entry.key.startsWith("GRADE"),
            orElse: () => MapEntry("GRADE", "N/A"))
        .value;

    print(code);

    return resultMap;
  }

  Future<void> submitData() async {
    final Uri apiUrl = Uri.parse(
        "https://bspapp.sail-bhilaisteel.com/MES_MOB/APP/BloomReceipt.jsp");

    final Map<String, dynamic> data = {
      // 'code': code,
      'heatNo': heatNo,
      'section': section,
      'strand': strand,
      'grade': grade,
    };
    print('Original data: $data');

    // Add the data to the URL+----a
    final Uri uriWithParams = apiUrl.replace(
      queryParameters:
          data.map((key, value) => MapEntry(key, value.toString())),
    );
    print('Generated URI: $uriWithParams');

    try {
      final http.Response response = await http.post(
        uriWithParams,
        headers: {'Content-Type': 'application/json'},
      );

      // Process the response here
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        print('API call successful');
        // Additional logging to check if data is sent successfully
        print('Data sent to the server: $data');
      } else {
        print('API call failed with status code ${response.statusCode}');
      }
    } catch (e) {
      // Handle the exception
      print("Error: $e");
    }
  }

  DataTable buildDataTable(Map<String, String> data) {
    List<DataRow> rows = [];

    data.forEach((key, value) {
      rows.add(
        DataRow(
          cells: [
            DataCell(Text(key)),
            DataCell(Text(value)),
          ],
        ),
      );
    });

    return DataTable(
      columns: [
        DataColumn(label: Text('Key')),
        DataColumn(label: Text('Value')),
      ],
      rows: rows,
    );
  }

  ResultScreen({
    Key? key,
    required this.closeScreen,
    required this.code,
    this.heatNo = '1',
    this.section = '2',
    this.strand = '3',
    this.date = '4',
    this.time = '5',
    this.grade = '6',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, String> result = convertToMap(code);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            closeScreen();
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('R E S U L T'),
        backgroundColor: Colors.blue,
      ),
      drawer: CommonDrawer(),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            QrImageView(
              data: code,
              size: 200,
              version: QrVersions.auto,
            ),
            Text(
              'Scanned Result',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                letterSpacing: 1,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              height: 20,
              child: Text("The scanned result is displayed below:"),
            ),
            buildDataTable(result),
            SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              height: 40,
              child: Container(
                child: ElevatedButton(
                  onPressed: () {
                    submitDataAsync(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> submitDataAsync(BuildContext context) async {
    try {
      // Show a loading indicator while submitting data
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Submitting data...'),
        ),
      );

      await submitData();

      // Call sendDataToITM after successful data submission
      sendDataToITM(heatNo,strand,section,grade); // Make sure to implement this function

      // Show a success message after data submission
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data submitted successfully'),
        ),
      );
    } catch (e) {
      // Handle any errors that occur during data submission
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error submitting data: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
