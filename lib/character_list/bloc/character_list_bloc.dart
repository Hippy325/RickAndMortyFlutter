import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/character_list/models/character.dart';
import 'package:flutter_application_1/character_service/character_service.dart';
import 'package:flutter_application_1/utils/image_service/image_service.dart';
import 'package:flutter_application_1/utils/shared/shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'character_list_event.dart';
part 'character_list_state.dart';

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {
  final CharacterService service;
  final Shared shared;
  final ImageService imageService;

  String? _nextPageUrl;
  List<Character> data = [];
  Loading? loading = Loading.initialLoading;

  CharacterListBloc({
    required this.service,
    required this.shared,
    required this.imageService,
  }) : super(const CharacterListInitial(
          data: [],
          loading: Loading.initialLoading,
        )) {
    on<CharacterListOnAppear>((event, emit) async {
      loading = null;
      await _nextLoading(emit);
    });
    on<CharacterListOnMoreLoading>((event, emit) async {
      if (_nextPageUrl == null) return;
      loading = Loading.moreLoading;
      _updating(emit);
      loading = null;
      await _nextLoading(emit);
    });
    on<CharacterListOnCharacter>((event, emit) {
      emit(CharacterListShowDetail(
        data: data,
        loading: loading,
        characterId: event.index + 1,
      ));
    });
    on<CharacterListOnCharacterFavorite>((event, emit) async {
      loading = Loading.moreLoading;
      _updating(emit);
      loading = null;
      bool isNewFavorite = !data[event.index].isFavorite;
      if (isNewFavorite) {
        var path = await imageService.saveImage(
          data[event.index].image,
          data[event.index].id,
        );
        data[event.index] = data[event.index].copyWith(
          isFavorite: isNewFavorite,
          imageNameLocal: path,
        );
        await shared.addCharacter(data[event.index]);
      } else {
        await shared.removeCharacter(data[event.index].id);
        await imageService.deleteImage(data[event.index].imageNameLocal);
        data[event.index] = data[event.index].copyWith(isFavorite: false);
      }
      _updating(emit);
    });
    on<CharacterListOnReturned>((event, emit) async {
      _updating(emit);
    });
  }

  Future<void> _nextLoading(Emitter<CharacterListState> emit) async {
    var response = await service.loadNextPage(
      nextPageUrl: _nextPageUrl,
    );
    var sharedCharacters = await shared.getAllCharacters();
    if (response != null) {
      _nextPageUrl = response.info?.next;
      var characters =
          response.results.map((dto) => Character.fromDto(dto)).toList();
      for (var i = 0; i < characters.length; i++) {
        for (var j = 0; j < sharedCharacters.length; j++) {
          if (sharedCharacters[j].id == characters[i].id) {
            characters[i] = characters[i].copyWith(
              isFavorite: true,
              imageNameLocal: sharedCharacters[j].imageNameLocal,
            );
          }
        }
      }
      data += characters;
      _updating(emit);
    } else {
      emit(CharacterListError(
        data: data,
        loading: loading,
        error: 'Ошибка получения данных',
      ));
    }
  }

  _updating(Emitter<CharacterListState> emit) {
    emit(CharacterListUpdated(
      data: List<Character>.from(data),
      loading: loading,
    ));
  }
}
