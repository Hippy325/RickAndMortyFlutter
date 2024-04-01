part of 'detail_character_bloc.dart';

class DetailCharacterState {}

class DetailCharacterInitial extends DetailCharacterState {}

class DetailCharacterLoading extends DetailCharacterState {}

class DetailCharacterLoaded extends DetailCharacterState {
  final Character? character;
  
  DetailCharacterLoaded({ this.character });
}