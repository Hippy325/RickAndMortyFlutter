part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoriteOnAppear extends FavoriteEvent {}

class FavoriteOnCharacter extends FavoriteEvent {
  final int index;

  FavoriteOnCharacter({
    required this.index,
  });

  @override
  List<Object?> get props => [index];
}

class FavoriteOnCharacterFavorite extends FavoriteEvent {
  final int index;

  FavoriteOnCharacterFavorite({
    required this.index,
  });

  @override
  List<Object?> get props => [index];
}

class FavoriteOnReturned extends FavoriteEvent {}