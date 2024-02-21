part of 'player_bloc.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();
  @override
  List<Object> get props=>[];
}
class PlayPauseEvent extends PlayerEvent{
  final bool isPlaying;
  final double progress;
  final AudioFile file;
  const PlayPauseEvent({required this.isPlaying,required this.file,this.progress=0.0});
  @override
  List<Object> get props=>[isPlaying,file,progress];
}
class OnPlayEvent extends PlayerEvent{
  final bool isPlaying;
  final AudioFile file;

  const OnPlayEvent({ this.isPlaying=true,required this.file});
  @override
  List<Object> get props=>[isPlaying,file];
}
class OnTapPrevEvent extends PlayerEvent{}
class ProgressUpdateEvent extends PlayerEvent{
  final double progress;
  const ProgressUpdateEvent({required this.progress});
  @override
  List<Object> get props=>[progress];
}
class OnTapFavouriteEvent extends PlayerEvent{
  final AudioFile file;
  final BuildContext context;
  const OnTapFavouriteEvent({required this.file,required this.context});
  @override
  List<Object> get props=>[file,context];
}

class OnTapForwardEvent extends PlayerEvent{}
class OnTapBackwardEvent extends PlayerEvent{}



