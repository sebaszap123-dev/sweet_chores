import 'package:flutter/material.dart';

class TodoCardBody extends StatelessWidget {
  const TodoCardBody({
    super.key,
    required this.miniTask,
  });
  final List<String> miniTask;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...miniTask.map((task) => Row(
                crossAxisAlignment: task.length > 25
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: task.length > 25
                        ? const EdgeInsets.only(top: 5)
                        : EdgeInsets.zero,
                    child: const Icon(
                      Icons.circle,
                      color: Colors.black,
                      size: 10,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      task,
                      style: Theme.of(context).textTheme.bodyLarge,
                      softWrap: true,
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
