import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const String myhomepageRoute = '/';
const String myprofileRoute = 'profile';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case myhomepageRoute:
        return MaterialPageRoute(builder: (_) => const MyHomePage());
      case myprofileRoute:
        return MaterialPageRoute(builder: (_) => MyProfilePage());
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(child: Text('404 Not found')),
                ));
    }
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  String firstName = "";
  String lastName = "";
  String bodyTemp = "";
  var measure;

  void _submit() {
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user can tap anywhere to close the pop up
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Your information has been submitted'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text("Full name:",
                        style: TextStyle(fontWeight: FontWeight.w700))),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(firstName + " " + lastName),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text("Body Temperature:",
                        style: TextStyle(fontWeight: FontWeight.w700))),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("$bodyTemp ${measure == 1 ? "ºC" : "ºF"}"),
                )
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.grey,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  child: const Text('Go to profile'),
                  onPressed: () async {
                    FocusScope.of(context)
                        .unfocus(); // unfocus last selected input field
                    Navigator.pop(context);
                    await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MyProfilePage())) // Open my profile
                        .then((_) => _formKey.currentState
                            ?.reset()); // Empty the form fields
                    setState(() {});
                  }, // so the alert dialog is closed when navigating back to main page
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    FocusScope.of(context)
                        .unfocus(); // Unfocus the last selected input field
                    _formKey.currentState?.reset(); // Empty the form fields
                  },
                )
              ],
            )
          ],
        );
      },
    );
  }
  TextEditingController dateinput = TextEditingController(); 
  //text editing controller for text field
  
  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Entrez vos repas et calories"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle, size: 32.0),
            tooltip: 'Profile',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyProfilePage(),
                  ));
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg2.jpg"),
            fit: BoxFit.fill,
          ),
        ),
      child:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Align(
              alignment: Alignment.topCenter,
              child: Text("Calories form",
                  style: TextStyle(
                    fontSize: 24,
                  )),
            ),
            const SizedBox(
              height: 40,
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  /*TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'First Name',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        border: OutlineInputBorder()),
                    onFieldSubmitted: (value) {
                      setState(() {
                        firstName = value.capitalize();
                        // firstNameList.add(firstName);
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        firstName = value.capitalize();
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 3) {
                        return 'First Name must contain at least 3 characters';
                      } else if (value.contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                        return 'First Name cannot contain special characters';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  */
                  TextField(
                controller: dateinput, //editing controller of this TextField
                decoration: InputDecoration( 
                   icon: Icon(Icons.calendar_today), //icon of text field
                   labelText: "Enter Date" //label text of field
                ),
                readOnly: true,  //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );
                  
                  if(pickedDate != null ){
                      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
                      print(formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                         dateinput.text = formattedDate; //set output date to TextField value. 
                      });
                  }else{
                      print("Date is not selected");
                  }
                },
             ),
             const SizedBox(
              height: 20,
            ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Last Name',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 3) {
                        return 'Last Name must contain at least 3 characters';
                      } else if (value.contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                        return 'Last Name cannot contain special characters';
                      }
                    },
                    onFieldSubmitted: (value) {
                      setState(() {
                        lastName = value.capitalize();
                        // lastNameList.add(lastName);
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        lastName = value.capitalize();
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Calories',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.contains(RegExp(r'^[a-zA-Z\-]'))) {
                        return 'Use only numbers!';
                      }
                    },
                    onFieldSubmitted: (value) {
                      setState(() {
                        bodyTemp = value;
                        // bodyTempList.add(bodyTemp);
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        bodyTemp = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder()),
                      items: [
                        const DropdownMenuItem(
                          child: Text("cal"),
                          value: 1,
                        ),
                        const DropdownMenuItem(
                          child: Text("Kcal"),
                          value: 2,
                        )
                      ],
                      hint: const Text("Select item"),
                      onChanged: (value) {
                        setState(() {
                          measure = value;
                          // measureList.add(measure);
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          measure = value;
                        });
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(60)),
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (!_formKey.currentState.validate()) {
                        _submit();
                      }
                    },
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
      
      
    );
  }
}

class MyProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            const Text("New data",
                style: TextStyle(
                  fontSize: 24,
                )),
            const Spacer(),
            ElevatedButton(
              child: const Text('New'),
              onPressed: () => Navigator.pop(context),
            )
          ]), 
        ]),
      ),
    );
  }
}

extension StringExtension on String {
  // Method used for capitalizing the input from the form
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}