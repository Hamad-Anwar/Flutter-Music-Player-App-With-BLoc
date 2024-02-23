import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music/view/all_music/components/song_list.dart';

import '../../../bloc/album_bloc/album_bloc.dart';
import '../../../bloc/album_bloc/album_event.dart';
import '../../../bloc/album_bloc/album_state.dart';
import '../../common_widget/app_bar.dart';
class SongListFolder extends StatelessWidget {
  const SongListFolder({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: true,
        // onPopInvoked: (didPop) {
        //   context.read<AlbumBloc>().add(
        //       BackArrowTap(context: context)
        //   );
        // },
        onPopInvoked: (didPop) {

        },
        child: SafeArea(child: Column(
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
                      onTap: () {
                        context.read<AlbumBloc>().add(BackArrowTap(context: context));
                        Navigator.pop(context);
                      },
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
            Expanded(child: SongList())
          ],
        )),
      ),
    );
  }
}
