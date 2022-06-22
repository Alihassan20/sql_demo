import 'package:flutter/material.dart';

import '../../core/database/datab.dart';
import '../home/view.dart';

class EditNote extends StatefulWidget {
  final note ;
  final title;
  final id;
   EditNote({required this.note, required this.title,required this.id});

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  SqlDb sqlDb = SqlDb();

  GlobalKey<FormState> Gkey = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    note.text=widget.note;
    title.text=widget.title;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EDIT NOTE"),
        centerTitle: true,
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
                      int response = await sqlDb.updateData(
                          '''
                      UPDATE notes SET 
                      note  = "${note.text}" ,
                      title = "${title.text}"
                      WHERE id = ${widget.id}
                          ''');
                      if(response >0){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Home()));

                      }
                    },
                    child: const Text('EDITE NOTE'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
