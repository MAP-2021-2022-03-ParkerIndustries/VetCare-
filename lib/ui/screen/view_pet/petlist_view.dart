// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:vetclinic/app/routes.dart';

// import '../../../utils/app_theme.dart';

// class PetList extends StatefulWidget {
//   const PetList({Key? key}) : super(key: key);

//   @override
//   State<PetList> createState() => PetListState();
// }

// class PetListState extends State<PetList> {
//   @override
//   Widget build(BuildContext context) {
//     Scaffold(
//        appBar: AppBar(
//           backgroundColor: AppTheme.primary,
//           title: SizedBox(
//             height: 35,
//             child: Row(
//               children: [
//                 Image.asset("assets/veterinarian.png", fit: BoxFit.cover),
//                 const SizedBox(width: 10),
//                 const Text(
//                   "Register Pet",
//                   style: AppTheme.headline3,
//                 ),
//                 const SizedBox(width: 10),
//               ],
//             ),
//           ),
//           automaticallyImplyLeading: true,
//           actions: [
//             IconButton(
//               onPressed: () {
//                 // Navigator.of(context).pushNamed(Routes.profileRoute);
//               },
//               icon: const Icon(Icons.notifications),
//             ),
//             IconButton(
//               onPressed: () {
//                 Navigator.of(context).pushNamed(Routes.profileRoute);
//               },
//               icon: const Icon(Icons.person),
//             ),
//           ],
//         ),
//       body: Center(child: ),

//     );
//   }
// }
