import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/character_list/models/character.dart';
import 'package:flutter_application_1/utils/image_service/image_service.dart';
import 'package:flutter_application_1/utils/shared/shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final Shared shared;
  final ImageService imageService;

  List<Character> characters = [];

  FavoriteBloc({
    required this.imageService,
    required this.shared,
  }) : super(const FavoriteInitial(
          characters: [],
        )) {
    on<FavoriteOnAppear>((event, emit) async {
      characters = await shared.getAllCharacters();
      _updating(emit);
    });
    on<FavoriteOnCharacter>((event, emit) {
      emit(FavoriteShowDetail(
        characters: characters,
        characterId: characters[event.index].id,
      ));
    });
    on<FavoriteOnCharacterFavorite>((event, emit) async {
      await shared.removeCharacter(characters[event.index].id);
      await imageService.deleteImage(characters[event.index].imageNameLocal);
      characters.removeAt(event.index);
      _updating(emit);
    });
    on<FavoriteOnReturned>((event, emit) async {
      _updating(emit);
    });
  }

  _updating(Emitter<FavoriteState> emit) {
    emit(FavoriteUpdated(
      characters: List<Character>.from(characters),
    ));
  }
}
