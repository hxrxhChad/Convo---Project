import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'widgets.dart';

class RegisterAddImage extends StatelessWidget {
  final String image;
  final void Function() onTap;
  const RegisterAddImage({
    super.key,
    required this.onTap,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: image == '' || image.isEmpty
          ? Stack(
              children: [
                Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Icon(
                      Iconsax.image,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    padding: const EdgeInsets.all(3),
                    child: const Icon(
                      Iconsax.add,
                      color: Colors.blue,
                      size: 15,
                    ),
                  ),
                )
              ],
            )
          : Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: 75,
                    width: 75,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: image,
                      placeholder: (context, url) => Load(onTap: () {}),
                      errorWidget: (context, url, error) => const Padding(
                        padding: EdgeInsets.all(15),
                        child: Icon(
                          Iconsax.information,
                          color: Colors.blue,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    padding: const EdgeInsets.all(3),
                    child: const Icon(
                      Iconsax.add,
                      color: Colors.blue,
                      size: 15,
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
