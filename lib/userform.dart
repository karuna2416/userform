import 'package:flutter/material.dart';
import 'package:submissionform/userdetailsscreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:submissionform/provider/apidata.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:submissionform/str.dart';

import 'dart:io';
class Userform extends StatefulWidget {
  const Userform({super.key});

  @override
  State<Userform> createState() => _UserformState();
}

class _UserformState extends State<Userform> {
  var globalkey=GlobalKey<FormState>();
 var name='';
 var sname='';
 var email='';
 var address='';
 var password='';
  // final intl=DateFormat.yMd();
  DateTime?selecteddate;
void setvalidate()async{
  if(globalkey.currentState!.validate()) {
    globalkey.currentState!.save();

    // ref.read(apidataprovider.notifier).postdata
    //   (objmap
    //       );
    var url=Uri.https('flutter-b377b-default-rtdb.firebaseio.com','/user.json');
    final res= await http.post(url,
        headers:{'Content-Type':'application/json'} ,
        body: json.encode(
          {
          'name':name,
          'sname':sname,
          'email':email,
          'address':address,
          'date':selecteddate.toString(),
          'password':password,}
        ));
    print(res.body);
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
      return
          Userdetailsscreen();
    }));
  }
}
  void showdate()async
  {
    final now=DateTime.now();
    final firstDate=DateTime(now.year-1,now.month,now.day);
    final pickdate=await showDatePicker(context: context, initialDate: now, firstDate: firstDate, lastDate: now);
    setState(() {
      selecteddate=pickdate;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registeration form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
        key: globalkey,
          child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
         TextFormField(
   decoration: InputDecoration(
     label: Text('FirstName'),

   ),
  validator: (value){
    if(value==null||value.trim().length<=3||value.trim().length>10)
    {
    return 'name should be gretter than 3 characters';
    }
    return null;
    },
    onSaved: (value)
    {
    name=value!;
    },

),
              TextFormField(
                decoration: InputDecoration(
                  label: Text('LastName'),

                ),
                validator: (value){
    if(value==null||value.trim().length<=3||value.trim().length>10)
    {
    return 'lastname should be gretter than 3 characters';
    }
    return null;
    },
    onSaved: (value)
    {
    sname=value!;
    },

              ),
              TextFormField(
                decoration: InputDecoration(
                  label: Text('Email'),

                ),
                validator: (value){
    if(value==null||value.trim().length<=8)
    {
    return 'email must be gretter than 8 characters';
    }
    // if(value.characters!='@gmail.com')
    //   {
    //     return 'invalid email address';
    //   }
    return null;
    },
    onSaved: (value)
    {
    email=value!;

                },
              ),
              Text(selecteddate == null ? "select date" : intl.format(
                  selecteddate!))
              ,
              IconButton(onPressed: showdate, icon: Icon(Icons.calendar_month)),
              TextFormField(
                decoration: InputDecoration(
                  label: Text('Address'),

                ),
                validator: (value){
    if(value==null||value.trim().length<=3)
    {
    return 'address must be include minimum 3 characters';
    }
    return null;
    },
    onSaved: (value) {
      address = value!;
    }
              )
              ,
              TextFormField(
                decoration: InputDecoration(
                  label: Text('Password'),

                ),
                validator: (value){
                 var pass= value;
                  var regv=RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
    if(value==null||value.trim().length<=6)
    {
    return 'password should be gretter than 6';
    }
    if(!regv.hasMatch(value))
    {
      return 'password must include special character or numbers';
    }

      return null;
    },
    onSaved: (value)
    {

    password=value!;

    },

              ),
    //           TextFormField(              //n
    //             decoration: InputDecoration(
    //               label: Text('Confirm password'),
    //
    //             ),
    //             validator: (value){
    // if(value!=password)
    // {
    // return 'incorrect password';
    // }
    // return null;
    // },
    //
    //
    //           ),
              Row(
                children: [
                  ElevatedButton(onPressed:
                    setvalidate


                  ,
                      child: Text('Submit')),
                  ElevatedButton(onPressed:
    (){
    globalkey.currentState!.reset();

    }

                      , child: Text('reset')),
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
