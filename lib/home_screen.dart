import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var pokeApi = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  List pokedex=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(mounted){
      fetchPokemonData();
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          pokedex != [] ? Expanded(child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.4,
            ), itemCount: pokedex.length,
            itemBuilder: (context, index){
              return Card(
                child: Column(
                  children: [
                    Text(
                      pokedex[index]['name']
                ),
                CachedNetworkImage(imageUrl: pokedex[index]['img']
     ),

              ]
            )     
          );
        },
      ),
          ): Center(
            child: CircularProgressIndicator(),
          )
        ],
      )
    );
  }
  void fetchPokemonData(){
    var url = Uri.https("raw.githubusercontent.com", "/Biuni/PokemonGO-Pokedex/master/pokedex.json");
    http.get(url).then((value) {
      if(value.statusCode == 200){
        var decodedJsonData = jsonDecode(value.body);
        pokedex = decodedJsonData['pokemon'];
        
        setState(() {});
      }
      
    });
  }
}