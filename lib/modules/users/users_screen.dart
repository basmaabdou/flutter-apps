import 'package:flutter/material.dart';
import 'package:section3/models/user/user_model.dart';

class UserScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    List <UserModel> users=[
      UserModel(id: 1, name: 'Basma', phone: '+20145556698'),
     UserModel(id: 2, name: 'Mohab', phone: '+20145596698'),
      UserModel(id:3, name: 'noran', phone: '+2085521455554'),
      UserModel(id: 4, name: 'Asmaa', phone: '+2014558855'),
      UserModel(id: 5, name: 'abdou', phone: '+20145596698'),
      UserModel(id: 6, name: 'Enas', phone: '+20145596698'),
      UserModel(id: 7, name: 'Mohab', phone: '+20145596698'),

    ];
    return  Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: ListView.separated(
          itemBuilder: (context,index)=>buildItem(users[index]),
          separatorBuilder: (context,index)=>Padding(
            padding: const EdgeInsetsDirectional.only(start: 20.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          itemCount: users.length),
    );
  }
  Widget buildItem(UserModel user)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 30.0,
          child: Text(
            '${user.id}',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 20.0,),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${user.name}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            Text(
              '${user.phone}',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
