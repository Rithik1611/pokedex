import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/models/page_data.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/services/https_service.dart';

class HomePageController extends StateNotifier<HomePageData> {
  final GetIt _getIt = GetIt.instance;
  late HttpsService _httpsService;

  HomePageController(super._state) {
    _httpsService = _getIt.get<HttpsService>();
    setup();
  }
  Future<void> setup() async {
    loaddata();
  }

  Future<void> loaddata() async {
    if (state.data == null) {
      Response? res = await _httpsService
          .get("https://pokeapi.co/api/v2/pokemon?limit=20&offset=0");
      if (res != null && res.data != null) {
        PokemonListData data = PokemonListData.fromJson(res.data);
        state = state.copyWith(data: data);
        print(state.data?.results?.first);
      }
    } else {}
  }
}
