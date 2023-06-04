import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/enums/connectivity_status.dart';
import 'no_network.dart';

class NetworkSensitive extends StatelessWidget {
  final Widget child;

  const NetworkSensitive({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final connectionStatus = Provider.of<ConnectivityStatus>(context);

    if (connectionStatus == ConnectivityStatus.offline) {
      return const NoNetwork();
    }

    return child;
  }
}
