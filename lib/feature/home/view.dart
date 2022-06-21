import 'package:flutter/material.dart';
import 'package:sql_demo/core/database/datab.dart';

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
      body: ListView(
        children: [
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
                        return Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("${snapshot.data![index]['id']}"),
                              Text("${snapshot.data![index]['note']}"),
                            ],
                          ),
                        );
                      });
                }
                return CircularProgressIndicator();
              }),
          // Center(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    int response = await sqlDb.insertData(
                        "INSERT INTO 'notes' ('note') VALUES ('note2')");
                    print(response);
                  },
                  child: Text("INSERT DATA")),
              ElevatedButton(
                  onPressed: () async {
                    var response =
                        await sqlDb.readData("SELECT * FROM 'notes'");
                    print(response);
                  },
                  child: Text("READ DATA")),
              ElevatedButton(
                  onPressed: () async {
                    var response = await sqlDb
                        .deleteData("DELETE FROM 'notes' WHERE id = 2");
                    print(response);
                  },
                  child: Text("DELETE DATA")),
              ElevatedButton(
                  onPressed: () async {
                    var response = await sqlDb.updateData(
                        "UPDATE 'notes' SET 'note'= 'note 5' WHERE id = 1 ");
                    print(response);
                  },
                  child: Text("UPDATE DATA")),
            ],
          ),
        ],
      ),
    );
  }
}
