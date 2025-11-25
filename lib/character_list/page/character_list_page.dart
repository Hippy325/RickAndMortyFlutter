import 'package:flutter/material.dart';
import 'package:flutter_application_1/character_list/bloc/character_list_bloc.dart';
import 'package:flutter_application_1/character_list/widgets/character_list_widget.dart';
import 'package:flutter_application_1/character_service/character_service_impl.dart';
import 'package:flutter_application_1/utils/image_service/image_service_impl.dart';
import 'package:flutter_application_1/utils/shared/shared_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterListPage extends StatelessWidget {
  const CharacterListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharacterListBloc(
        service: CharacterServiceImpl(),
        shared: SharedImpl(),
        imageService: ImageServiceImpl(),
      )..add(CharacterListOnAppear()),
      child: const CharacterListWidget(),
    );
  }
}
