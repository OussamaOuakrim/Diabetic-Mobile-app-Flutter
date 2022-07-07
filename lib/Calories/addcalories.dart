import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class addcalories extends StatefulWidget {
  @override
  addcaloriesState createState() => addcaloriesState();
}

class addcaloriesState extends State<addcalories> {
  //const Profile({Key key}) : super(key: key);
  TextEditingController calories = new TextEditingController();
  TextEditingController uid = new TextEditingController();
  TextEditingController day = new TextEditingController();
  
 
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
            image: AssetImage("assets/images/bg6.png"),
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
                controller: calories,
                  decoration: InputDecoration(
                    hintText: "Combien de calories avez vous mangez ?"
                  ),
              ),
              SizedBox(
                height: 50.0,
              ),
              TextFormField(
                controller: day,
                  decoration: InputDecoration(
                    hintText: "Jour"
                  ),
              ),
              SizedBox(
                height: 50.0,
              ),
              
              FlatButton(onPressed:(){
                    FirebaseAuth auth =FirebaseAuth.instance ;
                    String uid = auth.currentUser.uid.toString();
                    Map <String,dynamic> data = {"CaloriesVal":calories.text};
                    FirebaseFirestore.instance.collection("Calories").doc("Juin").collection(uid).doc(day.text).set(data);  
                    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),);           
              }, 
              child: Text("Ajouter vos calories"),
              color: Color.fromARGB(255, 255, 218, 55),
              ),
              SizedBox(
                height: 200.0,
              ),
            ],
          ),
        ), 
      ),
      ),
      
    );
  }
  
}

