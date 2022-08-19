import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:reference_flights/screens/display.dart';

String? stringResponse;
Map? mapResponse ;
Map? dataResponse;
List? listResponse;


class KeyValueModel {
  String key;
  String value;

  KeyValueModel({required this.key, required this.value});
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future apicall() async{
    http.Response response;
    response = await http.get(Uri.parse('http://api.aviationstack.com/v1/flights?access_key=5d94a3ef266d7104fe6a27167a8756b0&dep_iata='+_selectedValue1!+'&arr_iata='+_selectedValue2!));
    if (response.statusCode == 200){
      setState((){

        mapResponse = json.decode(response.body) ;
        listResponse= mapResponse!['data'];


      });
    }
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context)=> const Display()
        )
    );

  }




  final List<KeyValueModel> _datas = [
    KeyValueModel(key: "Amritsar", value: "ATQ"),


    KeyValueModel(key: "Calicut", value: "CCJ"),
    KeyValueModel(key: "Chennai", value: "MAA"),

    KeyValueModel(key: "Hyderabad", value: "HYD"),
    KeyValueModel(key: "Kochi", value: "COK"),
    KeyValueModel(key: "Kolkata", value: "CCU"),
    KeyValueModel(key: "Mumbai", value: "BOM"),
    KeyValueModel(key: "New Delhi", value: "DEL"),
    KeyValueModel(key: "Thiruvananthapuram", value: "TRV"),


  ];

  String? _selectedValue1 = "";

  String? _selectedValue2 = "";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flight References'),

      ),
      body: Center(
        child: Column(

          children: [
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: DropdownButton<String>(

                isExpanded: true,
                dropdownColor: Colors.white,
                style: const TextStyle(fontSize: 17, color: Colors.black),
                hint: const Text('Departure', style: TextStyle(fontSize: 15,)),
                items: _datas
                    .map((data) => DropdownMenuItem<String>(
                  value: data.value,


                  child: Text(data.key),
                ))
                    .toList(),
                onChanged: (String? value){
                  setState(() {
                    _selectedValue1=value;
                  });
                },
              ),

            ),
            SizedBox(
              height: 25.0,
            ),
            Text(_selectedValue1??""),
            const SizedBox(height: 35,),

            const Text('To', style: TextStyle(fontSize: 25, color: Colors.black),),
            const SizedBox(height: 35,),
            Text(_selectedValue2??""),
            const SizedBox(height: 35,),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: DropdownButton<String>(

                isExpanded: true,
                dropdownColor: Colors.white,
                style: const TextStyle(fontSize: 17, color: Colors.black),
                hint: const Text('Destination', style: TextStyle(fontSize: 15,)),
                items: _datas
                    .map((data) => DropdownMenuItem<String>(
                  child: Text(data.key),
                  value: data.value,
                ))
                    .toList(),
                onChanged: (String? value){
                  setState(() {
                    _selectedValue2=value;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: (){
                apicall();

              },
              child: Container(
                alignment: AlignmentDirectional.center,
                width: 180,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('Search Flights', style: TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 25, color: Colors.white
                ),),
              ),
            ),

          ],
        ),
      )

    );
  }
}
