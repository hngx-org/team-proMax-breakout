import 'package:bluck_buster/components/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppBTN extends StatelessWidget {
  final String title;
  final Color? color;
  final void Function()? onTap;

  const AppBTN({
    super.key,
    required this.title,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      splashColor: kcPrimaryColor.withOpacity(0.4),
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 500,
        ),
        width: double.infinity,
        height: height * 0.06,
        decoration: BoxDecoration(
          color: kcGoldColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'Knewave',
              fontSize: 20,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}

class AppDIALOG extends StatelessWidget {
  final String reason;
  final String? btnTxt;
  final void Function()? onTap;

  const AppDIALOG({
    super.key,
    this.onTap,
    required this.reason,
    this.btnTxt,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Dialog(
      child: Container(
        width: width * 0.05,
        height: height * 0.36,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              soon,
              height: height * 0.14,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              textAlign: TextAlign.center,
              softWrap: true,
              reason,
              style: const TextStyle(
                fontSize: 25,
                height: 1,
                color: kcPrimaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: height * 0.035,
            ),
            AppBTN(
              title: btnTxt!,
              onTap: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
