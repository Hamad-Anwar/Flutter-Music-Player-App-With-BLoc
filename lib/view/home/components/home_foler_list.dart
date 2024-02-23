import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:layout_pro/responsive_layout.dart';
import 'package:music/view/home/components/song_list_home.dart';

import '../../../bloc/album_bloc/album_bloc.dart';
import '../../../bloc/album_bloc/album_event.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_svg.dart';
import '../../../utils/utils.dart';
import '../../all_music/all_music.dart';

class HomeFolderList extends StatelessWidget {
  const HomeFolderList({super.key, this.state});
  final state;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20,),
        Row(
          children: [
            const Text(
              'Album',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                context.read<AlbumBloc>().add(GetFolderEvent());
                Utils.go(context: context, screen: AllMusicAlbum());
              },
              child: const Text(
                'See all',
                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        Expanded(
          child: ResponsiveLayout(
              mobileCrossAxisCount: 1,
              mobileRatio: 4.4,
              largeMobileCrossAxisCount: 1,
              largeMobileRatio: 5.8,
              tabletCrossAxisCount: 3,
              tabletRatio: 3.9,
              largeTabletCrossAxisCount: 4,
              largeTabletRatio: 4,
              desktopRatio: 4,
              desktopScreenCrossAxisCount: 4,
              builder: (context, index) {
                return Padding(
                  padding: !ResponsiveLayout.isLargeMobile(
                      context) ?
                  const EdgeInsets.only(
                      top: 20, right: 20, left: 20) :
                  const EdgeInsets.only(top: 20)
                  ,
                  child: GestureDetector(
                    onTap: () async {
                      context.read<AlbumBloc>().add(
                          FolderTapEvent(path: state.folders[index]['path'].toString(),
                              folderName: state.folders[index]['name'].toString())
                      );
                      Utils.go(context: context, screen: const SongListFolder());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(
                            5),
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.folder_rounded,
                            color: Colors.orangeAccent,
                            size: 30,
                          ),
                          const SizedBox(width: 10,),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state
                                      .folders[index]['name'].toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                const Text(
                                  'Listen Music',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          const Spacer(),
                          RotatedBox(
                              quarterTurns: 1,
                              child: SvgPicture.asset(
                                AppSvg.more,
                                height: 16,
                                color: Colors.grey,
                              ))
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: state.folders.length),
        ),
      ],
    );
  }
}