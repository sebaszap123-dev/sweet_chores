import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweet_chores_reloaded/src/config/router/sweet_router.dart';
import 'package:sweet_chores_reloaded/src/config/router/sweet_router.gr.dart';
import 'package:sweet_chores_reloaded/src/core/utils/greetings.dart';
import 'package:sweet_chores_reloaded/src/core/utils/size_utils.dart';
import 'package:sweet_chores_reloaded/src/data/blocs/blocs.dart';
import 'package:sweet_chores_reloaded/src/data/servicelocator.dart';
import 'package:sweet_chores_reloaded/src/models/models.dart';
import 'package:sweet_chores_reloaded/src/interface/home/widgets/slidebar_item.dart';

class MainStatusSlideBar extends StatefulWidget {
  const MainStatusSlideBar({
    super.key,
    required this.myKey,
    this.username,
    this.urlProfileImage,
  });
  final GlobalKey<ScaffoldState> myKey;
  final String? username;
  final String? urlProfileImage;

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
              Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                height: mediaQueryData.size.height * 0.18,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 30,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          alignment: Alignment.topLeft,
                          onPressed: () =>
                              widget.myKey.currentState?.closeDrawer(),
                          icon: const Icon(
                            Icons.close_outlined,
                            color: Colors.white,
                          )),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        getIt<Greeting>().text,
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                contentPadding: const EdgeInsets.only(left: 8, right: 0),
                title: Text(
                  'My lists',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
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
              const Divider(color: Colors.black26),
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
              ListTile(
                onTap: () => getIt<SweetRouterCubit>()
                    .state
                    .push(const ConfigRouteLayout(children: [BackUpRoute()])),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                minLeadingWidth: minLeadingWidth,
                leading: const Icon(Icons.cloud_outlined),
                title: const Text('Backup'),
              ),
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
            ],
          );
        },
      ),
    );
  }
}
