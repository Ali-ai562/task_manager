import 'package:flutter/material.dart';
// import 'package:task_manager/views/add%20task/add_task_page.dart';

// class FloatButton extends StatelessWidget {
//   const FloatButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       borderRadius: BorderRadius.circular(10),
//       child: InkWell(
//         onTap: () {
//           Navigator.push(
//             context,
//             PageRouteBuilder(
//               transitionDuration: const Duration(milliseconds: 700),
//               reverseTransitionDuration: const Duration(milliseconds: 700),
//               pageBuilder: (context, animation, secondaryAnimation) =>
//                   AddTaskPage(),
//               transitionsBuilder:
//                   (context, animation, secondaryAnimation, child) {
//                     const begin = Offset(1.0, 0.0); 
//                     const end = Offset.zero;

//                     final tween = Tween(
//                       begin: begin,
//                       end: end,
//                     ).chain(CurveTween(curve: Curves.easeOut));

//                     final offsetAnimation = animation.drive(tween);

//                     return SlideTransition(
//                       position: offsetAnimation,
//                       child: child,
//                     );
//                   },
//             ),
//           );
//         },
//         borderRadius: BorderRadius.circular(10),
//         child: Ink(
//           decoration: BoxDecoration(
//             color: const Color(0xFFE8C547),
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: [
//               BoxShadow(
//                 color: const Color(0xFFE8C547).withOpacity(0.25),
//                 blurRadius: 12,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(Icons.add, color: Colors.black, size: 20),
//                 SizedBox(width: 8),
//                 Text(
//                   'New Task',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w700,
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class FloatButton extends StatelessWidget {
  final VoidCallback onTap;
  const FloatButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap, // ← was hardcoded () {}
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          decoration: BoxDecoration(
            color: const Color(0xFFE8C547),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE8C547).withOpacity(0.25),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add, color: Colors.black, size: 20),
                SizedBox(width: 8),
                Text(
                  'New Task',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}