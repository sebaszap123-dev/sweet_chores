import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sweet_chores/src/core/utils/image_constant.dart';
import 'package:sweet_chores/src/data/data_source.dart';
import 'package:sweet_chores/src/interface/common/common.dart';

// TODO: IMPLEMENT INTL for messages
const Map<String, String> messages = {
  'firstTime': 'Oh! It seems you have no reminders yet :c',
  'today': "You've done for today Go for a snack, you deserve it",
  'week': "Wow! You completed all this week tasks It's time to relax",
  'month': 'Looks like you have nothing else to do this month, YAY!',
  'all': "It's time to rest! You have no more tasks",
  'overDue': 'Relax! You have no overdue tasks Go sleep or something',
  'done': 'Hey! Now You need complete new tasks. Take a well-deserved break.',
};

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    this.status = FilterStatus.all,
  });
  final FilterStatus status;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SweetPreferencesBloc, SweetPreferencesState>(
      builder: (context, state) {
        if (state.status == SweetChoresStatus.success) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  _getAssetImage(state.firstTimeApp),
                  width: MediaQuery.of(context).size.width * 0.7,
                  filterQuality: FilterQuality.high,
                ),
                const SizedBox(height: 10),
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6),
                  child: Text(
                    messages[status.name]!,
                    style: GoogleFonts.spicyRice(
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.primary),
                    textAlign: TextAlign.center,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Loading();
        }
      },
    );
  }

  String _getAssetImage(bool isFirstTime) =>
      isFirstTime ? ImageConstant.noTasks : ImageConstant.doneTasks;
}
