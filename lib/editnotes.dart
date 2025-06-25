import 'package:flutter/material.dart';
import 'package:fluttercourse/home.dart';
import 'package:fluttercourse/sql.dart';
import 'package:get/get.dart';

class EditNote extends StatefulWidget {
final id ;
  final title;
  final note;
  final type;
  const EditNote({super.key, this.id, this.title, this.note, this.type});

  @override
  State<EditNote> createState() => _EditNoteState();
  
}

class _EditNoteState extends State<EditNote> {
  Sql sql = Sql();

  


  GlobalKey<FormState> form = GlobalKey();

  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController type = TextEditingController();
  @override
  void initState() {
   title.text = widget.title;
   note.text = widget.note;
   type.text = widget.type;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),
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
                int response = await sql.updateData("UPDATE 'notes' SET 'title'='${title.text}','note'='${note.text}','type'='${type.text}'WHERE id = ${widget.id}");
                if(response!= 0){
                  Get.offAll(()=>Home());
                }
              },textColor: Colors.white,color: Colors.grey,child: Text("Edit note"),)
        ],
      ),
    );
  }
}