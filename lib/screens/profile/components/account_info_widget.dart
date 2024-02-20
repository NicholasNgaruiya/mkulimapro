
import 'package:flutter/material.dart';

import '../../../global_resources/models/user_account.dart';

class AccountInfoWidget extends StatelessWidget {
  const AccountInfoWidget({Key? key, required this.userAccount}) : super(key: key);
  final UserAccount userAccount;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: Text(
              'Personal Information',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
          ),

          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ...ListTile.divideTiles(
                        color: Colors.grey,
                        tiles: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            leading: Icon(Icons.person),
                            title: Text("First Name"),
                            subtitle: Text(userAccount.firstName),
                          ),
                            ListTile(
                              leading: Icon(Icons.email),
                              title: Text("Email"),
                              subtitle: Text(userAccount.userEmail),
                            ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}