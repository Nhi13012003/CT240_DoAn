import 'package:cloud_firestore/cloud_firestore.dart';

class StreamTagName
{
  late CollectionReference<Map<dynamic,dynamic>> currentStream;
  late String tenChiMuc;
  StreamTagName({required this.currentStream,required this.tenChiMuc});

}