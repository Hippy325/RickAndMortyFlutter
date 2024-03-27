
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/DetailCharacter/detail_character.dart';
import 'package:flutter_application_1/Service/Models/character.dart';
import 'package:flutter_application_1/Service/character_page_loader.dart';

class CharacterListWidget extends StatefulWidget {

  const CharacterListWidget({ super.key });

  @override
  State<StatefulWidget> createState() { return CharacterListWidgetState(); }
}

class CharacterListWidgetState extends State<CharacterListWidget> {

  List<Character> data = [];
  var isFinished = false;
  final ScrollController _scrollController = ScrollController();
  final CharacterPageLoader service = CharacterPageLoader();

  void loadData() async {
    var response = await service.loadNextPage();
    if (response == null) {
      return;
    }

    data += response.results;
    setState(() {});
  }

  @override
  void initState() {
    _scrollController.addListener(_loadMoreData);
    loadData();
    super.initState();
  }

    void _loadMoreData() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick && Morty', style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),),
      ),
      body: 
        Stack(children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/backgrpund.jpeg'), fit: BoxFit.fill)
            ),
          ),
          Padding(padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
              controller: _scrollController,
              itemCount: data.length,
              itemBuilder: (_, i) => ListViewCell(data[i]), 
              separatorBuilder: (_, i) => const Divider(),
            ),
          )        
        ]),
    );
  }
}

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
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
            ),
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