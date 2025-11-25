import 'package:flutter/material.dart';
import 'package:flutter_application_1/character_list/models/character.dart';
import 'package:flutter_application_1/utils/ui/custom_image_widget.dart';

class CharacterListCell extends StatelessWidget {
  final Character model;
  final VoidCallback onTap;
  final VoidCallback onTapStar;

  const CharacterListCell({
    required this.model,
    required this.onTap,
    required this.onTapStar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap.call,
      child: Padding(
        padding: const EdgeInsetsGeometry.all(8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 15,
                offset: const Offset(0, 6),
              )
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.horizontal(
                    left: const Radius.circular(8),
                  ),
                  child: CustomImageWidget(
                    url: model.image,
                    fileName: model.imageNameLocal,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsGeometry.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.name,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              maxLines: 2,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              'race: ${model.species}\ngender: ${model.gender}',
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsGeometry.only(left: 6),
                        child: GestureDetector(
                          onTap: onTapStar.call,
                          child: Icon(
                            model.isFavorite ? Icons.star : Icons.star_border,
                            color: Colors.yellow[700],
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
