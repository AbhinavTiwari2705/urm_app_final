import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:urm_app/widget/common_drawer.dart';
import 'package:urm_app/utils/submitdatatoITM.dart';


//
class ResultScreen extends StatelessWidget {

  //
  final String code;
  final Function() closeScreen; // Function to close the screen
  String heatNo = '1';        // defining Heat number
  String section = '2';       // defining section
  String strand = '3';        // defining strand
  String date = '4';          // defining date
  String time = '5';          // defining time
  String grade = '6';         // defining grade

  Map<String, String> convertToMap(String input) {
    // using this function to convert the scanned data into a map
    // Replace all occurrences of "GRADE-" with "GRADE_" to avoid issues with RegExp

    String outputCode = input.replaceAllMapped(
      RegExp(r'GRADE-([^;]+)'),
      (Match match) => 'GRADE-${match[1]?.replaceAll('-', '_') ?? ""}', // Replace "-" with "_"
    );

    List<String> pairs = outputCode.split(';'); // Split the string by ";"
    Map<String, String> resultMap = {}; // Create an empty map

    for (String pair in pairs) {
      List<String> keyValue = pair.split('-'); // Split each pair by "-"
      if (keyValue.length == 2) {
        String key = keyValue[0].trim();   // Trim the key
        String value = keyValue[1].trim();  // Trim the value
        resultMap[key] = value;

        // Debug print for each key-value pair remove this in production
        print('Parsed: $key - $value');
      }
    }

    print('Result Map: $resultMap');  // Debug print for the result map remove this in production

    heatNo = resultMap["HEAT NO"] ?? "N/A";   // Extracting the heat number
    section = resultMap["SECTION"] ?? "N/A";// Extracting the section
    strand = resultMap["STRAND"] ?? "N/A";// Extracting the strand
    date = resultMap["DATE"] ?? "N/A";// Extracting the date
    time = resultMap["TIME"] ?? "N/A";// Extracting the time

    // Extracting the grade value by combining "GRADE-" with the actual grade value
    grade = resultMap.entries
        .firstWhere((entry) => entry.key.startsWith("GRADE"),
            orElse: () => MapEntry("GRADE", "N/A"))
        .value;

    print(code);  // Debug print for the scanned code remove this in production

    return resultMap;
  }
    // This Function is also present at lib/utils/submit_data.dart
  Future<void> submitData() async {
    final Uri apiUrl = Uri.parse(
        "https://bspapp.sail-bhilaisteel.com/MES_MOB/APP/BloomReceipt.jsp");      // API URL

    final Map<String, dynamic> data = {
      // 'code': code,
      'heatNo': heatNo,// Heat number
      'section': section,// Section
      'strand': strand,// Strand
      'grade': grade,// Grade
    };
    print('Original data: $data'); // Debug print for the original data remove this in production

    // Add the data to the URL+----a
    final Uri uriWithParams = apiUrl.replace(
      queryParameters:
          data.map((key, value) => MapEntry(key, value.toString())),
    );
    print('Generated URI: $uriWithParams');// Debug print for the generated URI remove this in production

    try {
      final http.Response response = await http.post(
        uriWithParams,
        headers: {'Content-Type': 'application/json'},// Setting the content type to JSON
      );

      // Process the response here
      // You can also use the response to check if the data was submitted successfully
      
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
  //
  DataTable buildDataTable(Map<String, String> data) {

    // This function is used to build the data table


    List<DataRow> rows = []; // List of data rows

    //

    data.forEach((key, value) {// Loop through the map to create data rows
      rows.add(
        DataRow(
          cells: [
            DataCell(Text(key)),
            DataCell(Text(value)),
          ],
        ),
      );
    });

    return DataTable(// Return the data table
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
