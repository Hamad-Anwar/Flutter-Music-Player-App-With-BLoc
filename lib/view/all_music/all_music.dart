import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music/bloc/album_bloc/album_event.dart';
import 'package:music/view/all_music/components/folders_list.dart';
import 'package:music/view/all_music/components/song_list.dart';
import 'package:music/view/common_widget/app_bar.dart';
import 'package:music/view/home/components/home_bottom_player.dart';

import '../../bloc/album_bloc/album_bloc.dart';
import '../../bloc/album_bloc/album_state.dart';

class AllMusicAlbum extends StatelessWidget {
  const AllMusicAlbum({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: ()async{
          if(context.read<AlbumBloc>().currentPage==0){
            return true;
          }else{
            context.read<AlbumBloc>().add(BackArrowTap(context: context));
            return false;
          }
        },
        child: SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: BlocBuilder<AlbumBloc, AlbumState>(
                      buildWhen: (previous, current) => previous.appBarTitle!=current.appBarTitle,
                      builder: (context, state) {
                        return CustomAppBar(
                          title: state.appBarTitle,
                          preIcon: GestureDetector(
                            onTap: () => context.read<AlbumBloc>().add(BackArrowTap(context: context)),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 20,
                            ),
                          ),
                          postIcon: const Icon(Icons.more_horiz_rounded),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(child: PageView(
                    controller: context
                        .read<AlbumBloc>()
                        .pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      FolderList(),
                      SongList(),
                    ],
                  ))
                ],
              ),
              const HomeBottomPlayer(),
            ],
          ),
        ),
      ),
    );
  }
}
