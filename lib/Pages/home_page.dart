import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsup/Components/my_drawer.dart';
import 'package:whatsup/Components/my_usertile.dart';
import 'package:whatsup/Pages/chat_page.dart';
import 'package:whatsup/Pages/register_page.dart';
import 'package:whatsup/Services/auth_service.dart';
import 'package:whatsup/Services/chat_service.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({
    super.key,
    required this.user
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeSwitcher();
  }
  
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  bool isSwitched = false;

  void changeSwitcher() async {
    final miya = await SharedPreferences.getInstance();
    setState(() {
      isSwitched = miya.getBool("isLight") ?? false;
    });
  }

  void logout(){
    AuthService authService = AuthService();
    authService.logout();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => RegisterPage()
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(
        user: widget.user,
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Home"
        ),
        centerTitle: true,
      ),

      body: _usersList()

    );
  }

  Widget _usersList(){
    return StreamBuilder(
      stream: _chatService.getAllUsers(),
      builder: (context, snapshot){
        // error bo'lsa
        if(snapshot.hasError){
          return Text("Nimadir xatolik ketti");
        }

        // agar internet qotyotgan bo'sa
        if(snapshot.connectionState == ConnectionState.waiting){
          return Text("Loading...");
        }

        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _userListItem(userData, context))
              .toList(),
        );
      }
    );
  }

  Widget _userListItem(Map<String, dynamic> userData, BuildContext context){

    bool isCurrentUser = userData["uid"] == _authService.getCurrentUser()!.uid;

    if(isCurrentUser == false){
      return MyUsertile(
          text: userData["email"],
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatPage(
                      recieverEmail: userData["email"],
                      recieverID: userData["uid"],
                    )
                )
            );
          }
      );
    }
    return Container();
  }
}