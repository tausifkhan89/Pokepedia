import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PokemonDetails extends StatefulWidget {
  final int tag;
  final Map<String, dynamic> details;
  final Color color;

  const PokemonDetails({
    super.key,
    required this.tag,
    required this.details,
    required this.color,
  });

  @override
  State<PokemonDetails> createState() => _PokemonDetailsState();
}

class _PokemonDetailsState extends State<PokemonDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color,
      appBar: AppBar(
        title: Text(
          widget.details['name'].toString(),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            shadows: [
              Shadow(
                color: Colors.black,
                blurRadius: 2,
                offset: Offset(0.5, 0.5),
              ),
            ],
          ),
        ),
        backgroundColor: widget.color,
        foregroundColor: Colors.white,

        centerTitle: true,
        elevation: 0,
        surfaceTintColor: widget.color,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: widget.details['img'],
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Details Container
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    // Name
                    detailsText('Name', widget.details['name']),

                    // Type
                    detailsText('Type', widget.details['type'][0]),

                    // Height
                    detailsText('Height', widget.details['height']),

                    // Weight
                    detailsText('Weight', widget.details['weight']),

                    // Spawn Time
                    detailsText(
                      'Spawn Chance',
                      widget.details['spawn_chance'].toString(),
                    ),

                    // Weakness
                    detailsText(
                      'Weakness',
                      widget.details['weaknesses'].join(', '),
                    ),

                    // Evolution,
                    if (widget.details['prev_evolution'] != null)
                      detailsText(
                        'Previous Evolution',
                        (widget.details['prev_evolution'] as List)
                            .map((e) => e['name'])
                            .join(', '),
                      ),

                    if (widget.details['next_evolution'] != null)
                      detailsText(
                        'Next Evolution',
                        (widget.details['next_evolution'] as List)
                            .map((e) => e['name'])
                            .join(', '),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget detailsText(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: (MediaQuery.of(context).size.width / 3) + 15,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
