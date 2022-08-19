import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'home_screen.dart';



class Display extends StatefulWidget {
  const Display({Key? key}) : super(key: key);

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Flights"),
      ),
      body: ListView.builder(itemBuilder: (context, index){
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.blue),

          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text('Departure'),
                Text(listResponse![index]['flight_date'].toString()),
                Text(listResponse![index]['departure']['airport'].toString()),
                Text(listResponse![index]['departure']['scheduled'].toString()),
                Text(listResponse![index]['airline']['name'].toString()),
                Text(listResponse![index]['flight']['number'].toString()),


                Text('Destination'),

                Text(listResponse![index]['arrival']['airport'].toString()),
                Text(listResponse![index]['arrival']['scheduled'].toString()),
                SizedBox(height: 15)

              ]
            ),
          ),
        );
      }
      ),
    );
  }
}
