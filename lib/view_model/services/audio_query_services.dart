import 'dart:io';
import 'dart:math';

import 'package:just_audio/just_audio.dart';
import 'package:music/model/audio_file_model.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path/path.dart' as path;

import '../../utils/utils.dart';

class AudioFileQueries{
  static List<AudioFile> favourite=[];
  static Future<List<AudioFile>> getFiles(String _path) async {
    List<AudioFile> audioList = [];
    final isPermissionGranted = await Utils.requestPermission();
    if (isPermissionGranted) {
      Directory directory = Directory(_path);
      List<FileSystemEntity> files = directory.listSync();
      List<String> audioExtensions = ['.mp3', '.wav', '.au', '.aac', '.smi', '.flac', '.ogg', '.m4a', '.wma'];
      for (int i = 0; i < files.length; i++) {
        String extension = path.extension(files[i].path).toLowerCase();
        if (audioExtensions.contains(extension)) {
          String name = path.basename(files[i].path);
          String size = File(files[i].path).lengthSync().toString();
          String length = await getFileLength(files[i].path);
          int isFavourite = 0;

          audioList.add(AudioFile(
            id: Random().nextInt(1000000),
            name: name,
            path: files[i].path,
            size: size,
            length: length,
            isFavourite: isFavourite,
          ));
        }
      }
    } else {
      return [];
    }

    return audioList;
  }
  static Future<String> getFileLength(String filePath)async{
     AudioPlayer player=AudioPlayer();
    final _= await player.setFilePath(filePath);
    String prefix=player.duration!.inMinutes.toString();
    String postFix=(player.duration!.inSeconds % 60).toString();
    if(prefix.length<2){
      prefix='0$prefix';
    }
    if(postFix.length<2){
      postFix='0$postFix';
    }
    player.dispose();
    return '$prefix:$postFix';
  }
  static Future<List<Map<String, String>>> getFolders() async {
    List<Map<String, String>> list=[];
    final audioQuery = OnAudioQuery();
    List<String> folders = await audioQuery.queryAllPath();
    for(var folder in folders){
      list.add({
        'path' : folder,
        'name' : path.basename(folder)
      });
    }
    return list;
  }
}