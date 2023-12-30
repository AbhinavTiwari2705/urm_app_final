import 'package:http/http.dart' as http;

// This is the function that sends the data to the ITM server
// It is called from lib/Screens/manual.dart
// It is called from lib/Screens/home_screen.dart




final Uri apiUrl = Uri.parse(
    "https://bspapp.sail-bhilaisteel.com/MES_MOB/APP/bloomInfo.jsp");

Future<bool> sendDataToITM(
    String heatNo, String section, String strand, String grade) async {
  final Map<String, dynamic> data = {
    'heatNo': heatNo,
    'section': section,
    'strand': strand,
    'grade': grade,
  };
  print('Original data: $data');

  final Uri uriWithParams = apiUrl.replace(
    queryParameters: data.map((key, value) => MapEntry(key, value.toString())), // this converts the data to string
  );
  print('Generated URI: $uriWithParams');

  try {
    final http.Response response = await http.post(
      uriWithParams,
      headers: {'Content-Type': 'application/json'},
    );

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      print('API call successful');
      print('Data sent to the server: $data');
      return true;
    } else {
      print('API call failed with status code ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print("Error: $e");
    return false;
  }
}
