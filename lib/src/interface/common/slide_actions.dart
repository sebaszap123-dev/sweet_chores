// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

// class SlideActions extends StatelessWidget {
//   const SlideActions({
//     Key? key,
//     required this.body,
//     this.enableEdit = false,
//     this.enableDelete = false,
//     this.onEdit,
//     this.onDelete,
//   })  : assert((enableEdit && onEdit != null) || !enableEdit,
//             'You must provide onEdit when hasEdit is true.'),
//         assert((enableDelete && onDelete != null) || !enableDelete,
//             'You must provide onDelete when hasDelete is true.'),
//         super(key: key);

//   final bool enableEdit;
//   final bool enableDelete;
//   final Widget body;
//   final void Function()? onEdit;
//   final void Function()? onDelete;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: Card(
//         color: Theme.of(context).colorScheme.primary,
//         elevation: 1,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: ClipRRect(
//           clipBehavior: Clip.hardEdge,
//           child: Slidable(
//             key: const ValueKey(0),
//             endActionPane: enableEdit
//                 ? ActionPane(
//                     motion: const ScrollMotion(),
//                     extentRatio: 0.3,
//                     children: [
//                         SlidableAction(
//                           onPressed: (_) => onEdit!(),
//                           backgroundColor:
//                               Theme.of(context).colorScheme.secondary,
//                           foregroundColor: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                           icon: Icons.edit,
//                           label: 'Edit',
//                         ),
//                       ])
//                 : null,
//             startActionPane: enableDelete
//                 ? ActionPane(
//                     motion: const ScrollMotion(),
//                     extentRatio: 0.3,
//                     children: [
//                         SlidableAction(
//                           onPressed: (_) => onDelete!(),
//                           backgroundColor: Colors.red,
//                           foregroundColor: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                           icon: Icons.delete,
//                           label: 'Delete',
//                         ),
//                       ])
//                 : null,
//             child: body,
//           ),
//         ),
//       ),
//     );
//   }
// }
