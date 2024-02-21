import 'package:equatable/equatable.dart';
import 'package:music/model/audio_file_model.dart';

import '../home_bloc/home_state.dart';

class AlbumState extends Equatable{
  final Status fileStatus;
  final List<AudioFile> audioFiles;
  final List<Map<String,String>> folders;
  final String appBarTitle;
  const AlbumState({this.audioFiles=const [],this.folders=const [],this.appBarTitle='Albums',this.fileStatus=Status.loading});
  AlbumState copyWith({List<AudioFile>? audioFiles, List<Map<String,String>>? folders,String? appBarTitle,Status? fileStatus}){
    return AlbumState(
      appBarTitle: appBarTitle?? this.appBarTitle,
      audioFiles: audioFiles?? this.audioFiles,
      folders: folders?? this.folders,
      fileStatus: fileStatus ?? this.fileStatus
    );
  }
  @override
  List<Object> get props=>[audioFiles,folders,fileStatus];
}
