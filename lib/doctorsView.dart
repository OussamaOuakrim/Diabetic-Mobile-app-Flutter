import 'models/doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;


class doctorsView extends StatefulWidget {
  const doctorsView({ Key key }) : super(key: key);

  @override
  _doctorsView createState() => _doctorsView();
}
 
class _doctorsView extends State<doctorsView> with TickerProviderStateMixin {

  List<doctor> _docs = [
    doctor('Dr Abdelhak Kamach', 'Diabétologue', 'https://res.cloudinary.com/hh9gnin1v/image/upload/c_thumb,f_auto,g_face,h_115,w_115/v1469627005/57988974641b1b0089000095_photo_1.jpg', false),
    doctor('Dr Sabrine Chtioui', 'Hypnothérapeute', 'https://res.cloudinary.com/hh9gnin1v/image/upload/c_thumb,f_auto,g_face,h_115,w_115/v1585647572/58a6309e65809f0012780537_photo_1.jpg', false),
    doctor('Mohamed Adahchour', 'Nutritionniste', 'https://res.cloudinary.com/hh9gnin1v/image/upload/c_thumb,f_auto,g_face,h_115,w_115/v1651271502/5de0d60df3650e003774c98a_photo_1.jpg', false),
    doctor('Dr Ahmed Khalfi', 'Généraliste', 'https://res.cloudinary.com/hh9gnin1v/image/upload/c_thumb,f_auto,g_face,h_115,w_115/v1639391743/61b3c0f419866e00329a02d9_photo_1.png', false),
    doctor('Dr Kanza Benomar', 'Endocrinologue', 'https://res.cloudinary.com/hh9gnin1v/image/upload/c_thumb,f_auto,g_face,h_115,w_115/v1638434686/5aaaea274578b300045fe6a8_photo_1.png', false),
    doctor('Dr Khalifa Farah', 'Généraliste', 'https://res.cloudinary.com/hh9gnin1v/image/upload/c_thumb,f_auto,g_face,h_115,w_115/v1551285699/5aaade694578b300045fcf41_photo_1.jpg', false),
    doctor('Dr Latifa Boulmane', 'Diabétologue', 'https://res.cloudinary.com/hh9gnin1v/image/upload/c_thumb,f_auto,g_face,h_115,w_115/v1577373078/5253e1fbf8aa1e2b71000003_photo_1.jpg', false),
    doctor('Dr Nadia Anoun', 'Nutritionniste', 'https://res.cloudinary.com/hh9gnin1v/image/upload/c_thumb,f_auto,g_face,h_115,w_115/v1650677665/61a0e131d0ab3b0036f5384f_photo_1.jpg', false),
    doctor('Dr Khaled Dembri', 'Diabétologue', 'https://res.cloudinary.com/hh9gnin1v/image/upload/c_thumb,f_auto,g_face,h_115,w_115/v1580826033/5682ec67c1df690088000003_photo_1.jpg', false),
    doctor('Dr Mossadek Mrabt', 'Urgentiste', 'https://res.cloudinary.com/hh9gnin1v/image/upload/c_thumb,f_auto,g_face,h_115,w_115/v1615152680/5aaae3cd4578b300045fda9a_photo_1.jpg', false)
  ];

  List<doctor> _foundedUsers = [];
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade900,
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
              hintText: "Chercher un Medecin"
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.grey.shade900,
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

  userComponent({ doctor doc}) {
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
                  Text(doc.name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
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
              UrlLauncher.launch("tel://+212522988880");
            },
            child: AnimatedContainer(
              height: 35,
              width: 110,
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: doc.isFollowedByMe ? Colors.blue[700] : Color.fromARGB(255, 2, 180, 61),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: doc.isFollowedByMe ? Colors.transparent : Colors.grey.shade700,)
              ),
              child: Center(
                child: Text(doc.isFollowedByMe ? 'Appeler' : 'Appeler', style: TextStyle(color: doc.isFollowedByMe ? Colors.white : Colors.white))
              )
            ),
          )
        ],
      ),
    );
  }
}