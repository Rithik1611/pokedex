import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/controller/home_page_controller.dart';
import 'package:pokedex/models/page_data.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/widget/pokemon_list_tile.dart';

final homePageControllerProvider =
    StateNotifierProvider<HomePageController, HomePageData>(
  (ref) {
    return HomePageController(HomePageData.initial());
  },
);

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late HomePageController _homePageController;
  late HomePageData _homePageData;

  @override
  Widget build(BuildContext context) {
    _homePageController = ref.watch(homePageControllerProvider.notifier);
    _homePageData = ref.watch(homePageControllerProvider);
    return _buildUI(context);
  }

  Widget _buildUI(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.02,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_allPokemon(context)],
            ),
          ),
        ),
      ),
    );
  }

  Widget _allPokemon(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "All Pokemons",
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.60,
            child: ListView.builder(
              itemCount: _homePageData.data?.results?.length ?? 0,
              itemBuilder: (context, index) {
                PokemonListResult pokemon = _homePageData.data!.results![index];
                return PokemonListTile(pokemonurl: pokemon.url!);
              },
            ),
          )
        ],
      ),
    );
  }
}
