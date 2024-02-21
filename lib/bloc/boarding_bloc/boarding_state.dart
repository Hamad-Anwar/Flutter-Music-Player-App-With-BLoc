import 'package:equatable/equatable.dart';

class BoardingState extends Equatable{

  final int index;
  const BoardingState({this.index=0});


  BoardingState copyWith({int? index}){
    return BoardingState(
      index: index??this.index
    );
  }
  @override
  List<Object?> get props => [index];

}