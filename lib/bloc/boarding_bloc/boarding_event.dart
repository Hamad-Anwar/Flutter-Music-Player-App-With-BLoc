import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class BoardingEvent extends Equatable{
  @override
  List<Object> get props=>[];
}

class OnPageChangeEvent extends BoardingEvent{
  final int index;
  OnPageChangeEvent({required this.index});
  @override
  List<Object> get props=>[index];
}

class OnSkipTapEvent extends BoardingEvent{
  final BuildContext? context;
  OnSkipTapEvent({this.context});
  @override
  List<Object> get props=>[];
}
class LetsGoTapEvent extends BoardingEvent{
  final BuildContext? context;
  LetsGoTapEvent({this.context});
  @override
  List<Object> get props=>[];
}