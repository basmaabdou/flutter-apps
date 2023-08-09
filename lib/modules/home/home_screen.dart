import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
        ),
        title: Text(
            'First App'
        ),
        actions:
        [
          IconButton(
            icon:Icon (Icons.notification_important,),
            onPressed: (){
              print("notification clicked");
            },
          ),
          IconButton(
            icon: Icon(Icons.search,),
            onPressed: (){
              print("search");
              }, ),
          // IconButton(icon: Text('hello'),onPressed: (){print('hellllooo');},),
        ],
        // centerTitle: true,
        elevation: 00.0,
        backgroundColor: Colors.teal,
      ),

      body:  Column(
         children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Container(
                decoration:BoxDecoration(
                  // borderRadius: BorderRadius.circular(30.0),
                  borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(20.0),),
                ),
                clipBehavior:Clip.antiAliasWithSaveLayer  ,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image(
                        image: NetworkImage(
                      'https://picsum.photos/250?image=9'
                        ),
                      width: 200.0,
                      height: 200.0,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: 200.0,
                      color: Colors.brown.withOpacity(0.4),
                      padding: EdgeInsets.symmetric(
                            vertical: 5.0,
                        horizontal: 5.0,
                      ),
                      child: Text(
                        'Developer',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }

}
