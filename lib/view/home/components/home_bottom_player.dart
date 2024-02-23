import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../bloc/player_bloc/player_bloc.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_icons.dart';
import '../../../res/app_svg.dart';

class HomeBottomPlayer extends StatelessWidget {
  const HomeBottomPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      // buildWhen: (previous, current) => previous.progress != current.progress,
      builder: (context, state) {
        // print(state.file==null? '' : state.file!.name.toString());
        return AnimatedPositioned(
            bottom: state.status == SongStatus.playing ? 20 : -150,
            duration: const Duration(milliseconds: 300),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width - 40,
                child: Center(
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: Container(
                        height: 80,
                        width: 350,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 27,
                              backgroundImage: AssetImage(AppIcons.splashIcons),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BlocBuilder<PlayerBloc, PlayerState>(
                                    builder: (context, state) {
                                      return Text(
                                        state.file == null
                                            ? ''
                                            : state.file!.name.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                      );
                                    },
                                  ),
                                  Text(
                                    state.file == null
                                        ? ''
                                        : state.file!.length.toString(),
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  SizedBox(
                                    width: 120,
                                    child: LinearProgressIndicator(
                                      borderRadius: BorderRadius.circular(10),
                                      backgroundColor:
                                      Colors.grey.withOpacity(.1),
                                      color: blueBackground,
                                      value: state.progress,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: 20,),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context
                                        .read<PlayerBloc>()
                                        .add(OnTapBackwardEvent());
                                  },
                                  child: RotatedBox(
                                      quarterTurns: 2,
                                      child: SvgPicture.asset(
                                        AppSvg.prev,
                                        height: 20,
                                      )),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    final bloc = context.read<PlayerBloc>();
                                    bloc.add(PlayPauseEvent(
                                        isPlaying: !bloc.state.isPlaying,
                                        file: bloc.state.file!));
                                  },
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: blueBackground,
                                    child: Center(
                                      child:
                                      BlocBuilder<PlayerBloc, PlayerState>(
                                        builder: (context, state) {
                                          return SvgPicture.asset(
                                            state.isPlaying
                                                ? AppSvg.pause
                                                : AppSvg.play,
                                            color: Colors.white,
                                            width: 15,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context
                                        .read<PlayerBloc>()
                                        .add(OnTapForwardEvent());
                                  },
                                  child: SvgPicture.asset(
                                    AppSvg.next,
                                    height: 20,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
