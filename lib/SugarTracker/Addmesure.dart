import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phone_verification/Medicament/ListMedicament.dart';
import 'package:phone_verification/SugarTracker/HomePageChart.dart';
import 'package:phone_verification/Menu.dart';



class Addmesure extends StatefulWidget {
  @override
  AddmesureState createState() => AddmesureState();
}

class AddmesureState extends State<Addmesure> {
  //const Profile({Key key}) : super(key: key);
  TextEditingController mesure = new TextEditingController();
  TextEditingController uid = new TextEditingController();
  TextEditingController day = new TextEditingController();
  
  List<Widget> _items = [
    Text(
    'Index 0: Home',
    ),
    Text(
      'Index 1: SugarVal',
    ),
    Text(
      'Index 2: Chart',
    ),
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget widget = Container(); // default  
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Monitor Your Sugar ',style:TextStyle(color: Color.fromARGB(255, 2, 50, 92))),
        toolbarHeight: 100,
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
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child:SingleChildScrollView (
        padding: EdgeInsets.all(40.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50.0,
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: mesure,
                  decoration: InputDecoration(
                    hintText: "Mesure"
                  ),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: day,
                  decoration: InputDecoration(
                    hintText: "Jour"
                  ),
              ),
              SizedBox(
                height: 30.0,
              ),
              
              FlatButton(onPressed:(){
                    FirebaseAuth auth =FirebaseAuth.instance ;
                    String uid = auth.currentUser.uid.toString();
                    Map <String,dynamic> data = {"SugarVal":mesure.text};
                    FirebaseFirestore.instance.collection("Sugar").doc("Juin").collection(uid).doc(day.text).set(data);  
                    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),);           
              }, 
              child: Text("Add Mesure"),
              color: Color.fromARGB(255, 255, 218, 55),
              ),
              SizedBox(
                height: 180.0,
              ),
            ],
          ),
        ), 
      ),
      
      ),
      bottomNavigationBar: BottomNavigationBar(
        
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_rounded),
            label: 'Medicaments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_device_information),
            label: 'Show Chart',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 3, 61, 105),
        unselectedItemColor: Color.fromARGB(255, 115, 124, 151),
        onTap: _onTap,
      ),
    );
  }
  void _onTap(int index)
  {
     
    if(index==0){
       Navigator.push(context, MaterialPageRoute(builder: (context) =>  ListMedicament()),
                  );
    }
    else if (index==1){
       Navigator.push(context,MaterialPageRoute(builder :(context) => Addmesure()),);
    }
    else{
     Navigator.push(context,MaterialPageRoute(builder: (context) => HomePageChart(),) );
    }
  }
}

