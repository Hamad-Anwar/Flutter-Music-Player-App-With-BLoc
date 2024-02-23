import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:music/bloc/album_bloc/album_event.dart';
import 'package:music/bloc/album_bloc/album_state.dart';
import 'package:music/bloc/home_bloc/home_state.dart';
import 'package:music/view_model/services/audio_query_services.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final PageController pageController;
  int currentPage = 0;
  AlbumBloc({required this.pageController}) : super(const AlbumState()) {
    on(_getFilesEvent);
    on(_folderTapEvent);
    on(_backArrowClick);
    on(_loadingStatusChange);
  }

  Future<void> _getFilesEvent(GetFolderEvent event,
      Emitter<AlbumState> emit) async {
    emit(state.copyWith(folders: await AudioFileQueries.getFolders()));
  }

  Future<void> _folderTapEvent(FolderTapEvent event,
      Emitter<AlbumState> emit) async {
    add(LoadingStatusChange(status: Status.loading));
    try{
      pageController.animateToPage(1,
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
      currentPage = 1;
    }catch(_){

    }
    emit(state.copyWith(
        audioFiles: await AudioFileQueries.getFiles(event.path),
        appBarTitle: event.folderName));
    add(LoadingStatusChange(status: Status.complete));
  }

  Future<void> _backArrowClick(BackArrowTap event,
      Emitter<AlbumState> emit) async {
    if (currentPage == 1) {
      try{
        pageController.animateToPage(0,
            duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
        currentPage = 0;
      }catch(_){

      }
      emit(state.copyWith(audioFiles: [], appBarTitle: 'Album'));
    }else{
      Navigator.pop(event.context);
    }
  }
  void _loadingStatusChange(LoadingStatusChange event,
      Emitter<AlbumState> emit) {
    emit(state.copyWith(fileStatus: event.status));
  }
}
