import 'package:basic_banking_app/Model/Transfer.dart';
import 'package:basic_banking_app/Screens/CustomersList.dart';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Transfer> transfers;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Center(child: Text(widget.title,style: TextStyle(fontWeight: FontWeight.bold),)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '             Nada hani \n \n Spark Foundation - Task 1',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 80),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  minimumSize: Size(200, 50),
                  textStyle: TextStyle(fontSize: 18),
                  side: BorderSide(width: 2,color: Colors.indigo)
              ),
              child: Text('View Customers'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CustomersList(title: widget.title,)));
              },
            )
          ],
        ),
      ),
    );
  }
}