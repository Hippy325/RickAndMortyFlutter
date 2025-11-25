import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/character_list/models/character.dart';
import 'package:flutter_application_1/character_service/character_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detail_character_state.dart';
part 'detail_character_event.dart';

class DetailCharacterBloc
    extends Bloc<DetailCharacterEvent, DetailCharacterState> {
  final CharacterService service;
  final int characterId;
  Loading? loading;
  Character? character;

  DetailCharacterBloc({
    required this.characterId,
    required this.service,
  }) : super(const DetailCharacterInitial(
          loading: Loading.initialLoading,
          character: null,
        )) {
    on<DetailCharacterOnAppear>((event, emit) async {
      var response = await service.load(characterId);
      loading = null;
      if (response != null) {
        character = Character.fromDto(response);
      } else {}
      emit(DetailCharacterUpdated(
        loading: loading,
        character: character,
      ));
    });
  }
}
