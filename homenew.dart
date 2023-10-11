
import 'package:clinicpharma/signUpmain.dart';
import 'package:clinicpharma/signup.dart';
import 'package:clinicpharma/viewschedule.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'Viewbookingdetails.dart';
import 'changepassword.dart';
import 'home_drawer.dart';
import 'profile main.dart';
import 'sam/login_screen.dart';
import 'sendcomplaint.dart';
import 'viewcart.dart';
import 'viewdoctors.dart';
import 'viewmedicineorder.dart';
import 'viewpharmacy.dart';
import 'viewprescription.dart';
import 'viewreply.dart';
import 'viewtestdetails.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(const HomeNew());
}

class HomeNew extends StatelessWidget {
  const HomeNew({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const HomeNewPage(title: 'Home'),
    );
  }
}

class HomeNewPage extends StatefulWidget {
  const HomeNewPage({super.key, required this.title});

  final String title;

  @override
  State<HomeNewPage> createState() => _HomeNewPageState();
}

class _HomeNewPageState extends State<HomeNewPage> {


  // _HomeNewPageState() {
  //   view_notification();
  // }

  List<String> id_ = <String>[];
  List<String> name_= <String>[];
  List<String> department_= <String>[];
  List<String> gender_= <String>[];
  List<String> place_= <String>[];
  List<String> phone_= <String>[];
  List<String> photo_= <String>[];


  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> name = <String>[];
    List<String> department = <String>[];
    List<String> gender = <String>[];
    List<String> place = <String>[];
    List<String> phone = <String>[];
    List<String> photo = <String>[];


    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String url = '$urls/myapp/user_viewdoctors/';

      var data = await http.post(Uri.parse(url), body: {


      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        name.add(arr[i]['name']);
        department.add(arr[i]['department']);
        gender.add(arr[i]['gender']);
        place.add(arr[i]['place']);
        phone.add(arr[i]['phone']);
        photo.add(urls+ arr[i]['photo']);

      }

      setState(() {
        id_ = id;
        name_ = name;
        department_ = department;
        gender_ = gender;
        place_ = place;
        phone_ = phone;
        photo_ =  photo;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }







  String uname_="";
  String email_="";
  String uphoto_="";


  _HomeNewPageState()
  {

    a();
    view_notification();

  }

  a()
  async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String name = sh.getString('name').toString();
    String email = sh.getString('email').toString();
    String photo = sh.getString('photo').toString();


    setState(() {
      uname_=name;
      email_=email;
      uphoto_=photo;

    });


  }


  TextEditingController unameController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 18, 82, 98),

          title: Text(widget.title),
        ),
        body:
        GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 210,
                childAspectRatio: 10/10,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,

            ),
            padding: const EdgeInsets.all(8.0),

            itemCount: name_.length,
            itemBuilder: (BuildContext ctx, index) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 18, 82, 98),
                    borderRadius: BorderRadius.circular(15)),
                child:  Column(
                    children: [
                      SizedBox(height: 5.0),
                      InkWell(
                        onTap: () async {
                          final pref =await SharedPreferences.getInstance();
                                    pref.setString("did", id_[index]);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ViewSchedule()),);
                                    },
                        child: CircleAvatar(
                        radius: 50,backgroundImage: NetworkImage(photo_[index])),
                        ),
                      // SizedBox(height: 5.0),
                       // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(1),
                            child: Text(name_[index],style: TextStyle(color: Colors.white,fontSize: 18)),
                          ),],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(2),
                            child: Text(department_[index],style: TextStyle(color: Colors.white)),
                          ),],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(1),
                            child: Text(phone_[index],style: TextStyle(color: Colors.white)),
                          ),
                          ],
                      ),
                      //     // Padding(
                      //     //   padding: EdgeInsets.all(5),
                      //     //   child:  ElevatedButton(
                      //     //     onPressed: () async {
                      //     //
                      //     //       final pref =await SharedPreferences.getInstance();
                      //     //       pref.setString("did", id_[index]);
                      //     //
                      //     //       Navigator.push(
                      //     //         context,
                      //     //         MaterialPageRoute(builder: (context) => ViewSchedule()),
                      //     //       );
                      //     //
                      //     //
                      //     //
                      //     //
                      //     //     },
                      //     //     child: Text("Schedule"),
                      //     //   ),
                      //     // ),
                      //   ],
                      // ),

                    ]
                )
              );
            }),

        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
               DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 18, 82, 98),
                ),
                child:
                Column(children: [

                  Text(
                    'CliniSync',
                    style: TextStyle(fontSize: 20,color: Colors.white),

                  ),
                  CircleAvatar(radius: 29,backgroundImage: NetworkImage(uphoto_)),
                  Text(uname_,style: TextStyle(color: Colors.white)),
                  Text(email_,style: TextStyle(color: Colors.white)),



                ])


                ,
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeNew(),));
                },
              ),
              ListTile(
                leading: Icon(Icons.person_pin),
                title: const Text(' View Profile '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyAppProfilr(),));
                },
              ),
              ListTile(
                leading: Icon(Icons.person_pin_outlined),
                title: const Text(' View Doctors '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDoctors(title: "Doctors",),));
                },
              ),
              ListTile(
                leading: Icon(Icons.book_outlined),
                title: const Text(' View Booking Details '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewBookingDetailsPage(title: "Booking Details",),));
                },
              ),
              ListTile(
                leading: Icon(Icons.note_alt_rounded),
                title: const Text(' View Prescription Details '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPrescriptionPage(title: "Prescription Details",),));
                },
              ),
              ListTile(
                leading: Icon(Icons.medical_services_outlined),
                title: const Text(' View Test Details '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewTestDetailsPage(title: "Test Details",),));
                },
              ),


              ListTile(
                leading: Icon(Icons.local_pharmacy),
                title: const Text(' View Pharmacy '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPharmacy(title: "Pharmacy",),));
                },

              ),

              ListTile(
                leading: Icon(Icons.medical_information_outlined),
                title: const Text(' View Medicine Orders '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewMedicineOrderPage(title: "Medicine Order Details",),));
                },
              ),ListTile(
                leading: Icon(Icons.shopping_cart_sharp),
                title: const Text(' View Cart'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewCart(),));
                },
              ),
              ListTile(
                leading: Icon(Icons.feed_outlined),
                title: const Text('Complaint '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewReplyPage(title: "View Complaint",),));
                },
              ),

              ListTile(
                leading: Icon(Icons.change_circle),
                title: const Text(' Change Password '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyChangePasswordPage(title: "Change Password",),));
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: const Text('LogOut'),
                onTap: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                },
              ),
            ],
          ),
        ),





      ),
    );
  }



  void _send_data() async{


    String uname=unameController.text;
    String password=passController.text;


    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/myapp/user_loginpost/');
    try {
      final response = await http.post(urls, body: {
        'name':uname,
        'password':password,


      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          String lid=jsonDecode(response.body)['lid'];
          sh.setString("lid", lid);
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => MyHomePage(title: "Home"),));
        }else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    }
    catch (e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }

}
