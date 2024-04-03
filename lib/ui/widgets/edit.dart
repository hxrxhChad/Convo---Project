// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../views/index.dart';

class TestField extends StatelessWidget {
  double? maxWidth;
  final String label;
  final String hintText;
  final void Function(String) onChanged;
  final String initialValue;
  final TextEditingController controller;
  TestField({
    super.key,
    this.maxWidth,
    required this.label,
    required this.hintText,
    required this.onChanged,
    required this.initialValue,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          label,
          style: const TextStyle(color: Colors.black),
        ),
        const VGap(height: 15),
        TextFormField(
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.black),
          onChanged: onChanged,
          cursorHeight: 15,
          textAlignVertical: TextAlignVertical.center,
          autocorrect: false,
          initialValue: initialValue,
          cursorColor: Theme.of(context).disabledColor,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                  color: Theme.of(context).iconTheme.color!.withOpacity(.5)),
              contentPadding: const EdgeInsets.only(
                  left: 20, top: 12, right: 20, bottom: 12),
              constraints: BoxConstraints(
                  maxHeight: 40, maxWidth: maxWidth != null ? maxWidth! : 300),
              fillColor: Theme.of(context).iconTheme.color!.withOpacity(.04),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide:
                      // BorderSide(color: Theme.of(context).iconTheme.color!),
                      BorderSide.none),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
                borderSide: BorderSide(
                    width: 2,
                    color: Theme.of(context).iconTheme.color!.withOpacity(.1)),
              ),
              filled: true),
        ),
      ],
    );
  }
}

class AddImage extends StatelessWidget {
  final String image;
  final void Function() onTap;
  const AddImage({
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
                  height: 95,
                  width: 95,
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
                    height: 95,
                    width: 95,
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
