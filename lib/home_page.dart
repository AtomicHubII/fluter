import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
 
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column( 
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.network(getUrlImage(),fit: BoxFit.cover,height: 200,width: double.infinity,),
        Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Column(
                  children:[
                    Text("Oeschinen Lake Campground", style: TextStyle(fontSize: 30),),
                    Text("Kandersteg, Switzerland", style: TextStyle(fontSize: 20, color: Colors.grey),),            
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  Icon(Icons.star, size: 50, color: Colors.blue),
                  Text("41", style: TextStyle(fontSize: 30, color: Colors.red),),  
              ],),
                   
              ],
            ), 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.call,size:50,color: Colors.blue),
            Icon(Icons.sms,size:50,color: Colors.blue),
            Icon( Icons.share,size:50,color: Colors.blue)
            //Icon ở trên gg fonts
          ]),
         Text("Chao mung ban den voi Flutter"),

        
      ],
    )
    );
  }




  String getUrlImage() {
    return "https://plus.unsplash.com/premium_photo-1673240367277-e1d394465b56?q=80&w=1169&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
  }
}