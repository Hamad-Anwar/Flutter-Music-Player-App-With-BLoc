import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music/db_helper/db_helper.dart';
import 'package:music/model/audio_file_model.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final AudioPlayer player;
  bool isPlaying = false;
  Timer? timer;
  final dbHelper = DbHelper();

  PlayerBloc({
    required this.player,
  }) : super(const PlayerState()) {
    on(_onPlayPauseEvent);
    on(_onPlayEvent);
    on(_progressUpdate);
    on(_onTapFavouriteEvent);
    on(_onTapForwardEvent);
    on(_onTapBackwardEvent);
  }

  Future<void> _onPlayPauseEvent(
      PlayPauseEvent event, Emitter<PlayerState> emit) async {
    if (isPlaying) {
      player.pause();
      emit(state.copyWith(
        isPlaying: false,
      ));
    } else {
      player.play();
      emit(state.copyWith(
        isPlaying: true,
      ));
    }
    isPlaying = event.isPlaying;
  }

  Future<void> _onPlayEvent(
      OnPlayEvent event, Emitter<PlayerState> emit) async {
    await player.setFilePath(event.file.path.toString());
    player.play();
    isPlaying = true;
    double progress = 0.0;
    emit(state.copyWith(
        isPlaying: true,
        isFavourite: event.file.isFavourite == 1,
        status: SongStatus.playing,
        file: event.file));
    Timer.periodic(const Duration(milliseconds: 1), (timer) {
      progress = player.duration == null
          ? 0.0
          : player.position.inMilliseconds / player.duration!.inMilliseconds;
      add(ProgressUpdateEvent(progress: progress));
      if (progress >= 1.0) {
        timer.cancel();
      }
    });
  }

  Future<void> _progressUpdate(
      ProgressUpdateEvent event, Emitter<PlayerState> emit) async {
    if (event.progress == 1.0) {
      // player.pause();
      // player.seek(const Duration(seconds: 0));
      // emit(state.copyWith(progress: 0.0,isPlaying: false));
      add(OnPlayEvent(file: state.file!));
    } else {
      emit(state.copyWith(
        progress: event.progress,
      ));
    }
  }

  Future<void> _onTapFavouriteEvent(
      OnTapFavouriteEvent event, Emitter<PlayerState> emit) async {
    final alreadyExist =
        await dbHelper.isFavoriteExists(event.file.name.toString());
    if (alreadyExist) {
      showDialog(
        context: event.context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              'Warning',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
            content: Text(
              'This soong is already in favourite list, are you sure to delete it',
              style: TextStyle(
                color: Colors.black,
                fontSize: 10,
              ),
            ),
            actions: [
              InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    'Cancle',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  )),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () async {
                  await dbHelper.delete(event.file.name.toString());
                  Navigator.pop(context);
                  emit(state.copyWith(isFavourite: false));
                },
                child: Text(
                  'ok',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
            ],
          );
        },
      );
    } else {
      await dbHelper.insert(event.file);
      emit(state.copyWith(isFavourite: true));

    }
  }

  void _onTapForwardEvent(OnTapForwardEvent event, Emitter<PlayerState> emit) {
    if (player.position.inSeconds < player.duration!.inSeconds - 10) {
      player.seek(Duration(seconds: player.position.inSeconds + 10));
      emit(state.copyWith(
          progress: player.position.inMilliseconds /
              player.duration!.inMilliseconds));
    }
  }

  void _onTapBackwardEvent(
      OnTapBackwardEvent event, Emitter<PlayerState> emit) {
    if (player.position.inSeconds > 10) {
      player.seek(Duration(seconds: player.position.inSeconds - 10));
    } else {
      player.seek(const Duration(seconds: 0));
    }
    emit(state.copyWith(
        progress:
            player.position.inMilliseconds / player.duration!.inMilliseconds));
  }
}
