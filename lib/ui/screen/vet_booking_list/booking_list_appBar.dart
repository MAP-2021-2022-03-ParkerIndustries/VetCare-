import 'package:flutter/material.dart';
import 'package:vetclinic/app/routes.dart';
import 'package:vetclinic/utils/app_theme.dart';

class VetBookingListAppBar extends StatefulWidget implements PreferredSizeWidget{
  const VetBookingListAppBar({ Key? key }) : super(key: key);

  @override
  State<VetBookingListAppBar> createState() => _VetBookingListAppBarState();
  
  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _VetBookingListAppBarState extends State<VetBookingListAppBar> {
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