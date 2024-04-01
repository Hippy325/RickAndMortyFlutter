
import 'package:flutter_application_1/Service/Models/character.dart';
import 'package:flutter_application_1/Service/character_loader.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detail_character_state.dart';
part 'detail_character_event.dart';

class DetailCharacterBloc extends Bloc<DetailCharacterEvent, DetailCharacterState> {
 
  DetailCharacterBloc(this.service, int index) : super(DetailCharacterInitial()) {
    on<Loading>((event, emit) async {
      emit(DetailCharacterLoading());
      final response = await service.load(index);
      emit(DetailCharacterLoaded(character: response));
    });
  }

  final CharacterLoader service;
}