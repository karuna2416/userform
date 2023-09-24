import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

import 'package:submissionform/str.dart';

class Userdetailsscreen extends StatefulWidget {
  const Userdetailsscreen({super.key});

  @override
  State<Userdetailsscreen> createState() => _UserdetailsscreenState();
}

class _UserdetailsscreenState extends State<Userdetailsscreen> {
  List<Str> initiallist=[];

  @override
  void initState() {

    // TODO: implement initState
    api();
    super.initState();
  }
  void api()async{
    var url= Uri.https('flutter-b377b-default-rtdb.firebaseio.com','/user.json');
    final res=await http.get(url);
        print(res.body);
      final Map<String, dynamic> result=json.decode(res.body);
final List<Str> newlist=[];
for(final user in result.entries)
  {
    newlist.add(Str(id:user.key,name: user.value['name'], sname: user.value['sname'], address:user.value['address'], date: user.value['date'], password: user.value['password'],email: user.value['email']));
 print('id${user.key}');
  }

      setState(() {
       initiallist=newlist;

      });
print('initi${initiallist[0].name}');
// print('i${initialist.name}')
  }
  void delete(Str dlist)
  {
      var url= Uri.https('flutter-b377b-default-rtdb.firebaseio.com','/user/${dlist.id}.json');
       http.delete(url);
      setState(() {
        initiallist.remove(dlist);

      });
  }
  void edit(Str elist)
  {

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('user details')
    ),
      body:initiallist.isEmpty?Text('empty'):ListView.builder(itemCount:initiallist.length ,itemBuilder: (ctx,index)
    {return
    SingleChildScrollView(
      child: Column(
      children: [
         Row(
          children: [
            Text(initiallist[index].name),

        Text(initiallist[index].sname),

        Text(initiallist[index].address),


       ]
        ),
        Row(
          children: [
            Text(initiallist[index].date),
            Text(initiallist[index].password),
          ],
        ),
        Row(
          children: [
            Text(initiallist[index].email),
            TextButton(onPressed: (){
              delete(initiallist[index]);
            }, child: Text('delete')),
            TextButton(onPressed: (){
              edit(initiallist[index]);
            }, child: Text('edit'))

          ],
        )


      ]
        ),
    );
    }
    )
    );
  }
}
