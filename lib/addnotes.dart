import 'package:flutter/material.dart';
import 'package:fluttercourse/home.dart';
import 'package:fluttercourse/sql.dart';
import 'package:get/get.dart';

class Addnote extends StatefulWidget {
  const Addnote({super.key});

  @override
  State<Addnote> createState() => _AddnoteState();
}

class _AddnoteState extends State<Addnote> {

  Sql sql = Sql();

  GlobalKey<FormState> form = GlobalKey();

  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController type = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Form(
              key: form,
              child: Column(
                children: [
                  TextFormField(
                    controller: title,
                    decoration: InputDecoration(hintText: 'title'),
                  ),
                  TextFormField(
                    controller: note,
                    decoration: InputDecoration(hintText: 'note'),
                  ),
                  TextFormField(
                    controller: type,
                    decoration: InputDecoration(hintText: 'type'),
                  ),
                ],
              )),
              Container(height: 20,),
              MaterialButton(onPressed: ()async{
                int response = await sql.insertData("INSERT INTO 'notes' ('title','note','type')VALUES ('${title.text}','${note.text}','${type.text}')");
                if(response!= 0){
                  Get.offAll(()=>Home());
                }
              },textColor: Colors.white,color: Colors.grey,child: Text("Add note"),)
        ],
      ),
    );
  }
}
