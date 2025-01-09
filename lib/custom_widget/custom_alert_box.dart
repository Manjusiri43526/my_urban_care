import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomWidgets {
  static customAlertBox(BuildContext context, String title,String description) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFFFF7029),
                child: SvgPicture.asset(
                  "assets/image/svg_icon/newsletter-subscribe.svg",color: Colors.white,),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    fontFamily: "Sf Ui Display medium"),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: "Sf Ui Display medium",
                  fontSize: 16,
                  color: Color(0xFF7D848D),

                ),)
            ],
          ),
        );
      },
    );
  }
}
