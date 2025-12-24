import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsup/Pages/register_page.dart';
import 'package:whatsup/Pages/settings_page.dart';
import 'package:whatsup/Services/auth_service.dart';

class MyDrawer extends StatelessWidget {

  final User user;

  const MyDrawer({
    super.key,
    required this.user
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // logo
          Column(
            children: [
              UserAccountsDrawerHeader(
                  accountName: Text(user.displayName ?? "${user.email?.substring(0, 10)}"),
                  accountEmail: Text(user.email ?? "whatsup@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/pp.jpg"
                  ),
                ),
              ),


              Padding(
                padding: EdgeInsetsGeometry.only(
                    left: 25
                ),
                child: ListTile(
                  title: Text("H O M E"),
                  leading: Icon(Icons.home),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
              ),

              Padding(
                padding: EdgeInsetsGeometry.only(
                    left: 25
                ),
                child: ListTile(
                  title: Text("S E T T I N G S"),
                  leading: Icon(Icons.settings),
                  onTap: (){
                    //
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsPage()
                      )
                    );
                  },
                ),
              ),

            ],
          ),

          Padding(
            padding: EdgeInsetsGeometry.only(
              left: 25,
              bottom: 35
            ),
            child: ListTile(
              title: Text("L O G O U T"),
              leading: Icon(Icons.logout),
              onTap: (){
                AuthService _auth = AuthService();
                _auth.logout();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegisterPage()
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
