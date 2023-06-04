import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final double? height;
  const LoadingIndicator({
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        color: Colors.white,
      ),
      height: height ?? MediaQuery.of(context).size.height - 98.0,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          Text('Memuat data...'),
        ],
      ),
    );
  }
}
