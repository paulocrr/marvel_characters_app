import 'package:marvel_characters_app/core/networking.dart';
import 'package:marvel_characters_app/models/characters_response.dart';

class CharactersService {
  late Networking _client;
  final _path = '/v1/public/characters';

  CharactersService({Networking? client}) {
    if (client == null) {
      _client = Networking();
    } else {
      _client = client;
    }
  }

  Future<CharactersResponse> getCharacters({
    int offset = 0,
    int pageSize = 10,
  }) async {
    final response = await _client.get(
      path: _path,
      params: 'offset=$offset&limit=$pageSize',
    );

    return CharactersResponse.fromJson(response);
  }
}
