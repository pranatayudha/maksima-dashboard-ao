import 'flavors.dart';
import 'main_common.dart';

Future main() async {
  F.appFlavor = Flavor.PROD;
  await mainCommon();
}
