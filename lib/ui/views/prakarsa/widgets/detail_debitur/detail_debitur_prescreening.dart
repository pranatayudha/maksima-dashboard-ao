import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../application/app/constants/text_style_constants.dart';
import 'detail_debitur_viewmodel.dart';
import 'widgets/prescreening/prescreening_perorangan.dart';
import 'widgets/prescreening/prescreening_perusahaan.dart';

class DetailDebiturScreening
    extends HookViewModelWidget<DetailDebiturViewModel> {
  const DetailDebiturScreening({Key? key}) : super(key: key);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    DetailDebiturViewModel viewModel,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Detail Prescreening',
                style: titleStyle20,
              ),
              _buildFormBodyPreScreening(viewModel),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildFormBodyPreScreening(DetailDebiturViewModel vm) {
  switch (vm.codeTable) {
    case 1:
      return PrescreeningPerorangan(viewModel: vm);
    case 2:
      return PrescreeningPerusahaan(viewModel: vm);
    case 3:
      return PrescreeningPerusahaan(viewModel: vm);
    case 4:
      return PrescreeningPerorangan(viewModel: vm);
    default:
      return Container();
  }
}
