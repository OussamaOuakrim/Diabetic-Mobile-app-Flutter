import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:phone_verification/Medicament/NotificationService.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;



class MyHomePage extends StatefulWidget {
const MyHomePage({Key key,  this.title}) : super(key: key);

final String title;

@override
_MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
TextEditingController Notification_title = TextEditingController();
TextEditingController Notification_descrp = TextEditingController();

@override
void initState() {
	super.initState();
	tz.initializeTimeZones();
}

@override
Widget build(BuildContext context) {
	
	return Scaffold(
	appBar: AppBar(
        
        toolbarHeight: 150,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/header.jpg'),
                  fit: BoxFit.fill
              )
          ),
        ),
      ),
	body:Container( 
    decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg5.png"),
            fit: BoxFit.fill,
          ),
        ),
  child:Center(
		child: Column(
		mainAxisAlignment: MainAxisAlignment.center,
		children: [
			Text("Programmer vos rappels "),
			Padding(
			padding: EdgeInsets.all(20),
			child: TextField(
				controller: Notification_title,
				decoration: InputDecoration(
				border: OutlineInputBorder(),
				labelText: "Enter Title",
				),
			),
			),
			Padding(
			padding: EdgeInsets.all(20),
			child: TextField(
				controller: Notification_descrp,
				decoration: InputDecoration(
				border: OutlineInputBorder(),
				labelText: "Enter Description",
				),
			),
			),
			Padding(
			padding: EdgeInsets.all(20),
			child: GestureDetector(
				onTap: () {
				NotificationService().showNotification(
					1, Notification_title.text, Notification_descrp.text);
				},
				child: Container(
				height: 40,
				width: 200,
				color: Colors.green,
				child: Center(
					child: Text(
					"Show Notification",
					style: TextStyle(color: Colors.white),
					),
				),
				),
			),
			),
		],
		),
	),
  ),
	);
}
}
