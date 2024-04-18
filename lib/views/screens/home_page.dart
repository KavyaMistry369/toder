import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toder/controllers/controller_one.dart';
import 'package:toder/models/user_model.dart';
import 'package:toder/services/helpers/FCM_helper.dart';
import 'package:toder/services/helpers/auth_helper.dart';
import 'package:toder/services/helpers/data_helper.dart';
import 'package:toder/services/helpers/notifications_helper.dart';
import 'package:toder/utils/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    super.initState();
    FCMHelper.fcmHelper.notifications();
  }


  @override
  Widget build(BuildContext context) {
    UserModel acc = ModalRoute.of(context)!.settings.arguments as UserModel;

    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: StreamBuilder(
            stream: DataHelper.dataHelper.readTodo(email: acc.email),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List data = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onLongPress: () {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                            title: const Text("Wow You Complete Your Task"),
                            actions: [
                              CupertinoButton(onPressed: (){
                                DataHelper.dataHelper.deleteTodo(email: acc.email,id: snapshot.data?.docs[index]['id']);
                                Navigator.of(context).pop();
                              },child: const Text("Done")),
                            ],
                            content: Image.network(
                                "https://cdn.dribbble.com/users/424937/screenshots/6660260/01-account-created-dribbble.gif"),
                          ),
                        );
                      },
                      onTap: () {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                            title: const Text("Details"),
                            actions: [
                              CupertinoButton(onPressed: (){
                                Navigator.of(context).pop();
                                Navigator.of(context).pushNamed(MyRoutes.update,arguments: [index,acc]);
                              },child: const Text("Update")),
                            ],
                            content: Column(
                              children: [
                                Text("Title : ${data[index]['title']}"),
                                Text("Description : ${data[index]['des']}"),
                                Text("Date : ${data[index]['date']}"),
                                Text("Time : ${data[index]['time']}"),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Card(
                          child: ListTile(
                            subtitle: Text(
                              "${data[index]['des']}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            title: Text(
                              "${data[index]['title']}",
                              style: const TextStyle(fontSize: 20),
                            ),
                            trailing: Text(
                              "${data[index]['time']}",
                              style: const TextStyle(fontSize: 14),
                            ),
                          )),
                    );
                  },
                );
              }
              return Center(
                child: Column(
                  children: [
                    Image.asset(
                      "lib/views/assets/todo.png",
                      width: 350,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Todos Not Added Yet !",
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
              );
            },
          )),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                otherAccountsPictures: [
                  IconButton(
                      onPressed: () {
                        AuthHelper.authHelper.signOut();
                      },
                      icon: Icon(
                        Icons.logout_sharp,
                        color: Colors.white,
                      )),
                ],
                currentAccountPicture: Hero(
                    tag: 'profile',
                    child:
                        CircleAvatar(backgroundImage: NetworkImage(acc.image))),
                accountName: Text(acc.name),
                accountEmail: Text(acc.email)),
            const SizedBox(height: 20,),
            ListTile(title: Text("Change Theme"),trailing: IconButton(onPressed: (){
              Provider.of<ControllerOne>(context,listen: false).changeTheme();
            }, icon: (Provider.of<ControllerOne>(context).isDark)?Icon(Icons.light_mode_outlined):Icon(Icons.dark_mode_outlined)),),
            const Spacer(),
            Card(
              child: ListTile(
                onTap: (){
                  AuthHelper.authHelper.signOut();
                  Navigator.pushReplacementNamed(context,MyRoutes.login);
                },
                title: Text("Log Out"),trailing: IconButton(onPressed: (){
              }, icon: Icon(Icons.logout),),),
            ),
          ],
        ),
        semanticLabel: "Account",
      ),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: ()async{
            await FCMHelper.fcmHelper.getToken();
          }, icon: const Icon(Icons.notifications))
        ],
        title: const Text("My Todos"),
        leading: Builder(
          builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Container(
                child: Hero(
                    tag: 'profile',
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(acc.image),
                    )),
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: CupertinoColors.activeBlue,
        onPressed: () {
          Navigator.of(context).pushNamed(MyRoutes.add, arguments: acc);
        },
        label: const Text(
          "Add Todo",
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
