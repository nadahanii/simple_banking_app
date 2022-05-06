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
  User? sender;
  User? receiver;
  late int transfer_to ;
  late double amount_to_transfer ;
  final _formKey = GlobalKey<FormState>();

  Future retrieveSenderAndReceiver() async {
    sender = await DatabaseHelper.instance.queryUserById(widget.index);
    receiver = await DatabaseHelper.instance.queryUserById(transfer_to);
  }

  Future updateSender() async
  {
    /*final  tempUser= sender!.copy(
      name: sender!.name,
      email: sender!.email,
      cur_balance: (sender!.cur_balance-amount_to_transfer)
    );*/
    await DatabaseHelper.instance.updateUser(widget.index,(sender!.cur_balance-amount_to_transfer));
  }

  Future updateReceiver() async
  {
    /*final  tempUser= receiver!.copy(
        name: receiver!.name,
        email: receiver!.email,
        cur_balance: (receiver!.cur_balance+amount_to_transfer)
    );*/
    await DatabaseHelper.instance.updateUser(transfer_to,(receiver!.cur_balance+amount_to_transfer));
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
                          retrieveSenderAndReceiver();
                          if(sender!=null && receiver!=null)
                            {
                              if(sender!.cur_balance>amount_to_transfer)
                                {
                                  updateSender();
                                  updateReceiver();
                                }
                            }



                         /* if (sender != null && receiver != null) {
                            if (sender!.cur_balance > amount_to_transfer) {
                              //inserting transfer in transfers table
                              Transfer tempTransfer = Transfer(
                                  senderName: sender!.name,
                                  receiverName: receiver!.name,
                                  transferredAmount: amount_to_transfer);
                              DatabaseHelper.instance
                                  .insertTransfer(tempTransfer);

                              //performing transfer
                              User tempUser1 = User(
                                  id: sender!.id,
                                  name: sender!.name,
                                  email: sender!.email,
                                  cur_balance: (sender!.cur_balance -
                                      amount_to_transfer));
                              User tempUser2 = User(
                                  id: receiver!.id,
                                  name: receiver!.name,
                                  email: receiver!.email,
                                  cur_balance: (receiver!.cur_balance +
                                      amount_to_transfer));
                              DatabaseHelper.instance.updateUser(tempUser1);
                              DatabaseHelper.instance.updateUser(tempUser2);
                            }
                          }*/

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
