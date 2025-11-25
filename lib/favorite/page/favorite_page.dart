import 'package:flutter/material.dart';
import 'package:flutter_application_1/favorite/bloc/favorite_bloc.dart';
import 'package:flutter_application_1/favorite/widgets/favorite_widget.dart';
import 'package:flutter_application_1/utils/image_service/image_service_impl.dart';
import 'package:flutter_application_1/utils/shared/shared_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteBloc(
        shared: SharedImpl(),
        imageService: ImageServiceImpl(),
      )..add(FavoriteOnAppear()),
      child: const FavoriteWidget(),
    );
  }
}
