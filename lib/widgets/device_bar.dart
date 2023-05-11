import 'package:flutter/material.dart';

class DeviceBar extends StatelessWidget {
  final Widget? icon;
  final Color? color;
  final String? title;
  final String? subTitle;
  final EdgeInsetsGeometry? margin;

  const DeviceBar({
    super.key,
    this.icon,
    this.color,
    this.title,
    this.subTitle,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
          color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          const SizedBox(height: 20),
          ClipOval(
            child: Container(
              padding: const EdgeInsets.all(10),
              color: color,
              child: icon,
            ),
          ),
          const SizedBox(height: 5),
          Text(title!, style: TextStyle(color: color)),
          const SizedBox(height: 5),
          Text(
            subTitle!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(height: 1.2, color: color),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
