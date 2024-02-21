
import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import '../../draggable_widget.dart';
import 'draggable_event.dart';
import 'draggable_state.dart';
/// DraggableBloc responsible for managing the state of the draggable widget.
class DraggableBloc extends Bloc<DraggableEvent, DraggableState> {
  final InitialPosition initialPosition;
  final Widget widget;
  final double height;
  final double width;
  final double? left;
  final double? top;
  final BuildContext context;

  /// Constructor for DraggableBloc.
  ///
  /// Parameters:
  ///  - initialPosition: the initial position of the draggable widget.
  ///  - context: the build context.
  ///  - widget: the draggable widget.
  ///  - height: the height of the draggable widget.
  ///  - width: the width of the draggable widget.
  ///  - left: optional left position for custom initial position.
  ///  - top: optional top position for custom initial position.
  DraggableBloc({
    required this.initialPosition,
    required this.context,
    required this.widget,
    required this.height,
    required this.width,
    this.left,
    this.top,
  }) : super(const DraggableState()) {
    _initializeEventListeners();
    add(InitialPositionEvent());
  }

  /// Initializes event listeners.
  void _initializeEventListeners() {
    on<InitialPositionEvent>(_setInitialPosition);
    on<DragEvent>(_onDragEvent);
    on<ScreenOrientationEvent>(_orientationChangeEvent);
  }


  /// Updates the draggable widget's position on drag events.
  void _onDragEvent(DragEvent event, Emitter<DraggableState> emit) {
    emit(state.copyWith(top: event.top, left: event.left));
  }
  /// Orientation change event
  void _orientationChangeEvent(ScreenOrientationEvent event, Emitter<DraggableState> emit) {
    emit(state.copyWith());
  }
  /// Sets the initial position of the draggable widget based on the chosen initial position.
  void _setInitialPosition(InitialPositionEvent event, Emitter<DraggableState> emit) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenPadding=MediaQuery.of(context).padding.top;
    final screenHeight=screenSize.height-screenPadding-AppBar().preferredSize.height;
    double left = 0;
    double top = 0;

    switch (initialPosition) {
      case InitialPosition.center:
        left = (screenSize.width - width) / 2;
        top = (screenHeight - height) / 2;
        break;
      case InitialPosition.topCenter:
        left = (screenSize.width - width) / 2;
        top = 0;
        break;
      case InitialPosition.bottomCenter:
        left = (screenSize.width - width) / 2;
        top = screenHeight - height;
        break;
      case InitialPosition.leftCenter:
        left = 0;
        top = (screenHeight - height) / 2;
        break;
      case InitialPosition.rightCenter:
        left = screenSize.width - width;
        top = (screenHeight - height) / 2;
        break;
      case InitialPosition.topRightCorner:
        left = screenSize.width - width;
        top = 0;
        break;
      case InitialPosition.bottomRightCorner:
        left = screenSize.width - width;
        top = screenHeight - height;
        break;
      case InitialPosition.topLeftCorner:
        left = 0;
        top = 0;
        break;
      case InitialPosition.bottomLeftCorner:
        left = 0;
        top = screenHeight - height;
        break;
      case InitialPosition.custom:
        left = this.left!;
        top = this.top!;
        break;
      default:
        break;
    }
    emit(state.copyWith(top: top-30, left: left));
  }
}

