import 'package:intl/intl.dart';

final intl=DateFormat.yMd();

class Str{
  Str({required this.id,required this.name,required this.sname,required this.address,required this.date,required this.password,required this.email});
 String id;
  String name;
  String sname;
  String address;
  DateTime date;
  String password;
  String email;
  String get formattedDate {
   return intl.format(date);
  }

}