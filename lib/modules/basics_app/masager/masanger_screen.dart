import 'package:flutter/material.dart';

class MassengerScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 20.0,
        backgroundColor: Colors.white,
        elevation: 00.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage('https://scontent.fcai20-3.fna.fbcdn.net/v/t1.18169-9/18767546_113526405905026_4340076612927708032_n.jpg?_nc_cat=104&cb=99be929b-59f725be&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=ccNInr828soAX_DoXJ9&_nc_ht=scontent.fcai20-3.fna&oh=00_AfCdVkFam4JxM4sZgbsGnv8BZ66vrfK_oXFJ2jGGSS0D-w&oe=64E24B7E'),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              'Chats',
              style: TextStyle(
                color: Colors.black,
              ),
            ),

          ],
        ),
        actions: [
         IconButton(
             onPressed: (){},
             icon:CircleAvatar (
               radius: 15.0,
               backgroundColor: Colors.black,
                 child: Icon(Icons.camera_alt,size: 16.0,color: Colors.white,))),
          IconButton(
              onPressed: (){},
              icon:CircleAvatar (
                  radius: 15.0,
                  backgroundColor: Colors.black,
                  child: Icon(Icons.edit,size: 16.0,color: Colors.white,))),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(10.0),
                  color: Colors.grey[300],
                ),
                padding: EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(width: 10.0,),
                    Text(
                      'Search'
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                height: 150.0,
                child: ListView.separated(
                  shrinkWrap: true,
                    itemBuilder: (context,index) =>  buildStoryItem(),
                  separatorBuilder: (context,index)=>SizedBox(width: 20.0,),
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,

                  ),
              ),
              // SizedBox(height: 20,),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context,index)=>buildChatItem(),
                separatorBuilder: (context,index)=>SizedBox(height: 20.0,),
                itemCount: 15,
              )
              


            ],
          ),
        ),
      ),
    );
  }

  Widget buildStoryItem () => Container(
    width: 70.0,
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage('https://avatars.githubusercontent.com/u/47832762?v=4'),
            ),
            CircleAvatar(
              radius: 6.0,
              backgroundColor: Colors.white,

            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                  bottom: 3.0,
                  end: 3.0
              ),
              child: CircleAvatar(
                radius: 7.0,
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0,),
        Text('Abdulalim Mohamed',maxLines: 2,overflow: TextOverflow.ellipsis,),

      ],
    ),
  );
  Widget buildChatItem () => Row(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage('https://avatars.githubusercontent.com/u/47832762?v=4'),
          ),
          CircleAvatar(
            radius: 6.0,
            backgroundColor: Colors.white,

          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
                bottom: 3.0,
                end: 3.0
            ),
            child: CircleAvatar(
              radius: 7.0,
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
      SizedBox(width: 7.0,),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Abdelalim Mohamed',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Hello,My Name is Ahmed  Hello,My Name is Ahmed Hello,My Name is Ahmed',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    width:7.0 ,
                    height:7.0 ,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Text(
                    'at 8.00 pm'
                ),
              ],
            ),
          ],),
      ),
    ],
  );
}
