import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone/core/configs/theme/app_colors.dart';
import 'package:spotify_clone/presentation/choose_mode/bloc/theme_cubit.dart';

import '../../../common/widgets/button/basic_app_button.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/assets/app_vectors.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 40),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                          AppImages.chooseModeBg
                      )
                  )
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.15),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 20
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(
                        AppVectors.logo
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'Chọn chế độ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children:[
                          ClipOval(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX:10,sigmaY:10),
                            child: Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                color: const Color(0xff30393C).withOpacity(0.5),
                                shape:  BoxShape.circle
                              ),
                              child: SvgPicture.asset(
                                AppVectors.moon,
                                fit: BoxFit.none,
                              ),
                            ),
                          ),
                        ),
                          const SizedBox(height: 10),
                          const Text(
                            'Dark Mode',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: AppColors.grey
                            ),
                          )
                        ]
                      ),
                      const SizedBox(width: 40),
                      Column(
                        children:[ GestureDetector(
                          onTap: (){
                            context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
                          },
                          child: ClipOval(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX:10,sigmaY:10),
                              child: Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: const Color(0xff30393C).withOpacity(0.5),
                                    shape:  BoxShape.circle
                                ),
                                child: SvgPicture.asset(
                                  AppVectors.sun,
                                  fit: BoxFit.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                          const SizedBox(height: 10),
                          const Text(
                            'Dark Mode',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: AppColors.grey
                            ),
                          )
                        ]
                      ),
                      Column(
                          children:[ GestureDetector(
                            onTap: (){
                              context.read<ThemeCubit>().updateTheme(ThemeMode.light);
                            },
                            child: ClipOval(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX:10,sigmaY:10),
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        color: const Color(0xff30393C).withOpacity(0.5),
                                        shape:  BoxShape.circle
                                    ),
                                    child: SvgPicture.asset(
                                      AppVectors.sun,
                                      fit: BoxFit.none,
                                    ),
                                  ),
                                ),
                              ),
                          ),
                            const SizedBox(height: 10),
                            const Text(
                              'Light Mode',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  color: AppColors.grey
                              ),
                            )
                          ]
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  BasicAppButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ( BuildContext content ) => const ChooseModePage()
                            )
                        );
                      },
                      title: 'Tiếp tục')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
