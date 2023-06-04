import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pinang_maksima_dashboard_ao/ui/views/prakarsa/widgets/detail_prakarsa/page/informasi_agunan/agunan_tambahan/tanah_bangunan/form/data_pembanding/form_data_pembanding_tanah_bangunan_view.dart';
import 'package:stacked/stacked.dart';

import '../../../application/app/constants/page_route.dart';
import '../../../application/models/informasi_pengurus_model.dart';
import '../../../application/models/list_agunan_pokok_model.dart';
import '../../../application/models/list_agunan_tambahan_model.dart';
import '../../shared/breadcrum.dart';
import 'prakarsa_viewmodel.dart';
import 'widgets/detail_debitur/detail_debitur_view.dart';
import 'widgets/detail_prakarsa/detail_prakarsa_view.dart';
import 'widgets/detail_prakarsa/page/dokumen_lainnya/form/form_dokumen_lainnya_view.dart';
import 'widgets/detail_prakarsa/page/informasi_agunan/agunan_pokok/base_detail_agunan_view.dart';
import 'widgets/detail_prakarsa/page/informasi_agunan/agunan_pokok/base_form_agunan_view.dart';
import 'widgets/detail_prakarsa/page/informasi_agunan/agunan_tambahan/base_detail_agunan_tambahan_view.dart';
import 'widgets/detail_prakarsa/page/informasi_agunan/agunan_tambahan/base_form_agunan_tambahan_view.dart';
import 'widgets/detail_prakarsa/page/informasi_agunan/agunan_tambahan/data_pembanding/form_data_pembanding_view.dart';
import 'widgets/detail_prakarsa/page/informasi_agunan/agunan_tambahan/penilaian/form/form_penilaian_view.dart';
import 'widgets/detail_prakarsa/page/izin_usaha/form/form_izin_usaha_view.dart';
import 'widgets/detail_prakarsa/page/lkn/form/form_lkn_view.dart';
import 'widgets/detail_prakarsa/page/perorangan/identitas_diri_debitur/form/form_identitas_diri_view.dart';
import 'widgets/detail_prakarsa/page/perorangan/info_usaha/form/form_info_usaha_view.dart';
import 'widgets/detail_prakarsa/page/perusahaan/identitas/form/form_identitas_perusahaan_view.dart';
import 'widgets/detail_prakarsa/page/perusahaan/informasi_pengurus/detail/detail_pengurus_view.dart';
import 'widgets/detail_prakarsa/page/perusahaan/informasi_pengurus/form/form_pengurus_view.dart';
import 'widgets/detail_prakarsa/page/perusahaan/legalitas/form/form_legalitas_usaha_view.dart';
import 'widgets/parakarsa_list/prakarsa_list_view.dart';

class PrakarsaView extends ViewModelBuilderWidget<PrakarsaViewModel> {
  const PrakarsaView({
    super.key,
  });

  @override
  PrakarsaViewModel viewModelBuilder(BuildContext context) =>
      PrakarsaViewModel();

  @override
  void onViewModelReady(PrakarsaViewModel viewModel) => viewModel.initialize();

  @override
  bool get reactive => true;

