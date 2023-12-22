import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:desktop_test/constant/assets.dart';
// import 'package:desktop_test/constant/dimen.dart';

class EasyImage extends StatelessWidget {
  const EasyImage(
      {super.key,
      required this.url,
      this.width = 130,
      this.height = 190,
      this.fit = BoxFit.cover,
      this.isNetwork = true});

  final String url;
  final double width;
  final double height;
  final BoxFit fit;
  final bool isNetwork;

  @override
  Widget build(BuildContext context) {
    return isNetwork
        ? CachedNetworkImage(
            imageUrl: url,
            width: width,
            height: height,
            fit: fit,
            placeholder: (context, url) => Image.asset(
                  kLogo,
                ),
            errorWidget: (context, url, error) => Image.asset(kLogo))
        : Image.asset(
            url,
            width: width,
            height: height,
            fit: fit,
          );
  }
}
