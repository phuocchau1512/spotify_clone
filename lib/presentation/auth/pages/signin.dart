import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_clone/common/widgets/appbar/app_bar.dart';
import 'package:spotify_clone/common/widgets/button/basic_app_button.dart';
import 'package:spotify_clone/core/configs/assets/app_vectors.dart';
import 'package:spotify_clone/data/models/auth/signin_user_req.dart';
import 'package:spotify_clone/domain/usecases/auth/signin.dart';
import 'package:spotify_clone/presentation/auth/pages/signup.dart';

import '../../../service_locator.dart';
import '../../root/root.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailCtl = TextEditingController();
  final TextEditingController _passCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _registerText(context),
      resizeToAvoidBottomInset: false,
      appBar: BasicAppbar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 50,
          width: 50,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 30
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _signInText(),
              const SizedBox(height: 30),
              _emailField(),
              const SizedBox(height: 20),
              _passField(),
              const SizedBox(height: 30),
              BasicAppButton(
                  onPressed: () async
                  {
                    if (_formKey.currentState!.validate()) {
                      // Xử lý đăng ký khi dữ liệu hợp lệ
                      var result = await sl<SignInUseCase>().call(
                          params: SignInUserReq(
                              _emailCtl.text.toString(),
                              _passCtl.text.toString())
                      );
                      result.fold(
                              (l){
                            var snackBar = SnackBar(content: Text(l));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          },
                              (r){
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (BuildContext context) =>  const RootPage())
                                ,(route) => false
                            );
                          }
                      );
                    }
                  },
                  title: 'Đăng Nhập'
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInText(){
    return const Text(
      'Đăng nhập',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _emailField() {
    return TextFormField(
      controller: _emailCtl,
      decoration: InputDecoration(
        hintText: 'Nhập địa chỉ Email',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Vui lòng nhập Email';
        }
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Email không hợp lệ';
        }
        return null;
      },
    );
  }

  bool _obscurePassword = true;

  Widget _passField() {
    return TextFormField(
      controller: _passCtl,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        hintText: 'Nhập mật khẩu',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon: IconButton(
          icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Vui lòng nhập mật khẩu';
        }
        return null;
      },
    );
  }

  Widget _registerText(BuildContext context){
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Bạn chưa có tài khoản ?',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14
                ),
              ),
              TextButton(
                  onPressed: (){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>  const SignupPage()
                        )
                    );
                  },
                  child: const Text('Đăng ký')
              )
            ]
        )
    );
  }
}
