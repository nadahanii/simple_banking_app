import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key,required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor:  Colors.indigo,
          toolbarHeight: 95,
          title: Center(
            child: Text(
              this.title,
                style: TextStyle(fontWeight: FontWeight.bold)
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 25),
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(8),
                child: InkWell(
                  onTap: (){},
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                            Icons.monetization_on_rounded,
                          size: 32,
                        ),
                      ),
                      Text(
                       'View Transfers',
                        style: TextStyle(

                            fontSize: 23,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}

/* OutlinedButton(
            style: OutlinedButton.styleFrom(
                minimumSize: Size(200, 50),
                textStyle: TextStyle(fontSize: 18),
                side: BorderSide(width: 2,color: Colors.indigo)
            ),
            child: Text('View Transfers'),
            onPressed: () {

            },
          )*/