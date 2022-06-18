import 'package:flutter/material.dart';

import '../../../app/routes.dart';
import '../../../utils/app_theme.dart';

class HistoryAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HistoryAppBar({Key? key}) : super(key: key);

  @override
  State<HistoryAppBar> createState() => _HistoryAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _HistoryAppBarState extends State<HistoryAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.primary,
      title: SizedBox(
        height: 35,
        child: Row(
          children: [
            Image.asset("assets/veterinarian.png", fit: BoxFit.cover),
            const SizedBox(width: 10),
            const Text(
              "Pet History",
              style: AppTheme.headline3,
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () {
            // Navigator.of(context).pushNamed(Routes.profileRoute);
          },
          icon: const Icon(Icons.notifications),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.profileRoute);
          },
          icon: const Icon(Icons.person),
        ),
      ],
    );
  }
}
