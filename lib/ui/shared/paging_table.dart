import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';
import '../../application/app/constants/custom_color.dart';
import '../../application/app/constants/text_style_constants.dart';
import '../../application/models/prakarsa_list_model.dart';

class PagingTable extends StatelessWidget {
  final Meta metaData;
  final int length;
  final Function(int val)? onTap;
  const PagingTable({
    Key? key,
    required this.metaData,
    required this.onTap,
    required this.length,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
      children: [
        Div(
          divison: const Division(
            colXS: 12,
            colS: 12,
            colM: 6,
            colL: 6,
            colXL: 6,
          ),
          child: Text(
            'Menampilkan ${(metaData.size ?? 0) * ((metaData.currentPage ?? 0) - 1) + 1} ke ${(length) * (metaData.currentPage ?? 0)} dari ${metaData.totalData} entri',
            style: normalStyle.copyWith(
              color: CustomColor.darkGrey,
            ),
          ),
        ),
        Div(
          divison: const Division(
            colXS: 12,
            colS: 12,
            colM: 6,
            colL: 6,
            colXL: 6,
          ),
          child: pagingNumber(),
        ),
      ],
    );
  }

  // ignore: long-method
  Widget pagingNumber() {
    return Row(
      children: [
        if ((metaData.totalData ?? 0) > (metaData.size ?? 0))
          pageNavigator(
            false,
            metaData.currentPage != 1,
            Icons.arrow_back_ios,
            onTap,
          ),
        if ((metaData.lastPage ?? 0) < 4)
          ...List.generate(
            metaData.lastPage ?? 0,
            (index) => item(
              '${index + 1}',
              index + 1 == metaData.currentPage,
              onTap,
            ),
          )
        else if (((metaData.currentPage ?? 0) < (metaData.lastPage ?? 0) / 2) &&
            (metaData.currentPage ?? 0) == 1) ...[
          item(
            '${(metaData.currentPage ?? 0)}',
            true,
            onTap,
          ),
          item(
            '${(metaData.currentPage ?? 0) + 1}',
            false,
            onTap,
          ),
          item(
            '${(metaData.currentPage ?? 0) + 2}',
            false,
            onTap,
          ),
        ] else if ((metaData.currentPage ?? 0) <
            (metaData.lastPage ?? 0) / 2) ...[
          item(
            '${(metaData.currentPage ?? 0) - 1}',
            false,
            onTap,
          ),
          item(
            '${(metaData.currentPage ?? 0)}',
            true,
            onTap,
          ),
          item(
            '${(metaData.currentPage ?? 0) + 1}',
            false,
            onTap,
          ),
        ] else
          item(
            '1',
            false,
            onTap,
          ),
        if ((metaData.lastPage ?? 0) > 3)
          item(
            '...',
            false,
            null,
          ),
        if ((metaData.lastPage ?? 0) > 3)
          if (((metaData.currentPage ?? 0) >= (metaData.lastPage ?? 0) / 2) &&
              (metaData.currentPage ?? 0) < (metaData.lastPage ?? 0)) ...[
            if (((metaData.currentPage ?? 0) + 2) ==
                (metaData.lastPage ?? 0)) ...[
              item(
                '${metaData.currentPage ?? 0}',
                true,
                onTap,
              ),
              item(
                '${(metaData.currentPage ?? 0) + 1}',
                false,
                onTap,
              ),
              item(
                '${(metaData.currentPage ?? 0) + 2}',
                false,
                onTap,
              ),
            ] else ...[
              item(
                '${(metaData.currentPage ?? 0) - 1}',
                false,
                onTap,
              ),
              item(
                '${(metaData.currentPage ?? 0)}',
                true,
                onTap,
              ),
              item(
                '${(metaData.currentPage ?? 0) + 1}',
                false,
                onTap,
              ),
            ],
          ] else if (metaData.currentPage == metaData.lastPage) ...[
            item(
              '${(metaData.currentPage ?? 0) - 2}',
              false,
              onTap,
            ),
            item(
              '${(metaData.currentPage ?? 0) - 1}',
              false,
              onTap,
            ),
            item(
              '${(metaData.currentPage ?? 0)}',
              true,
              onTap,
            ),
          ] else
            item(
              '${(metaData.lastPage ?? 0)}',
              false,
              onTap,
            ),
        if ((metaData.totalData ?? 0) > (metaData.size ?? 0))
          pageNavigator(
            true,
            metaData.currentPage != metaData.lastPage,
            Icons.arrow_forward_ios,
            onTap,
          ),
      ],
    );
  }

  Widget item(
    String value,
    bool isSelected,
    Function? onTap,
  ) {
    return InkWell(
      onTap: !isSelected
          ? () {
              onTap!(int.parse(value));
            }
          : null,
      child: Container(
        height: 40,
        width: 40,
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isSelected ? CustomColor.primaryBlue : Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Center(
          child: Text(
            value,
            style: titleStyle14.copyWith(
              color: isSelected ? Colors.white : CustomColor.primaryBlue,
            ),
          ),
        ),
      ),
    );
  }

  Widget pageNavigator(
    bool isIncrement,
    bool isTapable,
    IconData? icon,
    Function? onTap,
  ) {
    return InkWell(
      onTap: isTapable
          ? () {
              if (isIncrement) {
                onTap!((metaData.currentPage ?? 0) + 1);
              } else {
                onTap!((metaData.currentPage ?? 0) - 1);
              }
            }
          : null,
      child: Container(
        height: 40,
        width: 40,
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: !isTapable ? CustomColor.lightGrey : Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Center(
          child: Icon(
            icon,
            color: isTapable ? CustomColor.primaryBlue : CustomColor.darkGrey,
            size: 16,
          ),
        ),
      ),
    );
  }
}
