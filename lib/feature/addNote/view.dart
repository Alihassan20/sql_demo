import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sql_demo/feature/home/view.dart';

import '../../core/database/datab.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  SqlDb sqlDb = SqlDb();

  GlobalKey<FormState> Gkey = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ADD NOTE HERE"),
      ),
      body: Container(
        child: Form(
          key: Gkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                TextFormField(
                  controller: note,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.white,
                          )),
                      hintText: 'Note'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: title,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.white,
                          )),
                      hintText: 'Title'),
                ),
                const SizedBox(height: 10),
                const Spacer(),
                ElevatedButton(
                    onPressed: () async {
                      int response = await sqlDb.insertData(
                          '''
                      INSERT INTO notes (note , title)
                       VALUES ("${note.text}", "${title.text}")
                          ''');
                      if(response >0){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Home()));
                      }
                    },
                    child: const Text('ADD NOTE'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
