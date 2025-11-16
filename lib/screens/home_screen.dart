import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokepedia/screens/pokemon_details.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var pokepediaAPI =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  List pokepedia = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              right: -30,
              top: -30,
              child: Image.asset(
                'assets/images/logo1.png',
                width: 150,
                color: Colors.black12,
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned(
              top: 38,
              left: 20,
              child: Text(
                "Poke'dex",
                style: TextStyle(
                  fontFamily: 'Pokemon',
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(top: 60, child: TextField()),

            Padding(
              padding: const EdgeInsets.only(top: 120.0),
              child: SizedBox(
                height: height,
                width: width,
                child: pokepedia.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 300,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 1.4,
                              ),
                          itemCount: pokepedia.length,
                          itemBuilder: (context, index) {
                            var type = pokepedia[index]['type'][0];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PokemonDetails(
                                      color: getColor(type),
                                      details: pokepedia[index],
                                      tag: index,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 3,
                                color: getColor(type),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      right: -100,
                                      top: 10,
                                      bottom: 10,
                                      left: 0,
                                      child: Opacity(
                                        opacity: 0.3,
                                        child: Image.asset(
                                          'assets/images/logo1.png',
                                          width: 100,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 10,
                                      top: 3,
                                      child: Text(
                                        pokepedia[index]['name'],
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black,
                                              blurRadius: 2,
                                              offset: Offset(0.5, 0.5),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 2,
                                      child: CachedNetworkImage(
                                        width: 100,
                                        imageUrl: pokepedia[index]['img'],
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),

                                    Positioned(
                                      top: 28,
                                      left: 10,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          color: Colors.white30,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 3.0,
                                            horizontal: 6,
                                          ),
                                          child: Text(
                                            type.toString(),
                                            style: const TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Center(
                        child: SpinKitSpinningLines(
                          color: Colors.black87,
                          size: 50,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getColor(String type) {
    switch (type) {
      case 'Water':
        return Colors.lightBlueAccent;
      case 'Fire':
        return Colors.redAccent;
      case 'Grass':
        return Colors.greenAccent;
      case 'Poison':
        return Colors.deepPurple.shade300;
      case 'Electric':
        return Colors.yellow.shade300;
      case 'Bug':
        return Colors.deepOrange.shade300;
      case 'Normal':
        return Colors.teal.shade200;
      default:
        return Colors.white38;
    }
  }

  void fetchData() async {
    var url = Uri.https(
      "raw.githubusercontent.com",
      "Biuni/PokemonGO-Pokedex/master/pokedex.json",
    );
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        var decodedData = jsonDecode(value.body);
        pokepedia = decodedData["pokemon"];
        setState(() {});
      }
    });
  }
}
