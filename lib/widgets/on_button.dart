import 'package:flutter/material.dart';

import 'on_ink.dart';

class OnButton extends StatelessWidget {
  final String? title;
  final Color? color;
  final Color? textColor;

  final GestureTapCallback? onTap;

  const OnButton({
    super.key,
    this.title,
    this.color,
    this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OnInk(
      width: double.infinity,
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Text(title!, style: const TextStyle(fontSize: 15)),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text('OpenGL优化',
                          style: TextStyle(fontSize: 13, color: Colors.green)),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text('EPlus注入',
                          style: TextStyle(fontSize: 13, color: Colors.red)),
                    ),
                  ],
                ),
                const SizedBox(height: 15)
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('点击修改', style: TextStyle(color: textColor)),
            )
          ],
        ),
      ),
    );
  }
}
