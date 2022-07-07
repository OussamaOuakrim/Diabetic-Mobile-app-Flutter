import 'package:charts_flutter/flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '/verification.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Phone Authentication',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Phone Authentication'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: Text(widget.title),
        toolbarHeight: 200,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/header.jpg'),
                  fit: BoxFit.fill
              )
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg3.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        //color: Colors.white70,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: phoneNumber,
                decoration: InputDecoration(
                  labelText: 'Phone number',
                  hintText: 'Enter your phone number',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(
                    Icons.phone,
                  ),
                ),
              ),

              SizedBox(height: 10,),

              ElevatedButton(
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)
                        => OTPScreen(phoneNumber.text),
                        ),
                        
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Get OTP"),
                  ),
              ),
            ],
          ),
        ),
      )
         // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

