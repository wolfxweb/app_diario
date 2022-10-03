




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
  List email = [];
  int status = 1;
  void initState() {
    super.initState();
    status = 1;
    emailList();
  }
  emailList() async {
    email = await blocEmail.getEmail();
    if(email.isNotEmpty){
      email.forEach((element) {
        setState(() {
          if(element['id'] != 0){
            status = int.parse(element['status']);
            if(status == 0){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  Login()),
              );
            }else{
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  TabConfiguracoes()),
              );
            }
          }
        });
      });
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  Home()),);
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
