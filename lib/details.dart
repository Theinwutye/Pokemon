import 'package:flutter/material.dart';
import 'package:flutter_pokemon/pokemon.dart';

class PokemonDetails extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetails({Key key, this.pokemon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("Details"),),
      body:Stack(
      children: [
        Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 20,
            left: 10,
            top: MediaQuery.of(context).size.height * 0.15,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height:70),
                    Text(
                      pokemon.name,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text("Height: ${pokemon.height}"),
                    Text("Weight:${pokemon.weight}"),
                    Text(
                      "Types",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: pokemon.type
                          .map((e) => FilterChip(
                                backgroundColor: Colors.amber,
                                label: Text(e),
                                onSelected: (b) {},
                              ))
                          .toList(),
                    ),
                    Text("Weakness"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: pokemon.weaknesses
                          .map((e) => FilterChip(
                                backgroundColor: Colors.red,
                                label: Text(
                                  e,
                                  style: TextStyle(color: Colors.white),
                                ),
                                onSelected: (b) {},
                              ))
                          .toList(),
                    ),
                    Text(
                      "Next Evolution",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    
                      children: pokemon.nextEvolution==null?
                      [Text("This is the final form")]:pokemon.nextEvolution
                          .map((e) => FilterChip(
                                backgroundColor: Colors.green,
                                label: Text(
                                  e.name,
                                  style: TextStyle(color: Colors.white),
                                ),
                                onSelected: (b) {},
                              ))
                          .toList(),
                    ),
                  ]),
            )),
        Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: pokemon.img,
              child: Image.network(pokemon.img,
                  fit: BoxFit.cover, width: 200, height: 200),
            ))
      ],
     ) );
  }
}
