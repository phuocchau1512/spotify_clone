import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_clone/common/widgets/button/basic_app_button.dart';
import 'package:spotify_clone/core/configs/assets/app_images.dart';
import 'package:spotify_clone/core/configs/assets/app_vectors.dart';
import 'package:spotify_clone/core/configs/theme/app_colors.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 40),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  AppImages.introBg
                )
              )
            ),
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(
                  AppVectors.logo
                ),
              ),
              const Spacer(),
              const Text(
                'Tận hưởng âm nhạc',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18
                ),
              ),
              const SizedBox(height: 21),
              const Text(
                'Tận hưởng âm nhạc',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey,
                    fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              BasicAppButton(
                  onPressed: (){},
                  title: 'Bắt đầu')
            ],
          ),
          Container(
            color: Colors.black.withOpacity(0.15),
          )
        ],
      ),
    );
  }
}
