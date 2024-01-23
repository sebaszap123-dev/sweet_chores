import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweet_chores_reloaded/src/interface/common/common.dart';
import 'package:sweet_chores_reloaded/src/interface/home/widgets/widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:sweet_chores_reloaded/src/models/models.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo> todoList = [];
  FilterStatus filterStatus = FilterStatus.all;
  bool isEmpty = false;

  void _updateTodoList(TodoState state) {
    state.filterTodos;
    if (state.status == TodoStatus.success) {
      isEmpty = state.currentTodos.isEmpty;
      todoList = state.currentTodos;
      filterStatus = state.filterStatus;
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> homeKey = GlobalKey();
    return Scaffold(
      key: homeKey,
      appBar: MainAppbar(
        openDrawer: () => homeKey.currentState?.openDrawer(),
      ),
      floatingActionButton: const AddTodoButton(),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (_, state) => _updateTodoList(state),
        builder: (_, __) {
          return TodoCardList(
            todos: todoList,
            isEmpty: isEmpty,
            status: filterStatus,
          );
        },
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
