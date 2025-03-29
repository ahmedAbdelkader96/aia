import 'package:aia/global/methods_helpers_functions/media_query.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerMessage extends StatelessWidget {
  const ShimmerMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: MQuery.getWidth(context, 250),
          height: 40,
          color: Colors.white, // The line color
        ),
      ),
    );
  }
}
