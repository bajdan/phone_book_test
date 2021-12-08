import 'dart:io';

abstract class CustomImageState{}

class CustomImageLoadingState extends CustomImageState{}

class CustomImageLoadedState extends CustomImageState{
  final File file;
  CustomImageLoadedState({required this.file});
}

class CustomImageErrorState extends CustomImageState{}

