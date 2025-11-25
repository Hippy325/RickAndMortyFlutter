import 'package:flutter/material.dart';
import 'package:flutter_application_1/character_service/character_service_impl.dart';
import 'package:flutter_application_1/detail_character/bloc/detail_character_bloc.dart';
import 'package:flutter_application_1/detail_character/widgets/detail_character.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailCharacterPage extends StatelessWidget {
  final int characterId;

  const DetailCharacterPage({
    super.key,
    required this.characterId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailCharacterBloc(
        characterId: characterId,
        service: CharacterServiceImpl(),
      )..add(DetailCharacterOnAppear()),
      child: const DetailCharacterWidget(),
    );
  }
}
