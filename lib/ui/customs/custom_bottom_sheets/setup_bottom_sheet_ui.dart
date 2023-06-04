import 'package:stacked_services/stacked_services.dart';

import '../../../application/app/app.locator.dart';
import '../../../application/enums/bottom_sheet_type.dart';
import 'confirmation_bottom_sheet.dart';

void setupBottomSheetUI() {
  final bottomSheetService = locator<BottomSheetService>();

  final builders = {
    BottomSheetType.confirmation: (context, sheetRequest, completer) =>
        ConfirmationBottomSheet(
          request: sheetRequest as SheetRequest,
          completer: completer as Function(SheetResponse),
        ),
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}
