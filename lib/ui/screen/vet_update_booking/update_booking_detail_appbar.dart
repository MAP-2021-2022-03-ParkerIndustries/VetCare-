import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../app/routes.dart';
import '../../../utils/app_theme.dart';

class UpdateBookingDetailAppbar extends StatefulWidget implements PreferredSizeWidget {
  const UpdateBookingDetailAppbar({Key? key}) : super(key: key);

  @override
  State<UpdateBookingDetailAppbar> createState() => _UpdateBookingDetailAppbarState();
  
  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _UpdateBookingDetailAppbarState extends State<UpdateBookingDetailAppbar> {
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
              "Booking List",
              style: AppTheme.headline3,
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
      automaticallyImplyLeading: true,
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