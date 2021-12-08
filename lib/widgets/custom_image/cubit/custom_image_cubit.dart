import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:phone_book_test/widgets/custom_image/cubit/custom_image_state.dart';

class CustomImageCubit extends Cubit<CustomImageState> {
  CustomImageCubit() : super(CustomImageLoadingState());

  void downLoadImage(String url) async {
    emit(CustomImageLoadingState());

    final ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      emit(CustomImageErrorState());
    } else {
      try {
        var file = await DefaultCacheManager()
            .getSingleFile(url)
            .timeout(const Duration(seconds: 5));
        emit(CustomImageLoadedState(file: file));
      } catch (e) {
        emit(CustomImageErrorState());
      }
    }
  }
}
