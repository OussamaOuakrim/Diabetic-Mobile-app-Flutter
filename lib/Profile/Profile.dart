import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phone_verification/Menu.dart';

import 'UserProfile.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  //const Profile({Key key}) : super(key: key);
  TextEditingController name = new TextEditingController();
  TextEditingController uid = new TextEditingController();
  TextEditingController age = new TextEditingController();
  TextEditingController height = new TextEditingController();
  TextEditingController weight = new TextEditingController();
  TextEditingController bloodtype = new TextEditingController();
  List<Widget> _items = [
    Text(
    'Index 0: Home',
    ),
    Text(
      'Index 1: Profile',
    ),
    Text(
      'Index 2: Data',
    ),
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    
    Widget widget = Container(); // default  
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to your profile ',style:TextStyle(color: Color.fromARGB(255, 2, 50, 92))),
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
      body: 
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg3.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child:SingleChildScrollView (
        padding: EdgeInsets.all(40.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30.0,
              ),
              TextFormField(
                controller: name,
                  decoration: InputDecoration(
                    hintText: "Nom Prenom"
                  ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: age,
                  decoration: InputDecoration(
                    hintText: "Age"
                  ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: height,
                  decoration: InputDecoration(
                    hintText: "Taille"
                  ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: weight,
                  decoration: InputDecoration(
                    hintText: "Poids"
                  ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: bloodtype,
                  decoration: InputDecoration(
                    hintText: "Type de sang"
                  ),
              ),
              SizedBox(
                height: 30.0,
              ),
              FlatButton(onPressed:(){
                    FirebaseAuth auth =FirebaseAuth.instance ;
                    String uid = auth.currentUser.uid.toString();
                    Map <String,dynamic> data = {"nom":name.text,"age":age.text,"uid":uid,"taille":height.text,"poids":weight.text,"type de sang":bloodtype.text};
                    FirebaseFirestore.instance.collection("user").doc(uid).set(data);  
                    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),);           
              }, 
              child: Text("Submit"),
              color: Colors.blueAccent,
              ),
              SizedBox(
                height: 50.0,
              ),
            ],
          ),
        ), 
      ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_device_information),
            label: 'Show user data',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 109, 237, 188),
        unselectedItemColor: Color.fromARGB(255, 0, 0, 0),
        onTap: _onTap,
      ),
    );
  }
  void _onTap(int index)
  {
     
    if(index==0){
       Navigator.push(context, MaterialPageRoute(builder: (context) =>  Menu()),
                  );
    }
    else if (index==1){
       Navigator.push(context,MaterialPageRoute(builder :(context) => Profile()),);
    }
    else{
     Navigator.push(context,MaterialPageRoute(builder: (context) => UserProfile(),) );
    }
  }
}