  @override
  // ignore: long-method
  Widget builder(
    BuildContext context,
    PrakarsaViewModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
      child: ValueListenableBuilder(
        valueListenable: viewModel.localDBService.routesBox.listenable(),
        builder: (context, value, child) => LayoutBuilder(
          builder: (context, constraints) => ListView(
            children: [
              BreadCrum(
                width: constraints.maxWidth - 50,
                breadCrum: viewModel.localDBService.getRoutes() ?? [],
                onTapBack: () => viewModel.navigateBack(),
                onTapBreadCrum: (val) => viewModel.navigateBackByKey(val),
              ),
              if (viewModel.localDBService.currentRoutes() ==
                      ConstantPageRoute.prakarsaPage ||
                  viewModel.localDBService.currentRoutes() == '')
                PrakarsaListView(
                  maxWidth: constraints.maxWidth,
                  selectedPrakarasa: (data) => viewModel.setValuePrakarsa(data),
                )
              else if (viewModel.localDBService.currentRoutes() ==
                  ConstantPageRoute.detailDebiturPage)
                DetailDebiturView(
                  prakarsaId: viewModel.prakarsaId,
                  codeTable: viewModel.codeTable,
                  setCurrentPage: (val) =>
                      viewModel.setCurrentPrakarsaPage(val),
                )
              else if (viewModel.localDBService.currentRoutes() ==
                  ConstantPageRoute.detailPrakarsaPage)
                DetailPrakarsaView(
                  currentPage: viewModel.currentPrakarsaPage,
                  setCurrentPage: (val) =>
                      viewModel.setCurrentPrakarsaPage(val),
                  height: constraints.maxHeight - 40,
                  prakarsaId: viewModel.prakarsaId,
                  codeTable: viewModel.codeTable,
                  initial: viewModel.initial,
                  name: viewModel.name,
                  loanAmount: viewModel.loanAmount,
                  pipelineId: viewModel.pipelineId,
                  callBackData: (data) => viewModel.setTemporaryValue(data),
                )
              else if (viewModel.localDBService.currentRoutes() ==
                  ConstantPageRoute.formLKNPage)
                FormLKNView(
                  width: constraints.maxWidth,
                  prakarsaId: viewModel.prakarsaId,
                  codeTable: viewModel.codeTable,
                )
              else if (viewModel.localDBService.currentRoutes() ==
                  ConstantPageRoute.formIdentitasPerusahaanPage)
                FormIdentitasPerusahaanView(
                  prakarsaId: viewModel.prakarsaId,
                  codeTable: viewModel.codeTable,
                  width: constraints.maxWidth,
                )
              else if (viewModel.localDBService.currentRoutes() ==
                  ConstantPageRoute.formLegalitasUsahaPage)
                FormLegalitasUsahaView(
                  prakarsaId: viewModel.prakarsaId,
                  codeTable: viewModel.codeTable,
                )
              else if (viewModel.localDBService.currentRoutes() ==
                  ConstantPageRoute.formIzinUsahaPage)
                FormIzinUsahaView(
                  prakarsaId: viewModel.prakarsaId,
                  codeTable: viewModel.codeTable,
                )
              else if (viewModel.localDBService.currentRoutes() ==
                  ConstantPageRoute.formDokumenUsahaLainnyaPage)
                FormDokumenLainnyaView(
                  prakarsaId: viewModel.prakarsaId,
                  codeTable: viewModel.codeTable,
                )
              else if (viewModel.localDBService.currentRoutes() ==
                  ConstantPageRoute.detailPengurusPage)
                DetailInformasiPengurusView(
                  informasiPengurus:
                      viewModel.temporary as InformasiPengurusModel,
                  codeTable: viewModel.codeTable,
                  prakarsaId: viewModel.prakarsaId,
                  pipelineId: viewModel.pipelineId,
                )
              else if (viewModel.localDBService.currentRoutes() ==
                  ConstantPageRoute.formInformasiPengurusPage)
                FormPengurusView(
                  prakarsaId: viewModel.prakarsaId,
                  codeTable: viewModel.codeTable,
                  informasiPengurus:
                      viewModel.temporary as InformasiPengurusModel,
                  pipelineId: viewModel.pipelineId,
                )
              else if (viewModel.localDBService.currentRoutes() ==
                  ConstantPageRoute.formIdentitasDebiturPage)
                FormIdentitasDiriView(
                  prakarsaId: viewModel.prakarsaId,
                  codeTable: viewModel.codeTable,
                  pipelineId: viewModel.pipelineId,
                )
              else if (viewModel.localDBService.currentRoutes() ==
                  ConstantPageRoute.formInfoUsahaPage)
                FormInfoUsahaView(
                  prakarsaId: viewModel.prakarsaId,
                  codeTable: viewModel.codeTable,
                  pipelineId: viewModel.pipelineId,
                )
              else if (viewModel.localDBService.currentRoutes() ==
                  ConstantPageRoute.formAgunanPokok)
                BaseFormAgunanView(
                  dataAgunan: viewModel.temporary as ListAgunanModel,
                  prakarsaId: viewModel.prakarsaId,
                  codeTable: viewModel.codeTable,
                  pipelineId: viewModel.pipelineId,
                  width: constraints.maxWidth,
                )
              else if (viewModel.localDBService.currentRoutes() ==
                  ConstantPageRoute.detailAgunanPokok)
                BaseDetailAgunanView(
                  dataAgunan: viewModel.temporary as ListAgunanModel,
                  prakarsaId: viewModel.prakarsaId,
                  codeTable: viewModel.codeTable,
                  selectedAgunan: (data) => viewModel.setTemporaryValue(data),
                  width: constraints.maxWidth,
                )
              else if (viewModel.localDBService.currentRoutes() ==
                  ConstantPageRoute.formInfoUmumAgunan)
                BaseFormAgunanTambahanView(
                  dataAgunan: viewModel.temporary as ListAgunanTambahanModel,
                  prakarsaId: viewModel.prakarsaId,
                  codeTable: viewModel.codeTable,
                  height: constraints.maxHeight - 40,
                  width: constraints.maxWidth,
                  agunanId: (id) => viewModel.setTemporaryValue(id),
                )
              else if (viewModel.localDBService.currentRoutes() ==
                  ConstantPageRoute.detailAgunanTambahan)
                BaseDetailAgunanTambahanView(
                  dataAgunan: viewModel.temporary as ListAgunanTambahanModel,
                  prakarsaId: viewModel.prakarsaId,
                  codeTable: viewModel.codeTable,
                  selectedAgunan: (data) => viewModel.setTemporaryValue(data),
                )
              else if (viewModel.localDBService.currentRoutes() ==
                  ConstantPageRoute.formDataPembanding)
                FormDataPembandingView(
                  dataAgunan: viewModel.temporary as ListAgunanTambahanModel,
                  prakarsaId: viewModel.prakarsaId,
                  codeTable: viewModel.codeTable,
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                )
              else if (viewModel.localDBService.currentRoutes() ==
                  ConstantPageRoute.formPenilaian)
                FormPenilaianView(
                  dataAgunan: viewModel.temporary as ListAgunanTambahanModel,
                  prakarsaId: viewModel.prakarsaId,
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                )
              else if (viewModel.localDBService.currentRoutes() ==
                  ConstantPageRoute.formDataPembandingTanahBangunan)
                FormDataPembandingTanahBangunanView(
                  dataAgunan: viewModel.temporary as ListAgunanTambahanModel,
                  prakarsaId: viewModel.prakarsaId,
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  codeTable: viewModel.codeTable,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
