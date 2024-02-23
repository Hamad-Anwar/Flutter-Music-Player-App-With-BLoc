import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music/model/audio_file_model.dart';
import 'package:music/res/app_svg.dart';
import 'package:music/view/common_widget/app_bar.dart';
import 'package:music/view/player/components/song_bottom_contianer.dart';
import 'package:music/view/player/components/song_controllers.dart';
import 'package:music/view/player/components/song_title.dart';

import 'components/song_circle_container.dart';
class Player extends StatelessWidget {
  const Player({super.key, required this.file, required this.image});
  final AudioFile file;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 1,
              height: MediaQuery.sizeOf(context).height-100,
              width: MediaQuery.sizeOf(context).width,
              child: Center(
                child: SongCircleContainer(file : file,image:image,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
              child: Column(
                children: [
                  CustomAppBar(
                    preIcon: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Colors.black,
                      ),
                    ),
                    postIcon: SvgPicture.asset(
                      AppSvg.more,
                      width: 17,
                    ),
                  ),
                  SongTitle(file: file,),
                  Spacer(),
                  SongControllers(file: file,),
                  const SizedBox(height: 50,),
                  const SongBottomContainer(),
                  // SizedBox(height: 40,)
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
