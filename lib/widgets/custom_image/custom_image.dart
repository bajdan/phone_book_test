import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_book_test/widgets/custom_image/cubit/custom_image_cubit.dart';
import 'package:phone_book_test/widgets/custom_image/cubit/custom_image_state.dart';

class CustomImage extends StatefulWidget {
  final String url;
  final double size;


  const CustomImage({required this.size, required this.url, Key? key}) : super(key: key);

  @override
  State<CustomImage> createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  late CustomImageCubit _cubit;

  @override
  void initState() {
    _cubit = CustomImageCubit()..tryDownLoadImage(widget.url);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: BlocBuilder<CustomImageCubit, CustomImageState>(
        bloc: _cubit,
        builder:(context, state){
          if(state is CustomImageLoadingState){
            return const Center(child: CircularProgressIndicator());
          }
          else if(state is CustomImageLoadedState){
            return Image.file(state.file, fit: BoxFit.cover,errorBuilder: (context,error, stackTrace){
              return Image.asset('assets/images/error_loading_image.png', fit: BoxFit.cover,);
            },);
          }
          else{
            return Image.asset('assets/images/error_loading_image.png', fit: BoxFit.cover,);
          }
        }
      ),
    );
  }
}
