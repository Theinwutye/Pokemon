import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pokemon/details.dart';
import 'package:flutter_pokemon/pokemon.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final url =
      "https://raw.githubusercontent.com/aungzinphyo94/PokemonGo/master/pokedex.json";
  PokemonHub pokemonHub;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var data = await http.get(url);

    var jsonData = jsonDecode(data.body);

    pokemonHub = PokemonHub.fromJson(jsonData);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokemon"),
      ),
      body: pokemonHub == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: pokemonHub.pokemon
                  .map((poke) => Padding(
                        padding: EdgeInsets.all(2),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>PokemonDetails(pokemon: poke)));
                          },
                          //Animation based on image
                          child: Hero(
                            tag: poke.img,
                            child: Card(
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      child: Image.network(poke.img),
                                    ),
                                    Text(
                                      poke.name,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                      ))
                  .toList()),
    );
  }
}
