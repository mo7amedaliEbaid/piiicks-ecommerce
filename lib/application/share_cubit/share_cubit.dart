// share_cubit.dart

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

part 'share_state.dart';

class ShareCubit extends Cubit<ShareState> {
  final ScreenshotController screenshotController = ScreenshotController();

  ShareCubit() : super(ShareInitialState());

  Future saveAndShare(Uint8List bytes) async {

    // Save the screenshot to a temporary file

    final directry = await getApplicationDocumentsDirectory();

    final image = File('${directry.path}/flutter.png');

    image.writeAsBytesSync(bytes);

    await Share.shareFiles([image.path]);
  }

  void shareScreenshot() async {
    try {
      emit(ShareLoadingState());

      // Uint8List? imageBytes = await screenshotController.capture();
      final image = await screenshotController.capture();

      if (image != null) {

        saveAndShare(image);

        emit(ShareSuccessState());
      } else {
        emit(ShareErrorState('Failed to capture screenshot.'));
      }
    } catch (e) {
      emit(ShareErrorState('Error sharing screenshot: $e'));
    }
  }
}
