import 'package:flutter/material.dart';
import 'package:flutter_application_1/favorite/bloc/favorite_bloc.dart';
import 'package:flutter_application_1/utils/ui/character_list_cell.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/detail_character/page/detail_character_page.dart';

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rick & Morty',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocListener<FavoriteBloc, FavoriteState>(
          listener: (context, state) {
            if (state is FavoriteShowDetail) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailCharacterPage(
                    characterId: state.characterId,
                  ),
                ),
              ).then((_) {
                context.read<FavoriteBloc>().add(FavoriteOnReturned());
              });
            }
          },
          child: BlocBuilder<FavoriteBloc, FavoriteState>(
              builder: (context, state) {
            return Padding(
              padding: const EdgeInsetsGeometry.only(
                left: 8,
                right: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Сортировка',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 3,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'По имени',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        TextField(
                          onChanged: (value) {
                            context
                                .read<FavoriteBloc>()
                                .add(FavoriteOnSorting(sortingName: value));
                          },
                          decoration: const InputDecoration(
                            hintText: 'Введите имя',
                          ),
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => CharacterListCell(
                        model: state.characters[index],
                        onTap: () {
                          context
                              .read<FavoriteBloc>()
                              .add(FavoriteOnCharacter(index: index));
                        },
                        onTapStar: () {
                          context
                              .read<FavoriteBloc>()
                              .add(FavoriteOnCharacterFavorite(
                                index: index,
                              ));
                        },
                      ),
                      separatorBuilder: (context, _) => const SizedBox(
                        height: 4,
                      ),
                      itemCount: state.characters.length,
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
