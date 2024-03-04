import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 18,
      backgroundColor: Colors.white,
      backgroundImage: CachedNetworkImageProvider(
        'https://source.unsplash.com/200x200/?profile',
      ),
    );
  }
}
