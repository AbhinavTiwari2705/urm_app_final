import 'package:flutter/material.dart';
import 'package:urm_app/utils/submit_data.dart';
import 'package:urm_app/utils/submitdatatoITM.dart';

class Manual extends StatefulWidget {
  Manual({Key? key}) : super(key: key);

  @override
  State<Manual> createState() => _ManualState();
}

class _ManualState extends State<Manual> {
  TextEditingController heatNoController = TextEditingController();  // Text controller for heat number
  TextEditingController sectionController = TextEditingController(); // Text controller for section
  TextEditingController strandController = TextEditingController();  // Text controller for strand
  TextEditingController dateController = TextEditingController();   // Text controller for date
  TextEditingController timeController = TextEditingController();   // Text controller for time
  TextEditingController gradeController = TextEditingController();  // Text controller for grade

  Future<void> _submitData() async {
    // Get the entered values from text controllers
    String heatNo = heatNoController.text;      // Heat number
    String section = sectionController.text;  // Section
    String strand = strandController.text;  // Strand
    String grade = gradeController.text; // Grade

    // Call the submitData function with the entered values
    bool success = await submitData(heatNo, section, strand, grade); // Date and time are not passed as parameters

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

  // This function is called after successful data submission
  // It sends the data to ITM
  // You can modify this function to send the data to your own server
  // or to perform any other action
  // It is located in lib/utils/submitdatatoITM.dart

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
    //here to give message from the server please pass the message in the showDialog as content

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(success ? 'Success' : 'Failed'),  // This message is displayed in the dialog title
          content: Text(success
              ? 'Data sent to ITM successfully!'  // This message is displayed if the operation is successful
              : 'Failed to send data to ITM. Please try again.'),   // This message is displayed if the operation fails 

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

// This function is called when the submit button is pressed

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
                    _sendDataToITM(); // Send the data to ITM
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
