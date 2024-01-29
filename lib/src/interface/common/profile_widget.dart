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
    this.width = 80,
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
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: _getImage(context),
                ),
                title: Text(
                  'DarkNight',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
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
            width: width,
            fit: BoxFit.contain,
            imageUrl: photoURL!,
            // imageBuilder: (context, imageProvider) => Container(
            //   height: width,
            //   clipBehavior: Clip.antiAlias,
            //   width: width,
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     image: DecorationImage(
            //       fit: BoxFit.cover,
            //       image: imageProvider,
            //     ),
            //   ),
            // ),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.person),
          )
        : Container(
            height: width,
            width: width,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              color: Colors.white,
            ));
  }
}
