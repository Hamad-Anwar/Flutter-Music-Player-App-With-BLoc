import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:music/bloc/home_bloc/home_state.dart';

abstract class AlbumEvent extends Equatable{
  @override
  List<Object> get props=>[];
}

class FolderTapEvent extends AlbumEvent{
  final String folderName;
  final String path;
  FolderTapEvent({required this.path,required this.folderName});
  @override
  List<Object> get props=>[folderName,path];
}
class GetFolderEvent extends AlbumEvent{}
class LoadingStatusChange extends AlbumEvent{
  final Status status;
  LoadingStatusChange({required this.status});
}
class BackArrowTap extends AlbumEvent{
  final BuildContext context;
  BackArrowTap({required this.context});
  @override
  List<Object> get props=>[context];
}