import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wechat/constant/dimen.dart';

class EasyImage extends StatelessWidget {
  const EasyImage({Key? key,
    required this.image,
    this.isNetwork= true,
    this.width = kWh100x,
    this.height = kWh100x
  }) : super(key: key);

  final String image;
  final double width;
  final double height;
  final bool isNetwork;
  @override
  Widget build(BuildContext context) {
    return
      isNetwork?CachedNetworkImage(
        imageUrl: image,
      fit: BoxFit.cover,
      width: width,
      height: height,
      errorWidget: (context, url, error) => const Icon(Icons.error,color: Colors.red,),
      placeholder: (context, url) => CircularProgressIndicator(),
    ):
          Image.asset(
            image,
          fit: BoxFit.cover,
            width: width,
            height: height,
          )
    ;
  }
}
