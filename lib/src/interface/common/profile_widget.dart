import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sweet_chores_reloaded/src/core/app_export.dart';
import 'package:sweet_chores_reloaded/src/data/data_source.dart';

// TODO, ADAPT TO SWEECHORES WITH DRAWER HEADER
class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
    required this.name,
    this.lema,
    this.width = 100,
    this.photoURL,
  });
  final String? photoURL;
  final String name;
  final double width;
  final String? lema;
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        color: Theme.of(context).colorScheme.primary,
        child: photoURL != null
            ? ListTile(
                leading: _getImage(context),
                title: Text(
                  'DarkNight',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: context
                            .watch<SweetPreferencesBloc>()
                            .state
                            .themeColors
                            .grayly,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                subtitle: Text(
                  'a beautiful message',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              )
            : const ListTile());
  }

  Widget _getImage(BuildContext context) {
    return photoURL != null
        ? CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: photoURL!,
            imageBuilder: (context, imageProvider) => CircleAvatar(
              backgroundImage: imageProvider,
            ),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.person),
          )
        : const CircleAvatar(
            child: Icon(
            Icons.person,
            color: Colors.white,
          ));
  }
}
