import 'package:basic_banking_app/Database/DatabaseHelper.dart';
import 'package:basic_banking_app/Model/User.dart';
import 'package:flutter/material.dart';

import 'TransferForm.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  _CustomerProfileState createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  User? user;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshUser();
  }

  Future refreshUser() async {
    setState(() => isLoading = true);

    this.user = await DatabaseHelper.instance.queryUserById(widget.index);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          color: Colors.indigo,
          height: size.height,
          width: size.width,
          child: isLoading
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "Name : \n" + this.user!.name,
                            style: TextStyle(fontSize: 23, color: Colors.white),
                          ),
                        ),
                      ],
                    ),


                    SizedBox(
                      height: 50,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Email :\n" + this.user!.email,
                            style: TextStyle(fontSize: 23, color: Colors.white),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "Current Balance : \n " +
                                this.user!.cur_balance.toString(),
                            style: TextStyle(fontSize: 23, color: Colors.white),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.all(8),
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  minimumSize: Size(200, 50),
                                  textStyle: TextStyle(fontSize: 18),
                                  side: BorderSide(
                                      width: 2, color: Colors.white)),
                              child: Text(
                                'Transfer',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TransferForm(index:widget.index)));
                              },
                            )),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
