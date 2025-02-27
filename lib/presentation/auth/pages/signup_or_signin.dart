import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_clone/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone/common/widgets/appbar/app_bar.dart';
import 'package:spotify_clone/common/widgets/button/basic_app_button.dart';
import 'package:spotify_clone/core/configs/assets/app_images.dart';
import 'package:spotify_clone/core/configs/assets/app_vectors.dart';
import 'package:spotify_clone/presentation/auth/pages/signin.dart';
import 'package:spotify_clone/presentation/auth/pages/signup.dart';

class SignUpOrSignInPage extends StatelessWidget {
  const SignUpOrSignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Stack(
            children: [
              const BasicAppbar(),
              Align(
                alignment: Alignment.bottomLeft,
                child: SvgPicture.asset(
                    AppImages.authBg
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppVectors.logo
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Tận hưởng âm nhạc',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: BasicAppButton(
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>  const SignupPage()
                                  )
                                );
                              },
                              title: 'Đăng ký',
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 1,
                            child: TextButton(
                                onPressed: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>  SignInPage()
                                      )
                                  );
                                },
                                child: Text(
                                  'Đăng nhập',
                                  style:  TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: context.isDarkMode ? Colors.white : Colors.black
                                  ),
                                )
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
    );
  }
}
