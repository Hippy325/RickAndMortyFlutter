part of 'detail_character_bloc.dart';

abstract class DetailCharacterState extends Equatable {
  final Loading? loading;
  final Character? character;

  const DetailCharacterState({
    required this.loading,
    required this.character,
  });

  @override
  List<Object?> get props => [loading, character];
}

enum Loading { initialLoading }

class DetailCharacterInitial extends DetailCharacterState {
  const DetailCharacterInitial({
    required super.loading,
    required super.character,
  });
}

class DetailCharacterUpdated extends DetailCharacterState {
  const DetailCharacterUpdated({
    required super.loading,
    required super.character,
  });
}
