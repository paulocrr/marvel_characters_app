import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:marvel_characters_app/models/character.dart';
import 'package:marvel_characters_app/pages/character_details_page.dart';
import 'package:marvel_characters_app/services/characters_service.dart';
import 'package:marvel_characters_app/widgets/character_item.dart';
import 'package:marvel_characters_app/widgets/marvel_progress_indicator.dart';

class ListCharactersPage extends StatefulWidget {
  const ListCharactersPage({super.key});

  @override
  State<ListCharactersPage> createState() => _ListCharactersPageState();
}

class _ListCharactersPageState extends State<ListCharactersPage> {
  static const _pageSize = 10;
  static const _offsetSize = 10;

  final _service = CharactersService();
  final _pagingController = PagingController<int, Character>(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  void _fetchPage(int offset) async {
    try {
      final response =
          await _service.getCharacters(offset: offset, pageSize: _pageSize);
      final isLastPage = (response.count ?? 0) < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(response.result);
      } else {
        final nextPage = offset + _offsetSize;
        _pagingController.appendPage(response.result, nextPage);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Personajes'),
      ),
      body: PagedListView(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Character>(
          itemBuilder: (_, item, index) {
            return CharacterItem(
              character: item,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CharacterDetailsPage(id: item.id),
                  ),
                );
              },
            );
          },
          firstPageProgressIndicatorBuilder: (_) =>
              const MarvelProgressIndicator(),
          newPageProgressIndicatorBuilder: (_) =>
              const MarvelProgressIndicator(),
        ),
      ),
    );
  }
}
