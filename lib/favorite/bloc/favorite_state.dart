part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  final List<Character> characters;

  const FavoriteState({
    required this.characters,
  });

  @override
  List<Object?> get props => [characters];
}

class FavoriteInitial extends FavoriteState {
  const FavoriteInitial({
    required super.characters,
  });
}

class FavoriteShowDetail extends FavoriteState {
  final int characterId;

  const FavoriteShowDetail({
    required super.characters,
    required this.characterId,
  });

  @override
  List<Object?> get props => [super.props, characterId];
}

class FavoriteUpdated extends FavoriteState {
  const FavoriteUpdated({
    required super.characters,
  });
}
