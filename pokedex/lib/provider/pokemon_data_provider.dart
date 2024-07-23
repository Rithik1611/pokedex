import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/services/https_service.dart';
import 'package:pokedex/widget/database_service.dart';

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

final favoritePokemonProvider =
    StateNotifierProvider<FavoritePokemonProvider, List<String>>((ref) {
  return FavoritePokemonProvider([]);
});

class FavoritePokemonProvider extends StateNotifier<List<String>> {
  final DatabaseService _databaseService =
      GetIt.instance.get<DatabaseService>();

  String Favorite_pokemon_list = "Favorite_pokemon_list";
  FavoritePokemonProvider(super._state) {
    setup();
  }

  Future<void> setup() async {
    List<String>? result =
        await _databaseService.getList(Favorite_pokemon_list, _state);
    state = result ?? [];
  }

  void addPokemon(String url) {
    state = [...state, url];
    _databaseService.saveList(Favorite_pokemon_list, state);
  }

  void removePokemon(String url) {
    state = state.where((e) => e != url).toList();
    _databaseService.saveList(Favorite_pokemon_list, state);
  }
}
