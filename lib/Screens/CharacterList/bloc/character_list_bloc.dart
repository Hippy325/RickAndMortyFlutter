
import 'package:flutter_application_1/Service/Models/character.dart';
import 'package:flutter_application_1/Service/character_page_loader.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'character_list_event.dart';
part 'character_list_state.dart';

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {
  CharacterListBloc(this.service) : super(CharacterListInitial()) {
    on<Loading>((event, emit) async {
      emit(CharacterListLoading(data: data));
      await loading(emit);
    });
  }
    
  Future<void> loading(Emitter<CharacterListState> emit) async {
    final response = await service.loadNextPage();
    data += response?.results ?? [];
    emit(CharacterListLoaded(data: data));
  }

  List<Character> data = [];
  final CharacterPageLoader service;
}