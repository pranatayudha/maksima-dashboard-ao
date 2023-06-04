import 'package:flutter/material.dart';

class TitleWithCountBox extends StatefulWidget {
  final String title;
  final dynamic count;
  final Color? color;
  final int align;
  const TitleWithCountBox({
    Key? key,
    required this.title,
    required this.count,
    this.color,
    this.align = 1,
  }) : super(key: key);

  @override
  State<TitleWithCountBox> createState() => _TitleWithCountBoxState();
}

class _TitleWithCountBoxState extends State<TitleWithCountBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      width: 304,
      decoration: const BoxDecoration(
        color: Color(0xffF6F6F8),
        boxShadow: [BoxShadow(color: Color(0xffE5E5E5), spreadRadius: 1.0)],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(11.2, 8, 0, 8),
        child: Column(
          crossAxisAlignment: widget.align == 1
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff66788A),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.count,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: widget.color ?? const Color(0xff03213E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
