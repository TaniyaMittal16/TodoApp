import 'package:flutter/material.dart';
import 'package:todoapp/database.dart';
import 'package:todoapp/registermodel.dart';


class Todolist extends StatefulWidget {
  const Todolist({Key? key}) : super(key: key);

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("List of your task")),
      body: FutureBuilder<dynamic>(
        future: DBProvider.db.getAllRegisterModels(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index){
                RegisterModel item = snapshot.data![index];
                return ListTile(
                  title: Text(item.username),
                  leading: Text(item.age.toString()),
                );
              },
            );
          }
          else{
            return const Center(
              child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async{
          setState(() {});
        },
      ),
    );
  }
}
