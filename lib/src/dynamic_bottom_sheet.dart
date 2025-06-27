import 'package:flutter/material.dart';
import 'controller.dart';

class DynamicBottomSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    required bool expand,
    bool isScroll = true,
    SheetStackController? controller,
    List<double>? snapPoints,
    double? initialSnap,
    Color? barrierColor,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    bool? useRootNavigator,
    bool? useSafeArea,
    Widget? dragHandle,
    void Function()? onOpened,
    void Function()? onClosed,
    void Function(double snap)? onSnap,
  }) {
    final stackController = controller ?? SheetStackController();

    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScroll,
      isDismissible: isDismissible,
      backgroundColor: Colors.transparent,
      barrierColor: barrierColor,
      useRootNavigator: useRootNavigator ?? false,
      useSafeArea: useSafeArea ?? false,
      builder: (sheetContext) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          stackController.push(sheetContext);
          onOpened?.call();
        });

        return _DynamicSheetWrapper(
          snapPoints: snapPoints ?? [0.3, 0.6, 1.0],
          initialSnap: initialSnap ?? 0.3,
          expand: expand,
          enableDrag: enableDrag,
          isDismissible: isDismissible,
          backgroundColor: backgroundColor,
          barrierColor: barrierColor,
          borderRadius: borderRadius,
          dragHandle: dragHandle,
          onSnap: onSnap,
          onClosed: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              stackController.pop();
              onClosed?.call();
            });
          },
          child: builder(sheetContext),
        );
      },
    );
  }
}

class _DynamicSheetWrapper extends StatefulWidget {
  final Widget child;
  final bool expand;
  final List<double> snapPoints;
  final double initialSnap;
  final bool enableDrag;
  final bool isDismissible;
  final Color? backgroundColor;
  final Color? barrierColor;
  final BorderRadius? borderRadius;
  final Widget? dragHandle;
  final void Function(double)? onSnap;
  final void Function()? onClosed;

  const _DynamicSheetWrapper({
    required this.child,
    required this.snapPoints,
    required this.initialSnap,
    required this.enableDrag,
    required this.isDismissible,
    required this.expand,
    this.backgroundColor,
    this.barrierColor,
    this.borderRadius,
    this.dragHandle,
    this.onSnap,
    this.onClosed,
  });

  @override
  State<_DynamicSheetWrapper> createState() => _DynamicSheetWrapperState();
}

class _DynamicSheetWrapperState extends State<_DynamicSheetWrapper> {
  late double _currentSnap;

  @override
  void initState() {
    super.initState();
    _currentSnap = widget.initialSnap;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (widget.isDismissible)
          GestureDetector(
            onTap: () => Navigator.of(context).maybePop(),
            child: Container(
              color: widget.barrierColor ?? Colors.transparent,
              width: double.infinity,
              height: double.infinity,
            ),
          )
        else
          IgnorePointer(
            child: Container(
              color: widget.barrierColor ?? Colors.transparent,
              width: double.infinity,
              height: double.infinity,
            ),
          ),

        // Bottom Sheet Layer
        DraggableScrollableSheet(
          initialChildSize: _currentSnap,
          minChildSize: widget.snapPoints.reduce((a, b) => a < b ? a : b),
          maxChildSize: widget.snapPoints.reduce((a, b) => a > b ? a : b),
          expand: widget.expand,
          builder: (context, scrollController) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? Theme.of(context).cardColor,
                borderRadius:
                    widget.borderRadius ??
                    BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 16,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    widget.dragHandle ??
                        Container(
                          margin: const EdgeInsets.only(top: 12, bottom: 8),
                          width: 40,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: widget.child,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    widget.onClosed?.call();
    super.dispose();
  }
}
