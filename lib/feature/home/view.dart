import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sql_demo/core/database/datab.dart';
import 'package:sql_demo/feature/addNote/view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDb sqlDb = SqlDb();

  Future<List<Map>> readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM notes");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Your Notes "),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const AddNote()));
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: [
          TextButton(
              onPressed: () async {
                await sqlDb.deleteDatabaseDone();
                print("done");
              },
              child: const Text("DELETE ALL DATABASE ")),
          FutureBuilder(
              future: readData(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key('item ${snapshot.data![index]['id']}'),
                          onDismissed: (DismissDirection direction) {
                            setState(() {
                              snapshot.data!.removeAt(index);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: const Text("deleted"),
                                action: SnackBarAction(
                                  label: "Undo",
                                  onPressed: () {
                                    setState(() {
                                      snapshot.data!.insert(
                                          index, snapshot.data![index]);
                                    });
                                  },
                                ),
                              ));
                            });
                          },
                          confirmDismiss: (DismissDirection direction) async {
                            await showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    content: Text(
                                        "Are You Sure You Want To Delete This ${snapshot.data![index]['note']}"),
                                    actions: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              primary: Colors.transparent,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                              textStyle: const TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold)),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Cancel")),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              primary: const Color.fromRGBO(
                                                  255, 91, 56, 1),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                              textStyle: const TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold)),
                                          onPressed: () async{
                                            setState(() {
                                                sqlDb.deleteData("DELETE FROM 'notes' WHERE id = ${snapshot.data![index]['id']}");
                                              snapshot.data!.remove(snapshot.data![index]);
                                              print("delet+++++++++++++++");
                                                Get.snackbar(
                                                  'Your Note has been updated',
                                                  'Do you want to Undo?',
                                                  mainButton: TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          snapshot.data!.insert(
                                                              index, snapshot.data![index]);
                                                        });
                                                      },
                                                      child: const Text("Undo")),
                                                );
                                                Navigator.of(context).pop();
                                            });
                                          },
                                          child: const Text("Delete")),
                                    ],
                                  );
                                });
                          },
                          background: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(5)),
                            alignment: Alignment.center,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                                Icon(
                                  Icons.delete_forever,
                                  color: Colors.redAccent,
                                  size: 40,
                                ),
                              ],
                            ),
                          ),
                          child: GestureDetector(
                              onTap: () {},
                              child: Card(
                                  child: ListTile(
                                title:
                                    Text("${snapshot.data![index]['title']}"),
                                trailing:
                                    Text("${snapshot.data![index]['note']}"),
                              ))),
                        );
                      });
                }
                return const Center(child: Text("No Note Added"));
              }),

          // Center(
        ],
      ),
    );
  }
}
// Card(
// child: ListTile(
// title: Text("${snapshot.data![index]['title']}"),
// trailing: Text("${snapshot.data![index]['note']}"),
// ))
// Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// ElevatedButton(
// onPressed: () async {
// int response = await sqlDb.insertData(
// "INSERT INTO 'notes' ('note') VALUES ('note2')");
// print(response);
// },
// child: Text("INSERT DATA")),
// ElevatedButton(
// onPressed: () async {
// var response =
//     await sqlDb.readData("SELECT * FROM 'notes'");
// print(response);
// },
// child: Text("READ DATA")),
// ElevatedButton(
// onPressed: () async {
// var response = await sqlDb
//     .deleteData("DELETE FROM 'notes' WHERE id = 2");
// print(response);
// },
// child: Text("DELETE DATA")),
// ElevatedButton(
// onPressed: () async {
// var response = await sqlDb.updateData(
// "UPDATE 'notes' SET 'note'= 'note 5' WHERE id = 1 ");
// print(response);
// },
// child: Text("UPDATE DATA")),
// ElevatedButton(
// onPressed: () async {
// await sqlDb.deleteDatabaseDone();
// print("done");
// },
// child: Text("DELETE ALL DATABASE ")),
// ],
// ),
