import 'package:flutter/material.dart';
import 'package:marvel_characters_app/models/character.dart';

class CharacterItem extends StatelessWidget {
  final Character character;
  final VoidCallback? onTap;

  const CharacterItem({super.key, required this.character, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(character.thumbnail ?? ""),
      ),
      title: Text(character.name ?? ""),
      onTap: onTap,
    );
  }
}
