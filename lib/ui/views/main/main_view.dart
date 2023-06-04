import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../application/controllers/custom_menu_controller.dart';
import 'main_viewmodel.dart';
import 'widgets/main_screen.dart';

class MainView extends ViewModelBuilderWidget<MainViewModel> {
  final bool? isDetailDebt;
  final bool? isDetailPrakarsa;
  const MainView({
    super.key,
    this.isDetailDebt = false,
    this.isDetailPrakarsa = false,
  });

  @override
  MainViewModel viewModelBuilder(BuildContext context) => MainViewModel();

  @override
  void onViewModelReady(MainViewModel viewModel) => viewModel.initialize();

  @override
  Widget builder(
    BuildContext context,
    MainViewModel viewModel,
    Widget? child,
  ) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CustomMenuController(),
        ),
      ],
      child: MainScreen(
        username: viewModel.user!.userName!,
        personalNumber: viewModel.user!.userId!,
        photo: viewModel.user!.foto!.toString(),
        onPressedLogout: viewModel.logout,
        selectedPage: viewModel.selectedPage,
        onChanged: (i) => viewModel.updateSelectedPage(i),
      ),
    );
  }
}
