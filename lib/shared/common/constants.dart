import 'package:flutter/material.dart';
import 'package:salla/modules/login/login_screen.dart';
import 'package:salla/shared/network/local/cash_helper.dart';



var noImageFound = 'https://imgs.search.brave.com/XbaLNffXL3D8s_IOdhPMZGMzGsr8RPooQ4_AdB81lv0/rs:fit:400:250:1/g:ce/aHR0cHM6Ly93d3cu/Z210LXNhbGVzLmNv/bS93cC1jb250ZW50/L3VwbG9hZHMvMjAx/NS8xMC9uby1pbWFn/ZS1mb3VuZC5qcGc';

void signOut(context)
{
  CashHelper.removeData(key: 'token').then((value) {
    token = '';
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(
          builder: (context) => LoginScreen() ,
        ), (route) => false);
  });
}

String token = '';

/*
var listview = GlobalKey<ListView>();*/
