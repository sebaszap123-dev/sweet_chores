import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweet_chores/src/core/utils/greetings.dart';
import 'package:sweet_chores/src/data/servicelocator.dart';
import 'package:sweet_chores/src/interface/common/common.dart';
import 'package:sweet_chores/src/interface/home/widgets/widgets.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> homeKey = GlobalKey();
    return Scaffold(
      key: homeKey,
      appBar: MainAppbar(
        openDrawer: () => homeKey.currentState?.openDrawer(),
      ),
      floatingActionButton: const AddTodoButton(),
      body: BlocSelector<SweetChoresNotesBloc, SweetChoresNotesState,
          SweetChoresNotesState>(
        selector: (state) {
          return state;
        },
        builder: (context, state) {
          if (state.todoStatus == TodoStatus.loading) {
            return const Loading();
          }
          return TodoCardList(
            todos: state.currentTodos,
            isEmpty: state.currentTodos.isEmpty,
            status: state.filterStatus,
          );
        },
      ),
      drawer: MainStatusSlideBar(
        myKey: homeKey,
        greetings: getIt<Greetings>().greeting,
      ),
    );
  }
}
