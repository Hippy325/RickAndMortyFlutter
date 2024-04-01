import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/DetailCharacter/bloc/detail_character_bloc.dart';
import 'package:flutter_application_1/Service/Models/character.dart';
import 'package:flutter_application_1/Service/character_loader.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

class DetailCharacterWidget extends StatefulWidget {

  final int index;
  const DetailCharacterWidget({required this.index, super.key});

  @override
  State<DetailCharacterWidget> createState() => _DetailCharacterWidgetState(index);
}

class _DetailCharacterWidgetState extends State<DetailCharacterWidget> {

  late DetailCharacterBloc detailBloc;
  
  _DetailCharacterWidgetState(int index) {
    detailBloc = DetailCharacterBloc(CharacterLoader(), index);
  }

  @override
  void initState() {
    detailBloc.add(Loading());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailCharacterBloc, DetailCharacterState>(
      bloc: detailBloc,
      builder: (context, state) {
        if (state is DetailCharacterLoading) {
          return indicatorLoading(state);
        } else if (state is DetailCharacterLoaded) {
          return characterLoaded(state);
        } else {
          return Container();
        }
      }
    );
  }

Widget indicatorLoading(DetailCharacterLoading state) {
  return Scaffold(
    backgroundColor: const Color.fromARGB(255, 175, 203, 225),
    body: Center(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        height: 100,
        width: 100,
        child: const Center(child: SizedBox(height: 50, width: 50, child: LoadingIndicator(indicatorType: Indicator.lineSpinFadeLoader, colors: [Colors.red],),)),
      ),
    ),
  );
}

Widget characterLoaded(DetailCharacterLoaded state) {
  final character = state.character;
  return Scaffold(
    appBar: AppBar(title: Text(character?.name ?? '', style: const TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),)),
    backgroundColor: const Color.fromARGB(255, 175, 203, 225),
    body: Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
          avatarLoading(character?.image),
          characterParams(character)
        ],),
      )
    );
  }

  Widget avatarLoading(String? imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Image.network(
        imageUrl ?? '',
        fit: BoxFit.cover,
        width: double.infinity,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
            ),
          );
        },
      ),
    );
  }

  Widget characterParams(Character? character) {
    return Column(
      children: [
        Text(character == null ? '' : 'race: ${character.species}', style: const TextStyle(fontSize: 20),),
        Text(character == null ? '' : 'gender: ${character.gender}', style: const TextStyle(fontSize: 20),),
        Text(character == null ? '' : 'status: ${character.status}', style: const TextStyle(fontSize: 20),),
        Text(character == null ? '' : 'episodes: ${character.episode.length}', style: const TextStyle(fontSize: 20),),
      ],
    );
  }
}