import 'package:flutter/material.dart';
import 'package:flutter_application_1/character_list/models/character.dart';
import 'package:flutter_application_1/detail_character/bloc/detail_character_bloc.dart';
import 'package:flutter_application_1/utils/ui/custom_image_widget.dart';
import 'package:flutter_application_1/utils/ui/loading_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailCharacterWidget extends StatefulWidget {
  const DetailCharacterWidget({super.key});

  @override
  State<DetailCharacterWidget> createState() => _DetailCharacterWidgetState();
}

class _DetailCharacterWidgetState extends State<DetailCharacterWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<DetailCharacterBloc, DetailCharacterState>(
          builder: (context, state) {
            return Text(
              state.character?.name ?? 'Rick && Morty',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ),
      body: BlocBuilder<DetailCharacterBloc, DetailCharacterState>(
          builder: (context, state) {
        return LoadingIndicator(
          initialLoading: state.loading == Loading.initialLoading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: CustomImageWidget(
                  url: state.character?.image ?? '',
                  fileName: state.character?.imageNameLocal,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              characterParams(state.character)
            ],
          ),
        );
      }),
    );
  }

  Widget characterParams(Character? character) {
    return Padding(
      padding: const EdgeInsetsGeometry.only(left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            character == null ? '' : 'race: ${character.species}',
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            character == null ? '' : 'gender: ${character.gender}',
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            character == null ? '' : 'status: ${character.status}',
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            character == null ? '' : 'episodes: ${character.episode.length}',
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
