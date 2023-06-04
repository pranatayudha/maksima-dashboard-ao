import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../../application/app/constants/image_constants.dart';
import '../../../../../../../../../application/models/list_agunan_tambahan_model.dart';
import '../../../../../../../../shared/custom_button.dart';
import '../../../../../../../../shared/custom_empty_state.dart';
import '../../../../widgets/base_view.dart';
import '../../../../widgets/header_content.dart';
import '../../../../widgets/warning_alert.dart';
import '../widgets/dialog_pilih_agunan.dart/dialog_jenis_agunan_tambahan.dart';
import 'list_agunan_tambahan_viewmodel.dart';
import 'widgets/agunan_tambahan_card.dart';

class ListAgunanTambahanView
    extends ViewModelBuilderWidget<ListAgunanTambahanViewModel> {
  final String prakarsaId;
  final int codeTable;
  final String pipelineId;
  final double height;
  final Function(dynamic) selectedAgunan;

  const ListAgunanTambahanView({
    super.key,
    required this.prakarsaId,
    required this.codeTable,
    required this.pipelineId,
    required this.height,
    required this.selectedAgunan,
  });

  @override
  void onViewModelReady(ListAgunanTambahanViewModel viewModel) =>
      viewModel.initialise();

  @override
  ListAgunanTambahanViewModel viewModelBuilder(BuildContext context) =>
      ListAgunanTambahanViewModel(
        prakarsaId: prakarsaId,
        codeTable: codeTable,
        pipelineId: pipelineId,
      );

  @override
  Widget builder(
    BuildContext context,
    ListAgunanTambahanViewModel viewModel,
    Widget? child,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return BaseView(
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const HeaderContent(title: 'Agunan Tambahan'),
                  const WarningAlert(
                    title: 'Lengkapi Agunan Tambahan Debitur',
                    subtitle: 'Lengkapi informasi agunan tambahan debitur',
                  ),
                  if (viewModel.isBusy && viewModel.listAgunan == null)
                    SizedBox(
                      height: height / 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                          Text('Memuat data...'),
                        ],
                      ),
                    )
                  else if (viewModel.listAgunan?.isEmpty ?? true) ...[
                    CustomEmptyState(
                      height: height / 4,
                      title: 'Belum Ada Agunan Tambahan',
                      subTitle: 'Tambah agunan tambahan dari debitur',
                      imageAsset: ImageConstants.emptyList,
                    ),
                  ],
                ],
              ),
              Expanded(
                child: ListView(
                  children: List.generate(
                    viewModel.listAgunan?.length ?? 0,
                    (index) => AgunanTambahanCard(
                      index: index,
                      dataAgunan: viewModel.listAgunan![index],
                      onTap: () {
                        if ((viewModel.listAgunan![index].codeTable ?? '')
                            .isNotEmpty) {
                          selectedAgunan(viewModel.listAgunan![index].copyWith(index: (index + 1)));
                          viewModel.navigateToDetail(
                            viewModel.listAgunan![index].codeTable!,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              if (!viewModel.isBusy)
                CustomButton(
                  label: 'Tambah Agunan Tambahan',
                  onPressed: () => DialogJenisAgunanTambahan().openDialog(
                    context: context,
                    width: constraints.maxWidth,
                    data: (val) {
                      selectedAgunan(ListAgunanTambahanModel(codeTable: val));
                      viewModel.setSelectedAgunanTambahan(val);
                    },
                  ),
                  isBusy: false,
                ),
            ],
          ),
        );
      },
    );
  }
}
