import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

class Networking {
  late Dio _client;

  Networking({Dio? client}) {
    if (client == null) {
      _client = Dio(
        BaseOptions(baseUrl: 'http://gateway.marvel.com'),
      );
    } else {
      _client = client;
    }
  }

  String get _signParameters {
    final timestamp = DateTime.now().toString();
    final publicKey = '7e34ba9cf61f21b17560f16cd58ea6e6';
    final privateKey = 'f2040fe74a6cd6debd4fb4e177d096677d1ded23';

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
