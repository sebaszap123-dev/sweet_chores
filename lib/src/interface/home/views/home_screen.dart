import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweet_chores_reloaded/src/data/data_source.dart';
import 'package:sweet_chores_reloaded/src/interface/common/common.dart';
import 'package:sweet_chores_reloaded/src/interface/home/widgets/widgets.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> homeKey = GlobalKey();
    final todoList = context.watch<TodoBloc>().state.currentTodos;
    final filter = context.watch<TodoBloc>().state.filterStatus;
    return Scaffold(
      key: homeKey,
      appBar: MainAppbar(
        openDrawer: () => homeKey.currentState?.openDrawer(),
      ),
      floatingActionButton: const AddTodoButton(),
      body: TodoCardList(
        todos: todoList,
        isEmpty: todoList.isEmpty,
        status: filter,
      ),
      drawer: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          if (state.status == CategoriesStatus.success) {
            return MainStatusSlideBar(
              myKey: homeKey,
            );
          } else {
            return const Loading();
          }
        },
      ),
    );
  }
}
