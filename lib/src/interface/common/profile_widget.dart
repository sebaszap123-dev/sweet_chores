import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sweet_chores/src/core/app_export.dart';
import 'package:sweet_chores/src/core/utils/greetings.dart';
import 'package:sweet_chores/src/data/data_source.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key, required this.greetings});
  final String greetings;
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final grayly = Theme.of(context).colorScheme.tertiary;
    return BlocBuilder<FirebaseAuthBloc, FirebaseState>(
      builder: (context, state) {
        if (state is FirebaseAuthState) {
          return Card(
              margin: EdgeInsets.zero,
              shape:
                  const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              color: primaryColor,
              child: Padding(
                padding: EdgeInsets.only(top: statusBarHeight),
                child: ListTile(
                  leading: state.userFirebase.photoURL != null
                      ? CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: state.userFirebase.photoURL!,
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                            backgroundImage: imageProvider,
                          ),
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.person),
                        )
                      : const CircleAvatar(
                          child: Icon(
                          Icons.person,
                          color: Colors.white,
                        )),
                  title: Text(
                    state.userFirebase.displayName ?? 'Kammon',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: grayly,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  subtitle: Text(
                    greetings,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ),
              ));
        } else {
          return Card(
              margin: EdgeInsets.zero,
              shape:
                  const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              color: Theme.of(context).colorScheme.primary,
              child: ListTile(
                subtitle: Text(
                  getGreeting(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ));
        }
      },
    );
  }
}
