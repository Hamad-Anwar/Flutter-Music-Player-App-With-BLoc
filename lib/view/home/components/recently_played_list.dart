import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music/bloc/home_bloc/home_bloc.dart';
import 'package:music/bloc/home_bloc/home_state.dart';
import 'package:music/res/app_colors.dart';
import 'package:music/res/app_svg.dart';
import 'package:music/utils/utils.dart';
import 'package:music/view/player/player.dart';
import 'package:shimmer_effect/shimmer_effect.dart';

import '../../../bloc/player_bloc/player_bloc.dart';

class RecentlyPlayedList extends StatelessWidget {
  const RecentlyPlayedList({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.favSongListStatus != current.favSongListStatus,
      builder: (context, s) {
        if (s.favSongListStatus == Status.complete) {
          return BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (previous, current) =>
                current.favouriteSongs != previous.favouriteSongs,
            builder: (context, state) {
              if (s.favouriteSongs.isEmpty) {
                return const SizedBox.shrink();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Favourite Songs',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: size.width,
                      height: 120,
                      child: ListView.builder(
                        itemCount: state.favouriteSongs.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final String image = Utils.getRandomImage();
                          return GestureDetector(
                            onTap: () {
                              context.read<PlayerBloc>().add(OnPlayEvent(
                                  file: state.favouriteSongs[index]));
                              Utils.go(
                                context: context,
                                screen: Player(
                                    file: state.favouriteSongs[index],
                                    image: image),
                              );
                            },
                            child: Container(
                              height: 120,
                              width: 130,
                              margin: EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: AssetImage(image),
                                      fit: BoxFit.cover)),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: ClipRect(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 3, sigmaY: 3),
                                        child: Container(
                                          height: 37,
                                          width: 110,
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.black26),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 3),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    state.favouriteSongs[index]
                                                            .name!
                                                            .substring(0, 8) +
                                                        '...',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        height: 0),
                                                  ),
                                                  Text(
                                                    state.favouriteSongs[index]
                                                        .length
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white70,
                                                        fontSize: 10,
                                                        height: 0),
                                                  )
                                                ],
                                              ),
                                              Spacer(),
                                              CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 10,
                                                child: Center(
                                                  child: SvgPicture.asset(
                                                    AppSvg.play,
                                                    width: 10,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )),
                ],
              );
            },
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Favourite Songs',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                width: size.width,
                height: 120,
                child: ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Stack(
                        children: [
                          ShimmerEffect(
                            baseColor: backgroundColor,
                            highlightColor: shadowColor,
                            child: Container(
                              height: 120,
                              width: 130,
                              margin: EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Stack(
                                children: [],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: ClipRect(
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: ShimmerEffect(
                                  baseColor: Colors.white,
                                  highlightColor: shadowColor,
                                  child: Container(
                                    height: 37,
                                    width: 110,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black26),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 3),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 70,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              width: 40,
                                              height: 7,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 10,
                                          child: Center(
                                            child: SvgPicture.asset(
                                              AppSvg.play,
                                              width: 10,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                )),
          ],
        );
      },
    );
  }
}
