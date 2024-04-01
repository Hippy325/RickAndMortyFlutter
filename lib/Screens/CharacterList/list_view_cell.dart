import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/DetailCharacter/detail_character.dart';
import 'package:flutter_application_1/Service/Models/character.dart';

class ListViewCell extends StatefulWidget {
  final Character model;
  const ListViewCell(this.model, {super.key});

  @override
  State<StatefulWidget> createState() => ListViewCellState(model);
}

class ListViewCellState extends State<ListViewCell> {
  Character model;
  ListViewCellState(this.model);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(model.name, style: const TextStyle(fontSize: 25, color: Colors.black),),
      subtitle: Text('${model.species} ${model.gender}'),
      leading: Image.network(
        model.image,
        fit: BoxFit.fill,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
            );
        },
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DetailCharacterWidget(index: model.id))
        );
      },
    ); 
  }
}