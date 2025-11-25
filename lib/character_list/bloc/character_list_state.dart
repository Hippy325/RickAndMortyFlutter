part of 'character_list_bloc.dart';

abstract class CharacterListState extends Equatable {
  final List<Character> data;
  final Loading? loading;

  const CharacterListState({
    required this.data,
    required this.loading,
  });

  @override
  List<Object?> get props => [data, loading];
}

enum Loading { initialLoading, moreLoading }

class CharacterListInitial extends CharacterListState {
  const CharacterListInitial({
    required super.data,
    required super.loading,
  });
}

class CharacterListUpdated extends CharacterListState {
  const CharacterListUpdated({
    required super.data,
    required super.loading,
  });
}

class CharacterListError extends CharacterListState {
  final String error;

  const CharacterListError({
    required super.data,
    required super.loading,
    required this.error,
  });

  @override
  List<Object?> get props => [super.props, error];
}

class CharacterListShowDetail extends CharacterListState {
  final int characterId;

  const CharacterListShowDetail({
    required super.data,
    required super.loading,
    required this.characterId,
  });

  @override
  List<Object?> get props => [super.props, characterId];
}
