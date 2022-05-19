import 'package:basic_banking_app/Database/DatabaseHelper.dart';
import 'package:basic_banking_app/Model/Transfer.dart';
import 'package:basic_banking_app/Model/User.dart';
import 'package:basic_banking_app/Screens/MyHomePage.dart';
import 'package:flutter/material.dart';

class TransferForm extends StatefulWidget {
  const TransferForm({
    Key? key,
    required this.index,

  }) : super(
          key: key,
        );
  final int index;

  @override
  State<TransferForm> createState() => _TransferFormState();
}

class _TransferFormState extends State<TransferForm> {
  List<User>? users;
  bool isLoading = false;

  late int transfer_to ;
  late double amount_to_transfer ;
  final _formKey = GlobalKey<FormState>();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    refreshUsers();
  }
  Future refreshUsers() async {
    setState(() => isLoading = true);

    this.users = (await DatabaseHelper.instance.queryAllUsers())!;

    setState(() => isLoading = false);
  }







  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(top: 100, right: 25, left: 25, bottom: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.person),
                    hintText: 'Transfer to..',
                    labelText: 'Id',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid Id';
                    }
                  },
                  onChanged: (val) {
                    setState(() {
                      transfer_to = int.parse(val);
                    });
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.money),
                    hintText: 'Amount to transfer',
                    labelText: 'Amount',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid amount';
                    }
                    if (value.runtimeType == int) {
                      setState(() {
                        amount_to_transfer = double.parse(value) + 0.0;
                      });
                    }
                    print(amount_to_transfer);
                  },
                  onChanged: (val) {
                    setState(() {
                      amount_to_transfer = double.parse(val);
                    });
                  },
                ),
                new Container(
                    padding: const EdgeInsets.only(left: 130, top: 40.0),
                    child: new RaisedButton(
                      child: const Text('Submit'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if(users![widget.index].cur_balance>amount_to_transfer)
                            {
                              double sender_new_balance=users![widget.index].cur_balance-amount_to_transfer;
                              double receiver_new_balance=users![transfer_to].cur_balance+amount_to_transfer;
                              User tempSender=new User(id: users![widget.index].id,name: users![widget.index].name,
                              email: users![widget.index].email,cur_balance: sender_new_balance
                              );

                              User tempReceiver=new User(id: users![transfer_to].id,name: users![transfer_to].name,
                                  email: users![transfer_to].email,cur_balance: receiver_new_balance
                              );

                              DatabaseHelper.instance.updateUser(tempSender);
                              DatabaseHelper.instance.updateUser(tempReceiver);
                              Transfer transfer= new Transfer(senderName: users![widget.index].name,receiverName: users![transfer_to].name,
                              transferredAmount: amount_to_transfer
                              );
                              DatabaseHelper.instance.insertTransfer(transfer);

                            }
                          else
                            {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text("Your current balance is less than the amount to transfer"),
                                )
                              );
                            }


                          Navigator.popUntil(context, ModalRoute.withName('/'));
                        }
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
