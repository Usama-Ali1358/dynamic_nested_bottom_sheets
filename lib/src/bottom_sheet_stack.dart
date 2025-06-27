import 'package:flutter/material.dart';
import 'controller.dart';
import 'back_drop.dart';

class BottomSheetStack extends StatefulWidget {
  final Widget child;
  final SheetStackController? controller;
  final double backdropBlur;
  final Color backdropColor;

  const BottomSheetStack({
    super.key,
    required this.child,
    this.controller,
    this.backdropBlur = 12,
    this.backdropColor = const Color(0x80000000),
  });

  @override
  State<BottomSheetStack> createState() => _BottomSheetStackState();
}

class _BottomSheetStackState extends State<BottomSheetStack> {
  late SheetStackController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? SheetStackController();
    _controller.addListener(_onStackChanged);
  }

  void _onStackChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onStackChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_controller.hasSheets)
          SheetBackdrop(blur: widget.backdropBlur, color: widget.backdropColor),
      ],
    );
  }
}
