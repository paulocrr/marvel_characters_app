import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Networking {
  late Dio _client;

  Networking({Dio? client}) {
    if (client == null) {
      _client = Dio(
        BaseOptions(baseUrl: dotenv.env['URL']!),
      );
    } else {
      _client = client;
    }
  }

  String get _signParameters {
    final timestamp = DateTime.now().toString();
    final publicKey = dotenv.env['PUBLIC_KEY']!;
    final privateKey = dotenv.env['PRIVATE_KEY']!;

    final hash = md5
        .convert(
          utf8.encode('$timestamp$privateKey$publicKey'),
        )
        .toString();

    return 'ts=$timestamp&apikey=$publicKey&hash=$hash';
  }

  Future<Map<String, dynamic>> get({
    required String path,
    String? params,
  }) async {
    final result = await _client.get('$path?$_signParameters&$params');

    return result.data['data'];
  }
}
