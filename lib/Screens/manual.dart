import 'package:flutter/material.dart';
import 'package:urm_app/utils/submit_data.dart';
import 'package:urm_app/utils/submitdatatoITM.dart';

class Manual extends StatefulWidget {
  Manual({Key? key}) : super(key: key);

  @override
  State<Manual> createState() => _ManualState();
}

class _ManualState extends State<Manual> {
  TextEditingController heatNoController = TextEditingController();
  TextEditingController sectionController = TextEditingController();
  TextEditingController strandController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController gradeController = TextEditingController();

  Future<void> _submitData() async {
    // Get the entered values from text controllers
    String heatNo = heatNoController.text;
    String section = sectionController.text;
    String strand = strandController.text;
    String grade = gradeController.text;

    // Call the submitData function with the entered values
    bool success = await submitData(heatNo, section, strand, grade);

    // Show a dialog based on the success or failure of the operation
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(success ? 'Success' : 'Failed'),
          content: Text(success
              ? 'Data submitted successfully!'
              : 'Failed to submit data. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _sendDataToITM() async {
    // Get the entered values from text controllers
    String heatNo = heatNoController.text;
    String section = sectionController.text;
    String strand = strandController.text;
    String date = dateController.text;
    // String time = timeController.text;

    // Call the sendDataToITM function with the entered values
    bool success = await sendDataToITM(heatNo, section, strand, date);

    // Show a dialog based on the success or failure of the operation
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(success ? 'Success' : 'Failed'),
          content: Text(success
              ? 'Data sent to ITM successfully!'
              : 'Failed to send data to ITM. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('M A N U A L'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: heatNoController,
                decoration: InputDecoration(labelText: 'Heat Number'),
              ),
              TextField(
                controller: sectionController,
                decoration: InputDecoration(labelText: 'Section'),
              ),
              TextField(
                controller: strandController,
                decoration: InputDecoration(labelText: 'Strand'),
              ),
              TextField(
                controller: gradeController,
                decoration: InputDecoration(labelText: 'Grade'),
              ),
              TextField(
                controller: dateController,
                decoration: InputDecoration(labelText: 'Date'),
              ),
              TextField(
                controller: timeController,
                decoration: InputDecoration(labelText: 'Time'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _submitData().then((_) {
                    // Additional UI updates or actions after data submission
                    _sendDataToITM();
                  });
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
