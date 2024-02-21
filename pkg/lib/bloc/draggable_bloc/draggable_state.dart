import 'package:equatable/equatable.dart';

class DraggableState extends Equatable{
  final double top;
  final double left;
  const DraggableState({this.top=0.0,this.left=0.0});
  DraggableState copyWith({double? top,double? left}){
    return DraggableState(
      top: top?? this.top,
      left: left?? this.left,
    );
  }
  @override
  List<Object> get props=>[top,left];
}