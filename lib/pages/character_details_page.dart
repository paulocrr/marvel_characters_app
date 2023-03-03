import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marvel_characters_app/models/character_details.dart';
import 'package:marvel_characters_app/services/characters_service.dart';
import 'package:marvel_characters_app/widgets/bullet_text.dart';
import 'package:marvel_characters_app/widgets/marvel_progress_indicator.dart';

class CharacterDetailsPage extends StatelessWidget {
  final int id;
  final _service = CharactersService();

  CharacterDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalles')),
      body: FutureBuilder(
        future: _service.getCharacterDetails(id: id),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MarvelProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return _DetailsInformation(details: snapshot.data!);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return const Text('No hay informacion');
            }
          } else {
            return Text('Estado: ${snapshot.connectionState}');
          }
        },
      ),
    );
  }
}

class _DetailsInformation extends StatelessWidget {
  final CharacterDetails details;

  const _DetailsInformation({required this.details});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Hero(
          tag: details.id,
          child: CachedNetworkImage(
            imageUrl: details.thumbnail ?? "",
            progressIndicatorBuilder: (_, __, downloadProgress) =>
                LinearProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          details.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Descripcion',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              if (details.description == null || details.description == '') ...[
                const Text('La description de este heroe no esta disponible')
              ] else ...[
                Text(details.description!)
              ],
              const SizedBox(height: 8),
              const Divider(color: Colors.red),
              const Text(
                'Comics en los que aparece',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...details.comics
                  .map(
                    (comic) => BulletText(text: comic.name),
                  )
                  .toList()
            ],
          ),
        )
      ],
    );
  }
}
