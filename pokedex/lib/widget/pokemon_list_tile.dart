import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/provider/pokemon_data_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemonListTile extends ConsumerWidget {
  PokemonListTile({super.key, required this.pokemonurl});

  late FavoritePokemonProvider _favoritePokemonProvider;
  late List<String> _favoritePokemon;

  final String pokemonurl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _favoritePokemonProvider = ref.watch(favoritePokemonProvider.notifier);
    _favoritePokemon = ref.watch(favoritePokemonProvider);
    final pokemon = ref.watch(pokemonDataProvider(pokemonurl));
    return pokemon.when(data: (data) {
      return _tile(context, false, data);
    }, error: (error, stackTrace) {
      return Text("Error: $error");
    }, loading: () {
      return _tile(context, true, null);
    });
  }

  Widget _tile(BuildContext context, bool isLoading, Pokemon? pokemon) {
    return Skeletonizer(
      enabled: isLoading,
      child: ListTile(
        leading: pokemon != null
            ? CircleAvatar(
                backgroundImage: NetworkImage(pokemon.sprites!.frontDefault!),
              )
            : CircleAvatar(),
        title: Text(pokemon != null
            ? pokemon.name!.toUpperCase()
            : "Currently loading your Pokemon"),
        subtitle: Text("Has ${pokemon?.moves?.length.toString() ?? 0} moves"),
        trailing: IconButton(
            onPressed: () {
              if (_favoritePokemon.contains(pokemonurl)) {
                _favoritePokemonProvider.removePokemon(pokemonurl);
              } else {
                _favoritePokemonProvider.addPokemon(pokemonurl);
              }
              ;
            },
            icon: Icon(
              _favoritePokemon.contains(pokemonurl)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red,
            )),
      ),
    );
  }
}
