import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final Widget child;
  final double height, width;

  const InfoCard({
    required this.width,
    required this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5 ,
          ),
        ],
      ),
      child: child,
    );
  }
  
}
