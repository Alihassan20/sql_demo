import 'package:flutter/material.dart';
import 'package:sql_demo/core/database/datab.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDb sqlDb = SqlDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () async{
              int response = await sqlDb.insertData("INSERT INTO 'notes' ('note') VALUES ('note2')");
              print(response);
            }, child: Text("INSERT DATA")),
            ElevatedButton(onPressed: () async{
              var response = await sqlDb.readData("SELECT * FROM 'notes'");
              print(response);
            }, child: Text("READ DATA"))
          ],
        ),
      ),
    );
  }
}
