import 'package:equatable/equatable.dart';
abstract class DraggableEvent extends Equatable{
  @override
  List<Object> get props=>[];
}
class InitialPositionEvent extends DraggableEvent{}
class ScreenOrientationEvent extends DraggableEvent{}
class ChangeDraggingState extends DraggableEvent{
  final bool isDragging;
  ChangeDraggingState({required this.isDragging});
  @override
  List<Object> get props=>[isDragging];
}
class DragEvent extends DraggableEvent{
  final double top;
  final double left;
  DragEvent({required this.top,required this.left});
  @override
  List<Object> get props=>[top,left];
}


