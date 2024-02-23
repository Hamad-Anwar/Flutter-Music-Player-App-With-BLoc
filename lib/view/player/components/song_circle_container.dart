import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:music/bloc/player_bloc/player_bloc.dart';
import 'package:music/model/audio_file_model.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_svg.dart';
import '../../common_widget/soft_button.dart';

class SongCircleContainer extends StatelessWidget {
  const SongCircleContainer({super.key, required this.file, required this.image});
  final String image;
  final AudioFile file;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: MediaQuery.sizeOf(context).width,
      child: Stack(
        alignment: Alignment.topCenter,
        // fit: StackFit.expand,
        children: [
          Container(
            height: 270,
            width: 270,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                color: backgroundColor,
                boxShadow: [
                  BoxShadow(
                      color: shadowColor,
                      offset: const Offset(8, 6),
                      blurRadius: 12),
                  const BoxShadow(
                      color: Colors.white,
                      offset: Offset(-8, -6),
                      blurRadius: 12),
                ],
                shape: BoxShape.circle),
          ),
          Positioned(
            top: 20,
            child: CircularSoftButton(
              padding: 0,
              radius: 120,
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(300),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ),
          Container(
            height: 270,
            width: 270,
            padding: EdgeInsets.all(10),
            child: Transform.flip(
              flipX: true,
              child: Transform.rotate(
                angle: 0.5,
                child: RotatedBox(
                  quarterTurns: 2,
                  child: BlocBuilder<PlayerBloc, PlayerState>(
                    builder: (context, state) {
                      return CircularProgressIndicator(
                        color: blueBackground,
                        backgroundColor: Colors.grey.withOpacity(.1),
                        value: state.progress,
                        strokeWidth: 7,
                        strokeCap: StrokeCap.round,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 7,
            child: GestureDetector(
              onTap: () => context.read<PlayerBloc>().add(PlayPauseEvent(
                  file: file,
                  isPlaying: !context.read<PlayerBloc>().isPlaying)),
              child: CircleAvatar(
                radius: 32,
                backgroundColor: blueBackground,
                child: BlocBuilder<PlayerBloc, PlayerState>(
                  buildWhen: (previous, current) =>
                      previous.isPlaying != current.isPlaying,
                  builder: (context, state) {
                    return AnimatedSwitcher(
                      switchInCurve: Curves.easeInOutBack,
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(
                          scale: animation,
                          child: child,
                        );
                      },
                      duration: const Duration(milliseconds: 300),
                      child: Center(
                        child: SvgPicture.asset(
                          state.isPlaying ? AppSvg.pause : AppSvg.play,
                          color: Colors.white,
                          width: 20,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
