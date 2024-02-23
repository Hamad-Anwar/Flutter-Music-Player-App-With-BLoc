import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:layout_pro/responsive_layout.dart';
import 'package:shimmer_effect/shimmer_effect.dart';

import '../../res/app_colors.dart';
import '../../res/app_svg.dart';

class FilesLoading extends StatelessWidget {
  const FilesLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      itemCount: Random().nextInt(20),
      mobileCrossAxisCount: 1,
      mobileRatio: 4.7,
      largeMobileCrossAxisCount: 1,
      largeMobileRatio: 5.8,
      tabletCrossAxisCount: 3,
      tabletRatio: 4,
      largeTabletCrossAxisCount: 4,
      largeTabletRatio: 4,
      desktopRatio: 4,
      desktopScreenCrossAxisCount: 4,
      builder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: shadowColor, offset: const Offset(8, 6), blurRadius: 12),
                const BoxShadow(
                    color: Colors.white, offset: Offset(-8, -6), blurRadius: 12),
              ],
            ),
            child: ShimmerEffect(
              baseColor: Colors.white,
              highlightColor: shadowColor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 27,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: 50,
                          height: 7,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
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
    );
  }
}
