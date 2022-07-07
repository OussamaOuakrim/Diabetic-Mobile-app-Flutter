import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:phone_verification/SugarTracker/Addmesure.dart';
import 'package:phone_verification/Medicament/ListMedicament.dart';
import 'Profile/Profile.dart';
import 'doctorsView.dart';
import 'Calories/home.dart';

class Menu extends StatelessWidget {
   //const Menu({Key key}) : super(key: key);
   AnimationController animationController;
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        body: Container(
          
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/home.jpg'),
                  
                  
              )
          ),
        
          
        ),
        floatingActionButton: FabCircularMenu(
          ringColor:  Color.fromARGB(255, 119, 207, 239),
          ringWidth: 50,
          fabColor: Color.fromARGB(255, 125, 253, 180),
          fabCloseColor: Color.fromARGB(255, 7, 159, 201),
          children: [
            IconButton(onPressed: () {
              Navigator.push(
                       context,
                           MaterialPageRoute(builder: (context) =>  Menu()),
                  );
              print('home');
            }, icon: Icon(Icons.home)),
            
            IconButton(onPressed: () {
              Navigator.push(
                       context,
                           MaterialPageRoute(builder: (context) =>  Profile()),
                  );
              print('profile');
            }, icon: Icon(Icons.info)),
                  
            IconButton(onPressed: () {
              Navigator.push(
                       context,
                           MaterialPageRoute(builder: (context) => Profile ()),
                  );
              print('Search');
            }, icon: Icon(Icons.perm_identity)),
            IconButton(onPressed: () {
              Navigator.push(
                       context,
                           MaterialPageRoute(builder: (context) => doctorsView ()),
                  );
              print('doctors');
            }, icon: Icon(Icons.search)),
            IconButton(onPressed: () {
              Navigator.push(
                       context,
                           MaterialPageRoute(builder: (context) => Addmesure ()),
                  );
              print('SugarMonitor');
            }, icon: Icon(Icons.medical_services_rounded)),
            IconButton(onPressed: () {
              Navigator.push(
                       context,
                           MaterialPageRoute(builder: (context) => HomePage()),
                  );
              
            }, icon: Icon(Icons.no_meals)),
            
            
          ],
        ),
        
      ),
    );
  }
}
