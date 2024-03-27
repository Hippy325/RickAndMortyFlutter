import 'package:flutter/material.dart';
import 'package:flutter_application_1/Service/Models/character.dart';
import 'package:flutter_application_1/Service/character_loader.dart';

class DetailCharacterWidget extends StatefulWidget {

  final int index;
  const DetailCharacterWidget({required this.index, super.key});

  @override
  State<DetailCharacterWidget> createState() => _DetailCharacterWidgetState(index: index);
}

class _DetailCharacterWidgetState extends State<DetailCharacterWidget> {

  final int index;
  Character? character;
  final service = CharacterLoader();
  _DetailCharacterWidgetState({required this.index});

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    var response = await service.load(index);
    if (response == null) {
      return;
    }
    character = response;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character?.name ?? '', style: const TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),)
      ),
      backgroundColor: const Color.fromARGB(255, 175, 203, 225),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Image.network(
            character?.image ?? '',
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
          ),
          Column(
            children: [
              Text(character == null ? '' : 'race: ${character?.species}', style: const TextStyle(fontSize: 20),),
              Text(character == null ? '' : 'gender: ${character?.gender}', style: const TextStyle(fontSize: 20),),
              Text(character == null ? '' : 'status: ${character?.status}', style: const TextStyle(fontSize: 20),),
              // Text(character == null ? '' : 'race: ${character?}', style: TextStyle(fontSize: 20),),
              Text(character == null ? '' : 'episodes: ${character?.episode.length}', style: const TextStyle(fontSize: 20),),
            ],
          ),
        ],),
        )
    );
  }
}