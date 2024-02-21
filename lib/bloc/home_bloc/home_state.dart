import 'package:equatable/equatable.dart';
import 'package:music/model/audio_file_model.dart';
enum Status{loading,complete}
class HomeState extends Equatable {
  final List<AudioFile> songList;
  final Status songListStatus;
  final Status favSongListStatus;
  final List<AudioFile> favouriteSongs;
  const HomeState({this.songList = const [], this.favouriteSongs = const [],
    this.favSongListStatus=Status.loading,
    this.songListStatus=Status.loading
  });
  HomeState copyWith({List<AudioFile>? songList, List<AudioFile>? favouriteSongs,Status? favSongListStatus,Status? songListStatus}) {
    return HomeState(
      favouriteSongs: favouriteSongs?? this.favouriteSongs,
      songList: songList?? this.songList,
      favSongListStatus: favSongListStatus?? this.favSongListStatus,
      songListStatus: songListStatus?? this.songListStatus
    );
  }
  @override
  List<Object> get props => [songList,favouriteSongs,songListStatus,favSongListStatus];
}
