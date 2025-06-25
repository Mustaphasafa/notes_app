import 'package:flutter/material.dart';
import 'package:fluttercourse/addnotes.dart';
import 'package:fluttercourse/editnotes.dart';
import 'package:fluttercourse/sql.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Sql sql = Sql();

  Future<List<Map>> showData() async {
    List<Map> response = await sql.readData("SELECT * FROM 'notes'");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Get.to(()=>Addnote());
      },backgroundColor: Colors.grey,child: Icon(Icons.add,color: Colors.white,),),
    
      appBar: AppBar(
        title: Text(
          "Notes",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey[200],
      ),
      body: ListView(
        children: [
          // Center(
          //   child: MaterialButton(
          //     onPressed: () async {
          //       List<Map> reponse = await showData();
          //       print(reponse);
          //     },
          //     color: Colors.black,
          //     textColor: Colors.white,
          //     child: Text("show Database"),
          //   ),
          // ),
          Center(
            child: MaterialButton(
              onPressed: () async {
                await sql.onDeleteDatabase();
              },
              color: Colors.black,
              textColor: Colors.white,
              child: Text("Delete Database"),
            ),
          ),
          FutureBuilder(
              future: showData(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, i) {
                        return Card(
                          child: ListTile(
                            title: Text("${snapshot.data![i]['title']}"),
                            subtitle: Text("${snapshot.data![i]['note']}"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Get.to(EditNote(id:snapshot.data![i]['id'] ,title: snapshot.data![i]['title'],note: snapshot.data![i]['note'],type: snapshot.data![i]['type'],));
                                    }, icon: Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () async {
                                      var response = await sql.deleteData(
                                          "DELETE FROM 'notes' WHERE id = ${snapshot.data![i]['id']}");
                                      if (response != 0) {
                                        setState(() {});
                                      }
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                          ),
                        );
                      });
                }
                return Center(child: CircularProgressIndicator());
              })
        ],
      ),
    );
  }
}
