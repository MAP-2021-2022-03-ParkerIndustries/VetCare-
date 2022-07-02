import 'package:flutter/material.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:vetclinic/model/users.dart';
import 'package:vetclinic/ui/components/custom_text_field.dart';
import 'package:vetclinic/ui/screen/Receptionist_home/Receptionist_home_view.dart';

import '../../../app/routes.dart';
import '../../../utils/app_theme.dart';
import 'Reception_edit_viewmodel.dart';


class ReceptionistEditBookingView extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const ReceptionistHomeView());
  ReceptionistEditBookingView({ Key? key }) : super(key: key);
  
  Users _users = Users();
  @override
  State<ReceptionistEditBookingView> createState() => _ReceptionistEditBookingViewState();
}

class _ReceptionistEditBookingViewState extends State<ReceptionistEditBookingView> {
  @override
  Widget build(BuildContext context) {
    return View<EditBookingViewModel>(builder: (_,model) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppTheme.primary,
            title: SizedBox(
              height: 35,
              child: Row(
                children: [
                  Image.asset("assets/veterinarian.png", fit: BoxFit.cover),
                  const SizedBox(width: 10),
                  const Text(
                    "Receptionist Page",
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
          ),
         body: _buildEdit(model),
        );
      }
    );
  }
  Widget _buildEdit(model){
    return CustomTextField(
      label: model.user.name,
    );
  }
}