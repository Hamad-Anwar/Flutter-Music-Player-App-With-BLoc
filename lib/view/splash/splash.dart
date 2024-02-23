import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music/bloc/album_bloc/album_bloc.dart';
import 'package:music/bloc/album_bloc/album_event.dart';
import 'package:music/res/app_icons.dart';
import 'package:music/view/common_widget/soft_button.dart';

import '../../view_model/services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SplashServices.isFirstTime(context: context);
    // context.read<HomeBloc>().add(GetFilesEvent());
    // context.read<AlbumBloc>().add(GetFolderEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularSoftButton(
          radius: 80,
          icon: Container(
            margin: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage(AppIcons.splashIcons,),
              fit: BoxFit.cover
              )
            ),
          ),
        ),
      ),
    );
  }
}
