import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../shared/information_card.dart';
import 'prakarsa_list_viewmodel.dart';
import 'widgets/prakarsa_list_body.dart';

class PrakarsaListView extends StatefulWidget {
  final double maxWidth;
  final Function(Map<String, dynamic>)? selectedPrakarasa;
  const PrakarsaListView({
    Key? key,
    required this.maxWidth,
    required this.selectedPrakarasa,
  }) : super(key: key);

  @override
  State<PrakarsaListView> createState() => _PrakarsaListViewState();
}

class _PrakarsaListViewState extends State<PrakarsaListView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PrakarsaListViewModel>.reactive(
      viewModelBuilder: () => PrakarsaListViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, viewModel, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Wrap(
            direction: Axis.horizontal,
            children: List.generate(
              viewModel.listInfoCardPrakarsa.length,
              (index) {
                var data = viewModel.listInfoCardPrakarsa[index];

                return InformationCard(
                  width: widget.maxWidth,
                  title: data.title,
                  icon: data.icon,
                  value: data.value,
                );
              },
            ),
          ),
          SizedBox(
            width: widget.maxWidth,
            child: PrakarsaListBody(
              selectedPrakarasa: (data) => widget.selectedPrakarasa!(data),
            ),
          ),
        ],
      ),
    );
  }
}
