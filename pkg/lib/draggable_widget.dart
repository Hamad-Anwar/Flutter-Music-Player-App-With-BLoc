import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/draggable_bloc/draggable_bloc.dart';
import 'bloc/draggable_bloc/draggable_event.dart';
import 'bloc/draggable_bloc/draggable_state.dart';

class DraggableWidget extends StatelessWidget {
  final Widget widget;
  final double height;
  final double width;
  final double dragSpeed;
  final InitialPosition initialPosition;
  final double? left;
  final double? top;

  /// DraggableWidget constructor.
  /// Parameters:
  ///  - widget: the widget to be draggable.
  ///  - height: the height of the draggable widget.
  ///  - width: the width of the draggable widget.
  ///  - dragSpeed: the speed of dragging.
  ///  - initialPosition: the initial position of the draggable widget.
  ///  - left: optional left position for custom initial position.
  ///  - top: optional top position for custom initial position.
  DraggableWidget({
    Key? key,
    required this.widget,
    required this.initialPosition,
    required this.height,
    required this.width,
    this.dragSpeed = 2.0,
    this.left,
    this.top,
  }) : super(key: key) {
    _validateInput();
  }

  /// Validates input parameters.
  void _validateInput() {
    if (dragSpeed <= 0) {
      throw Exception("Drag speed must be greater than 0");
    }
    if (initialPosition == InitialPosition.custom) {
      if (left == null) {
        throw Exception(
            "You have to set left position with custom initial position");
      }
      if (top == null) {
        throw Exception(
            "You have to set top position with custom initial position");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
          create: (_) => DraggableBloc(
                context: context,
                height: height,
                initialPosition: initialPosition,
                widget: widget,
                width: width,
                left: left,
                top: top,
              ),
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height -
                MediaQuery.of(context).padding.top,
            width: MediaQuery.sizeOf(context).width,
            child: Builder(
              builder: (context) {
                return Overlay(
                  initialEntries: [
                    OverlayEntry(
                      builder: (context) {
                        return BlocBuilder<DraggableBloc, DraggableState>(
                          builder: (context, state) {
                            return _buildPositioned(context, state);
                          },
                        );
                      },
                    )
                  ],
                );
              },
            ),
          )),
    );
  }

  /// Builds the Positioned widget.
  Widget _buildPositioned(BuildContext context, DraggableState state) {
    var height =
        MediaQuery.sizeOf(context).height - MediaQuery.of(context).padding.top;
    var width = MediaQuery.sizeOf(context).width;
    return Positioned(
      /// Set position of the widget with the constrains
      top: _getVerticalPosition(state.top, height-AppBar().preferredSize.height),
      left: _getBoundedPosition(state.left, width),
      child: GestureDetector(
        onPanUpdate: (details) {
          context.read<DraggableBloc>().add(
                DragEvent(
                  top: _getVerticalPosition(
                      state.top + details.delta.dy * dragSpeed, height-AppBar().preferredSize.height),
                  left: _getBoundedPosition(
                      state.left + details.delta.dx * dragSpeed, width),
                ),
              );
        },
        child: widget,
      ),
    );
  }

  /// Ensures the value stays within bounds (0 to maxValue - width).
  double _getBoundedPosition(double value, double maxValue) {
    return max(0, min(value, maxValue - width));
  }

  /// Ensures the value stays within bounds (0 to maxValue - height).
  double _getVerticalPosition(double value, double maxValue) {
    return max(0, min(value, maxValue - height));
  }
}

/// Enum defining initial positions for the draggable widget.
enum InitialPosition {
  center,
  topCenter,
  leftCenter,
  rightCenter,
  bottomCenter,
  topRightCorner,
  bottomRightCorner,
  topLeftCorner,
  bottomLeftCorner,
  custom
}
