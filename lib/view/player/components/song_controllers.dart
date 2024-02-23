import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:music/bloc/home_bloc/home_bloc.dart';
import 'package:music/bloc/home_bloc/home_event.dart';
import 'package:music/bloc/player_bloc/player_bloc.dart';
import 'package:music/model/audio_file_model.dart';
import 'package:music/res/app_colors.dart';
import 'package:music/view/common_widget/soft_button.dart';
import '../../../res/app_svg.dart';

class SongControllers extends StatelessWidget {
  const SongControllers({super.key, required this.file});
  final AudioFile file;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // SvgPicture.asset(AppSvg.loop, width: 20,),
        GestureDetector(
            child: const Icon(Icons.volume_down_alt,color: Colors.black,)),
        const SizedBox(width: 20,),
        GestureDetector(
          onTap: () => context.read<PlayerBloc>().add(OnTapBackwardEvent()),
          child: RotatedBox(
              quarterTurns: 2,
              child: SvgPicture.asset(AppSvg.prev, width: 25,)),
        ),
        const SizedBox(width: 20,),
        CircularSoftButton(
          radius: 25,
          padding: 0,
          icon: GestureDetector(
            onTap: () async {
              try{
                context.read<PlayerBloc>().add(OnTapFavouriteEvent(file: file,context: context));
              }catch(_){

              }
              Timer(const Duration(milliseconds: 500), () {
                context.read<HomeBloc>().add(GetFavSongEvent());
              });

            },
            child: BlocBuilder<PlayerBloc, PlayerState>(
              builder: (context, state) {
                return Icon( Icons.favorite, color: state.isFavourite ? blueBackground :Colors.black87,);
              },
            ),
          ),
        ),
        const SizedBox(width: 20,),
        GestureDetector(
            onTap: () => context.read<PlayerBloc>().add(OnTapForwardEvent()),
            child: SvgPicture.asset(AppSvg.next, width: 25,)),
        const SizedBox(width: 20,),
        SvgPicture.asset(AppSvg.loop, width: 20,),
      ],
    );
  }
}
