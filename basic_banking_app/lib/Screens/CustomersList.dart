import 'package:basic_banking_app/Model/User.dart';
import 'package:basic_banking_app/Screens/CustomerProfile.dart';
import 'package:flutter/material.dart';
import 'package:basic_banking_app/Database/DatabaseHelper.dart';


class CustomersList extends StatefulWidget {
  const CustomersList({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _CustomersListState createState() => _CustomersListState();
}

class _CustomersListState extends State<CustomersList> {
  List<User>? users;
  bool isLoading = false;
  static int count=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(count==0)
      {
        DatabaseHelper.instance.addUsers();
        count++;
      }

    refreshUsers();
  }

  Future refreshUsers() async {
    setState(() => isLoading = true);

    this.users = (await DatabaseHelper.instance.queryAllUsers())!;

    setState(() => isLoading = false);
  }

 /* @override
  void dispose() {
    DatabaseHelper.instance.close();

    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(this.widget.title)),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: isLoading ? 0 : 10,
            itemBuilder: (context, index) => ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CustomerProfile(index: (index + 1))));
              },
              title: isLoading
                  ? CircularProgressIndicator()
                  : Row(
                      children: [
                        Text(
                         index.toString()+"   ",
                          style: TextStyle(
                            fontSize: 23,
                          ),
                        ),
                        Text(
                          users![index].name,
                          style: TextStyle(
                            fontSize: 23,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.info_outline,
                          size: 25,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
