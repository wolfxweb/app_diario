import 'package:flutter/material.dart';

class AlertSnackBar{

  alertSnackBar(context,cor,msg){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: cor,
    ));
  }

}
