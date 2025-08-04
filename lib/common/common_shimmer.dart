import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerRoundedLine(
    double w,
    double h,
    ) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
    ),
  );
}

Widget shimmerCircle( double radius){
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey[300]!,
    ),
  );
}

Widget mentorCardShimmer(double h, double w) {
  return Container(
    constraints: BoxConstraints(minHeight: h * 0.25),
    width: w,
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: ClipOval(
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  shimmerContainer(width: w * 0.4, height: 16),
                  const SizedBox(height: 4),
                  shimmerContainer(width: w * 0.3, height: 12),
                ],
              ),
            ),
            shimmerContainer(width: 22, height: 22),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            shimmerContainer(width: 20, height: 20),
            const SizedBox(width: 10),
            shimmerContainer(width: w * 0.3, height: 12),
            const SizedBox(width: 10),
            shimmerContainer(width: 20, height: 20),
            const SizedBox(width: 10),
            shimmerContainer(width: w * 0.2, height: 12),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Divider(thickness: 1, color: Colors.grey.shade300),
        ),
        shimmerContainer(width: w * 0.2, height: 12),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(
            3,
                (index) => shimmerContainer(width: w * 0.2, height: 24, radius: 8),
          ),
        ),
      ],
    ),
  );
}

Widget shimmerContainer({double width = 100, double height = 20, double radius = 4}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    ),
  );
}

Widget shimmerCoinHistory(
    double w,
    double h,
    ) {
  return Column(
    children: [
      ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        title: Row(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 20,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 12,
                width: 100,
                color: Colors.white,
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 14,
              width: double.infinity,
              color: Colors.white,
            ),
          ),
        ),
        trailing: SizedBox(
          width: w * 0.24,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 3),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 16,
                  width: 30,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

