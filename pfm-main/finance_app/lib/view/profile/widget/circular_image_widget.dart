import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircularImageWidget extends StatelessWidget {
  final String imageUrl;
  final Function() onTap;
  final bool isEdit;

  const CircularImageWidget({
    super.key,
    required this.imageUrl,
    required this.onTap,
    required this.isEdit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 150,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Card(
              shape: const CircleBorder(
                side: BorderSide(color: Colors.white, width: 5),
              ),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  height: 145,
                  width: 145,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (BuildContext context, String path,
                      DownloadProgress progress) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                        value: progress.progress,
                      ),
                    );
                  },
                  errorWidget: (context, url, child) {
                    return Image.asset(
                      "assets/user_placeholder.jpeg",
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
          ),
          if (isEdit)
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: onTap,
                child: const Card(
                  color: Colors.white,
                  shape: CircleBorder(),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.edit),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
