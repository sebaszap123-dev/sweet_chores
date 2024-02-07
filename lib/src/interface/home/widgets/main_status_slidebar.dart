import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweet_chores/src/config/router/sweet_router.dart';
import 'package:sweet_chores/src/config/router/sweet_router.gr.dart';
import 'package:sweet_chores/src/data/blocs/blocs.dart';
import 'package:sweet_chores/src/data/servicelocator.dart';
import 'package:sweet_chores/src/domain/domain.dart';
import 'package:sweet_chores/src/interface/common/profile_widget.dart';
import 'package:sweet_chores/src/models/models.dart';
import 'package:sweet_chores/src/interface/home/widgets/slidebar_item.dart';

class MainStatusSlideBar extends StatefulWidget {
  const MainStatusSlideBar({
    super.key,
    required this.myKey,
    this.username,
    this.urlProfileImage,
    required this.greetings,
  });
  final GlobalKey<ScaffoldState> myKey;
  final String? username;
  final String? urlProfileImage;
  final String greetings;
  @override
  State<MainStatusSlideBar> createState() => _MainStatusSlideBarState();
}

class _MainStatusSlideBarState extends State<MainStatusSlideBar> {
  bool isEditing = false;
  final doneCategory = Categories(
      name: 'Done',
      color: Colors.green.shade600,
      id: -1,
      iconData: Icons.done_all_outlined,
      isActive: false);
  void _filterTodos(Categories category, bool categoryAdd) {
    context
        .read<TodoBloc>()
        .add(FilterTodosByCategories(category, categoryAdd));
    context.read<CategoriesBloc>().add(UpdateCategoryStatus(category));
  }

  @override
  Widget build(BuildContext context) {
    const double minLeadingWidth = 10;
    return Drawer(
      child: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          return ListView(
            addAutomaticKeepAlives: true,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              ProfileWidget(
                greetings: widget.greetings,
              ),
              const SizedBox(height: 10),
              ListTile(
                contentPadding: const EdgeInsets.only(left: 8, right: 0),
                title: Text(
                  'My lists',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                trailing: TextButton(
                  onPressed: () {
                    if (state.categories.length == 1) return;
                    setState(() {
                      isEditing = !isEditing;
                    });
                  },
                  child: const Text('Edit'),
                ),
              ),
              Divider(
                  color: context
                      .watch<SweetPreferencesBloc>()
                      .state
                      .themeColors
                      .text
                      .withOpacity(0.3)),
              if (state.categories.isNotEmpty)
                ...state.categories.asMap().entries.map((categoryEntry) {
                  return SlidebarItem(
                    category: categoryEntry.value,
                    isEditing: isEditing,
                    selectedState: (selected) {
                      if (selected) {
                        _filterTodos(categoryEntry.value, true);
                      } else {
                        _filterTodos(categoryEntry.value, false);
                      }
                    },
                  );
                }),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                leading: const Icon(Icons.add, color: Colors.green),
                title: Text(
                  'Add new list',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onTap: () {
                  AutoRouter.of(context).push(CategoriesManagerRoute());
                },
              ),
              const Divider(color: Colors.black26),
              const SizedBox(height: 40),
              ListTile(
                onTap: () => getIt<SweetRouterCubit>()
                    .state
                    .push(const ConfigRouteLayout(children: [SettingsRoute()])),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                minLeadingWidth: minLeadingWidth,
                leading: const Icon(Icons.settings_outlined),
                title: const Text('Settings'),
              ),
              // * TODO-FEATURE: Add premium version
              // const ListTile(
              //   contentPadding: EdgeInsets.symmetric(horizontal: 8),
              //   minLeadingWidth: minLeadingWidth,
              //   leading: Icon(Icons.star_outline),
              //   title: Text('Premium'),
              // ),
              // ? TODO: OPEN DIALOG TO SEND A MESSAGE
              ListTile(
                onTap: () {},
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                minLeadingWidth: minLeadingWidth,
                leading: const Icon(Icons.message_outlined),
                title: const Text('Contac us'),
              ),
              ListTile(
                onTap: () => FirebaseAuthService.signOut(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                minLeadingWidth: minLeadingWidth,
                leading: const Icon(Icons.logout_outlined),
                title: const Text('Log out'),
              ),
            ],
          );
        },
      ),
    );
  }
}
