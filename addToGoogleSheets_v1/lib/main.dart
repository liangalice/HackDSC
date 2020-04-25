import 'package:flutter/material.dart';
import 'ingredientInfo.dart';
import 'ingredientInfoController.dart';
import 'lib/ingredientInfoController.dart';
import 'package:hello_world/lib/ingredientInfo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' Ingredient Info',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Enter Ingredient Info'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // TextField Controllers
  TextEditingController ingredientController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();
  TextEditingController  totalFatController = TextEditingController();
  TextEditingController sFatController = TextEditingController();
  TextEditingController tFatController = TextEditingController();
  TextEditingController cholesterolController = TextEditingController();
  TextEditingController sodiumController = TextEditingController();
  TextEditingController tCarboController = TextEditingController();
  TextEditingController tSugarController = TextEditingController();
  TextEditingController aSugarController = TextEditingController();

  // Method to Submit Feedback and save it in Google Sheets
  void _submitForm() {
    // Validate returns true if the form is valid, or false
    // otherwise.
    if (_formKey.currentState.validate()) {
      // If the form is valid, proceed.
      FeedbackForm feedbackForm = FeedbackForm(
          ingredientController.text,
          caloriesController.text,
          totalFatController.text,
          sFatController.text,
          tFatController.text,
          cholesterolController.text,
          sodiumController.text,
          tCarboController.text,
          tSugarController.text,
          aSugarController.text
      );

      FormController formController = FormController((String response) {
        print("Response: $response");
        if (response == FormController.STATUS_SUCCESS) {
          // Feedback is saved succesfully in Google Sheets.
          _showSnackbar("Feedback Submitted");
        } else {
          // Error Occurred while saving data in Google Sheets.
          _showSnackbar("Error Occurred!");
        }
      }
      );

      _showSnackbar("Submitting Feedback");

      // Submit 'feedbackForm' and save it in Google Sheets.
      formController.submitForm(feedbackForm);
    }
  }

  // Method to show snackbar with 'message'.
  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Form(
                key: _formKey,
                child:
                Padding(padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: ingredientController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Valid ingredient';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Ingredient'
                        ),
                      ),
                      TextFormField(
                        controller: caloriesController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Valid Calories';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Calories'
                        ),
                      ),
                      TextFormField(
                        controller: totalFatController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Valid Total Fat';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Total Fat'
                        ),
                      ),
                      TextFormField(
                        controller: sFatController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Valid Saturated Fat';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Saturated Fat'
                        ),
                      ),
                      TextFormField(
                        controller: tFatController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Valid Total Fat';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Total Fat'
                        ),
                      ),
                      TextFormField(
                        controller: cholesterolController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Valid Cholesterol';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Cholesterol'
                        ),
                      ),
                      TextFormField(
                        controller: sodiumController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Valid Sodium';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Sodium'
                        ),
                      ),
                      TextFormField(
                        controller: tCarboController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Valid Total Carbohydrates';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Total Carbohydrates'
                        ),
                      ),
                      TextFormField(
                        controller: tSugarController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Valid Total Sugar';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Total Sugar'
                        ),
                      ),
                      TextFormField(
                        controller: aSugarController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Valid Added Sugar';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Added Sugar'
                        ),
                      )



                    ],
                  ),
                )
            ),
            RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              onPressed:_submitForm,
              child: Text('Submit Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}