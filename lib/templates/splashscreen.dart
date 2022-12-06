




import 'package:app_diario/bloc/blocEmail.dart';
import 'package:app_diario/components/alert_snack.dart';
import 'package:app_diario/templates/home.dart';
import 'package:app_diario/templates/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'tabs/tabConfiguracoes.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  var blocEmail = BlocEmail();
  var id = null;
  //List email = [];
  int status = 1;
  void initState() {
    emailList();
    status = 1;
    super.initState();


  }
  emailList() async {
    List status =  await blocEmail.getEmail();
    print("st");
    print(status.isNotEmpty);
    if(status.isNotEmpty) {
      print("iff");
      print(status);
      if (status[0]['email'] == '' && status[0]['status']! == '0') {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);
      } else if (status[0]['email'] != '' && status[0]['status'] == '1') {
        Navigator.push( context, MaterialPageRoute(builder: (context) => Home()),);
      } else if (status[0]['email'] != '' && status[0]['status'] == '0') {
        Navigator.push( context, MaterialPageRoute(builder: (context) => Login()),);
      }
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:   const [
           CircularProgressIndicator(),
        ],
      ),
    );
  }
}
