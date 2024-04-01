part of 'character_list_bloc.dart';

class CharacterListState {
  final List<Character>? data;

  CharacterListState({required this.data});
}

class CharacterListInitial extends CharacterListState { 
  CharacterListInitial({ super.data });
}

class CharacterListLoading extends CharacterListState {
  CharacterListLoading({ super.data });
}

class CharacterListLoaded extends CharacterListState {
  CharacterListLoaded({ super.data });
}