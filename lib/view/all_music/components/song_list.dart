import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout_pro/responsive_layout.dart';
import 'package:music/bloc/album_bloc/album_bloc.dart';
import 'package:music/bloc/home_bloc/home_state.dart';
import 'package:music/utils/utils.dart';
import 'package:music/view/common_widget/loading_files.dart';
import 'package:music/view/home/components/song_widget.dart';

import '../../../bloc/album_bloc/album_state.dart';
import '../../../bloc/player_bloc/player_bloc.dart';
import '../../../res/app_colors.dart';
import '../../player/player.dart';

class SongList extends StatelessWidget {
  const SongList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumBloc, AlbumState>(
      buildWhen: (previous, current) => previous.fileStatus!=current.fileStatus,
      builder: (context, s) {
        if(s.fileStatus==Status.complete){
          return BlocBuilder<AlbumBloc, AlbumState>(
            buildWhen: (previous, current) =>
            previous.audioFiles != current.audioFiles,
            builder: (context, state) {
              return ResponsiveLayout(
                  mobileCrossAxisCount: 1,
                  mobileRatio: 4.4,
                  largeMobileCrossAxisCount: 1,
                  largeMobileRatio: 5.8,
                  tabletCrossAxisCount: 3,
                  tabletRatio: 4,
                  largeTabletCrossAxisCount: 4,
                  largeTabletRatio: 4,
                  desktopRatio: 4,
                  desktopScreenCrossAxisCount: 4,
                  builder: (context, index) {
                    final String image = Utils.getRandomImage();
                    return Padding(
                      padding: !ResponsiveLayout.isLargeMobile(context)
                          ? const EdgeInsets.only(top: 10, right: 20, left: 20)
                          : const EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: GestureDetector(
                        onTap: () {
                          context
                              .read<PlayerBloc>()
                              .add(OnPlayEvent(file: state.audioFiles[index]));
                          Utils.go(
                              context: context,
                              screen: Player(
                                file: state.audioFiles[index],
                                image: image,
                              ));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                  color: shadowColor,
                                  offset: Offset(8, 6),
                                  blurRadius: 12),
                              BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-8, -6),
                                  blurRadius: 12),
                            ],
                          ),
                          child: SongWidget(
                              image: image,
                              name: state.audioFiles[index].name.toString(),
                              length: state.audioFiles[index].length.toString(), file: state.audioFiles[index],),
                        ),
                      ),
                    );
                  },
                  itemCount: state.audioFiles.length);
            },
          );
        }else{
          return const FilesLoading();
        }
      },
    );
  }
}
