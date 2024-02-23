import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music/bloc/boarding_bloc/boarding_bloc.dart';
import 'package:music/bloc/boarding_bloc/boarding_event.dart';
import 'package:music/view/onBoarding/components/first_page.dart';
import 'package:music/view/onBoarding/components/second_page.dart';
import 'package:music/view/onBoarding/components/third_page.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30, right: 20),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
            child: InkWell(
              onTap: () {
                if(context.read<BoardingBLoc>().state.index<3){
                  context.read<BoardingBLoc>().add(OnPageChangeEvent(
                      index: context.read<BoardingBLoc>().state.index + 1));
                }else{
                  context.read<BoardingBLoc>().add(LetsGoTapEvent(context: context));
                }
              },
              child: Container(
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Let\'s go',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: PageView(
              controller: context.read<BoardingBLoc>().pageController,
              onPageChanged: (value) => context
                  .read<BoardingBLoc>()
                  .add(OnPageChangeEvent(index: value)),
              children: const [
                FirstPage(),
                SecondPage(),
                ThirdPage(),
              ],
            ),
          ),
          Positioned(
              right: 40,
              top: 50,
              child: InkWell(
                onTap: () => context
                    .read<BoardingBLoc>()
                    .add(OnSkipTapEvent(context: context)),
                child: Text(
                  'Skip',
                ),
              ))
        ],
      )),
    );
  }
}
