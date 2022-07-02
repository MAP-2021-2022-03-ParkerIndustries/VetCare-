import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:map_mvvm/view.dart';
import 'package:vetclinic/ui/screen/view_pet/petList_view_Model.dart';
import 'package:vetclinic/ui/screen/view_pet/petlist_appBar.dart';
import 'package:vetclinic/ui/screen/view_pet/petlist_body.dart';

class PetListView extends StatefulWidget {
  const PetListView({Key? key}) : super(key: key);

static Route route() =>
      MaterialPageRoute(builder: (_) => const PetListView());
  @override
  State<PetListView> createState() => _PetListViewState();
}


class _PetListViewState extends State<PetListView> {
  @override
  Widget build(BuildContext context) {
    return View<PetListVM>(builder: (context, viewModel) {
     return   const Scaffold(
      appBar: PetListAppBar(),
      body: PetListBody(),
     );
  });
  }
}