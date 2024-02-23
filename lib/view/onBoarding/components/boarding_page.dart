import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music/bloc/boarding_bloc/boarding_bloc.dart';
import 'package:music/bloc/boarding_bloc/boarding_state.dart';

import '../../../res/app_colors.dart';

class BoardingPage extends StatelessWidget {
  const BoardingPage(
      {super.key, required this.text, this.image, required this.title});

  final String text;
  final String title;
  final String? image;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        SizedBox(
          height: size.height / 5,
        ),
        Text(
          title,
          style: TextStyle(
              color: blueShade, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'Let\'s vibe together!Create your own\nplaylist and enjoy music',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(
          height: 30,
        ),
        BlocBuilder<BoardingBLoc, BoardingState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...[0, 1, 2].map((e) => Container(
                      height: state.index == e ? 10 : 8,
                      width: state.index == e ? 10 : 8,
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: state.index == e
                            ? lightBlueShade
                            : Colors.grey.withOpacity(.6),
                        shape: BoxShape.circle,
                      ),
                    ))
              ],
            );
          },
        ),
        SizedBox(
          height: 60,
        ),
        Expanded(
            child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: size.height / 2.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(200),
                    topRight: Radius.circular(200),
                  ),
                  color: Colors.grey.withOpacity(.1)),
            ),
            // Image.asset(AppIcons.splashIcons),
          ],
        )),
      ],
    );
  }
}
