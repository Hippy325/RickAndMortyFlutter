import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/CharacterList/list_view_cell.dart';
import 'package:flutter_application_1/Screens/CharacterList/bloc/character_list_bloc.dart';
import 'package:flutter_application_1/Service/character_page_loader.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CharacterListWidget extends StatefulWidget {

  const CharacterListWidget({ super.key });

  @override
  State<StatefulWidget> createState() { return CharacterListWidgetState(); }
}

class CharacterListWidgetState extends State<CharacterListWidget> {
  final ScrollController _scrollController = ScrollController();
  final characterBloc = CharacterListBloc(CharacterPageLoader());

  @override
  void initState() {
    _scrollController.addListener(_loadMoreData);
    characterBloc.add(Loading());
    super.initState();
  }

  void _loadMoreData() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      characterBloc.add(Loading());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick && Morty', style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),),
      ),
      body: 
        BlocBuilder<CharacterListBloc, CharacterListState>(
          bloc: characterBloc,
          builder: (context, state) {
              return Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/images/backgrpund.jpeg'), fit: BoxFit.fill)
                    ),
                  ),
                  characterListView(state),
                  indicatorLoading(state)
                ],
              );
            }
        )
    );
  }

  Widget characterListView(CharacterListState state) {
    if (state.data != null) {
      return Padding(
        padding: const  EdgeInsets.all(8),
        child: ListView.separated(
          controller: _scrollController,
          itemCount: state.data!.length,
          itemBuilder: (_, i) => ListViewCell(state.data![i]), 
          separatorBuilder: (_, i) => const Divider(),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget indicatorLoading(CharacterListState state) {
    if (state is CharacterListLoading) {
      return Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.black45,
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          height: 100,
          width: 100,
          child: const Center(child: SizedBox(height: 50, width: 50, child: LoadingIndicator(indicatorType: Indicator.lineSpinFadeLoader, colors: [Colors.red],),)),
        ),
      );
    } else {
      return Container();
    }
  }
}