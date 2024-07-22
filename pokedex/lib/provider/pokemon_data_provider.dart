import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/services/https_service.dart';

final pokemonDataProvider = FutureProvider.family<Pokemon?, String>(
  (ref, url) async {
    HttpsService _httpsService = GetIt.instance.get<HttpsService>();
    Response? res = await _httpsService.get(url);
    if (res != null && res.data != null) {
      return Pokemon.fromJson(res.data!);
    }
    return null;
  },
);
