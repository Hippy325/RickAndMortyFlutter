part of 'character_list_bloc.dart';

abstract class CharacterListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CharacterListOnAppear extends CharacterListEvent {}

class CharacterListOnMoreLoading extends CharacterListEvent {}

class CharacterListOnReturned extends CharacterListEvent {}

class CharacterListOnCharacter extends CharacterListEvent {
  final int index;

  CharacterListOnCharacter({
    required this.index,
  });

  @override
  List<Object?> get props => [index];
}

class CharacterListOnCharacterFavorite extends CharacterListEvent {
  final int index;

  CharacterListOnCharacterFavorite({
    required this.index,
  });

  @override
  List<Object?> get props => [index];
}