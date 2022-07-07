import 'package:phone_verification/main.dart';
import 'package:phone_verification/models/medicament.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:url_launcher/url_launcher.dart';
import 'AjoutMedicament.dart' as ajout;

class ListMedicament extends StatefulWidget {
  const ListMedicament({ Key key }) : super(key: key);

  @override
  _ListMedicament createState() => _ListMedicament();
}

class _ListMedicament extends State<ListMedicament> {

  List<medicament> _docs = [
    medicament('Acarbose', 'glucosidase','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQC7KEMUyN3PP3tz2vVyw6iToPYBzgdfqOd8w&usqp=CAU', false),
    medicament('Diastabol', 'glucosidase ', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQC7KEMUyN3PP3tz2vVyw6iToPYBzgdfqOd8w&usqp=CAU', false),
    medicament('Glucor', 'glucosidase ', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQC7KEMUyN3PP3tz2vVyw6iToPYBzgdfqOd8w&usqp=CAU', false),
    medicament('Eucreas', 'dipeptidyl DPP4 ', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQC7KEMUyN3PP3tz2vVyw6iToPYBzgdfqOd8w&usqp=CAU', false),
    medicament('Galvus', 'dipeptidyl DPP4', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQC7KEMUyN3PP3tz2vVyw6iToPYBzgdfqOd8w&usqp=CAU', false),
    medicament('Janumet','dipeptidyl DPP4', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQC7KEMUyN3PP3tz2vVyw6iToPYBzgdfqOd8w&usqp=CAU', false),
    medicament('Januvia', 'dipeptidyl DPP4', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQC7KEMUyN3PP3tz2vVyw6iToPYBzgdfqOd8w&usqp=CAU', false),
    medicament('Komboglyze', 'dipeptidyl DPP4', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQC7KEMUyN3PP3tz2vVyw6iToPYBzgdfqOd8w&usqp=CAU', false),
    medicament('Onglyza', 'dipeptidyl DPP4', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQC7KEMUyN3PP3tz2vVyw6iToPYBzgdfqOd8w&usqp=CAU', false),
    medicament('Velmetia', 'dipeptidyl DPP4', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQC7KEMUyN3PP3tz2vVyw6iToPYBzgdfqOd8w&usqp=CAU', false)
  ];

  List<medicament> _foundedUsers = [];
  
  void _launchUrl() async {
  const url = "https://medicalis.ma/Guide-m%C3%A9dicaments-maroc";
  if (await canLaunch(url)){await launch(url);}
  else {throw "Could not launch $url"; }
  // can't launch url, there is some error 
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _foundedUsers = _docs;
    });
  }

  onSearch(String search) {
    setState(() {
      _foundedUsers = _docs.where((user) => user.name.toLowerCase().contains(search)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                       context,
                           MaterialPageRoute(builder: (context) => ajout.MyHomePage()),
                  );
          
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 6, 120, 235),
        foregroundColor: Colors.white,
        elevation: 5,
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 2, 2, 2),
        title: Container(
          height: 38,
          child: TextField(
            onChanged: (value) => onSearch(value),
            decoration: InputDecoration(
              filled: true,
              fillColor: Color.fromARGB(255, 244, 242, 242),
              contentPadding: EdgeInsets.all(0),
              prefixIcon: Icon(Icons.search, color: Colors.grey.shade500,),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none
              ),
              hintStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500
              ),
              hintText: "Chercher un Medicament"
            ),
          ),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 255, 255, 255),
        child: _foundedUsers.length > 0 ? ListView.builder(
          itemCount: _foundedUsers.length,
          itemBuilder: (context, index) {
            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              child: userComponent(doc: _foundedUsers[index]),
              actions: <Widget>[
                new IconSlideAction(
                  caption: 'Archive',
                  color: Colors.transparent,
                  icon: Icons.archive,
                  
                  onTap: () => print("archive"),
                ),
                new IconSlideAction(
                  caption: 'Share',
                  color: Colors.transparent,
                  icon: Icons.share,
                  onTap: () => print('Share'),
                ),
              ],
              secondaryActions: <Widget>[
                new IconSlideAction(
                  caption: 'More',
                  color: Colors.transparent,
                  icon: Icons.more_horiz,
                  onTap: () => print('More'),
                ),
                new IconSlideAction(
                  caption: 'Delete',
                  color: Colors.transparent,
                  icon: Icons.delete,
                  onTap: () => print('Delete'),
                ),
              ],
            );
          }) : Center(child: Text("No users found", style: TextStyle(color: Colors.white),)),
      ),
    );
  }

  userComponent({ medicament doc}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(doc.image),
                )
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(doc.name, style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w500)),
                  SizedBox(height: 5,),
                  Text(doc.username, style: TextStyle(color: Colors.grey[500])),
                ]
              )
            ]
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                doc.isFollowedByMe = !doc.isFollowedByMe;      
              });
              _launchUrl();
              
            },
            child: AnimatedContainer(
              height: 35,
              width: 110,
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: doc.isFollowedByMe ? Colors.blue[700] : Color.fromARGB(255, 252, 209, 15),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: doc.isFollowedByMe ? Colors.transparent : Colors.grey.shade700,)
              ),
              child: Center(
                child: Text(doc.isFollowedByMe ? 'Details' : 'Details', style: TextStyle(color: doc.isFollowedByMe ? Colors.white : Colors.white))
              )
            ),
          )
        ],
      ),
    );
  }
}