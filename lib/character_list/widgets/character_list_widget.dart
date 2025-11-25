import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/funcs/show_error_alert.dart';
import 'package:flutter_application_1/utils/ui/loading_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/character_list/bloc/character_list_bloc.dart';
import 'package:flutter_application_1/utils/ui/character_list_cell.dart';
import 'package:flutter_application_1/detail_character/page/detail_character_page.dart';

class CharacterListWidget extends StatefulWidget {
  const CharacterListWidget({super.key});

  @override
  State<CharacterListWidget> createState() => _CharacterListWidgetState();
}

class _CharacterListWidgetState extends State<CharacterListWidget> {
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
        child: BlocListener<CharacterListBloc, CharacterListState>(
          listener: (context, state) {
            if (state is CharacterListShowDetail) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailCharacterPage(
                    characterId: state.characterId,
                  ),
                ),
              ).then((_) {
                context
                    .read<CharacterListBloc>()
                    .add(CharacterListOnReturned());
              });
            }
            if (state is CharacterListError) {
              showErrorAlert(
                context: context,
                error: state.error,
              );
            }
          },
          child: BlocBuilder<CharacterListBloc, CharacterListState>(
            builder: (context, state) {
              return LoadingIndicator(
                initialLoading: state.loading == Loading.initialLoading,
                loading: state.loading == Loading.moreLoading,
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollInfo) {
                    final metrics = scrollInfo.metrics;
                    if (metrics.pixels >= metrics.maxScrollExtent - 100 &&
                        state.loading != Loading.moreLoading) {
                      context
                          .read<CharacterListBloc>()
                          .add(CharacterListOnMoreLoading());
                    }
                    return false;
                  },
                  child: CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.all(8),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return CharacterListCell(
                                model: state.data[index],
                                onTap: () {
                                  context
                                      .read<CharacterListBloc>()
                                      .add(CharacterListOnCharacter(
                                        index: index,
                                      ));
                                },
                                onTapStar: () {
                                  context
                                      .read<CharacterListBloc>()
                                      .add(CharacterListOnCharacterFavorite(
                                        index: index,
                                      ));
                                },
                              );
                            },
                            childCount: state.data.length,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: state.loading == Loading.moreLoading
                            ? const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child:
                                    Center(child: CircularProgressIndicator()),
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
