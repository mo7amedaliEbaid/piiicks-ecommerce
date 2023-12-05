import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../configs/configs.dart';
import '../../core/constant/assets.dart';

Future<void> showPhotoViewDialog(String imageUrl, BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(bottom: AppDimensions.normalize(40)),
        child: Dialog(
          insetPadding: Space.hf(1.3),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                height: AppDimensions.normalize(170),
                width: double.maxFinite,
                child: PhotoViewGallery(
                  pageController: PageController(),
                  scrollPhysics: const BouncingScrollPhysics(),
                  backgroundDecoration: BoxDecoration(
                    color: Colors.grey.shade400,
                  ),
                  pageOptions: [
                    PhotoViewGalleryPageOptions(
                      imageProvider: NetworkImage(imageUrl),
                      minScale: PhotoViewComputedScale.covered,
                      maxScale: PhotoViewComputedScale.covered * 2,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -AppDimensions.normalize(18),
                right: -AppDimensions.normalize(4),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset(
                    AppAssets.Close,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
