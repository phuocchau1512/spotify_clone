import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_clone/common/widgets/appbar/app_bar.dart';
import 'package:spotify_clone/common/widgets/button/basic_app_button.dart';
import 'package:spotify_clone/core/configs/assets/app_vectors.dart';
import 'package:spotify_clone/data/models/auth/create_user_req.dart';
import 'package:spotify_clone/domain/usecases/auth/signup.dart';
import 'package:spotify_clone/presentation/auth/pages/signin.dart';
import 'package:spotify_clone/presentation/root/root.dart';

import '../../../service_locator.dart';

class SignupPage extends StatefulWidget {
   const SignupPage({super.key});

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameCtl = TextEditingController();
  final TextEditingController _emailCtl = TextEditingController();
  final TextEditingController _passwordCtl = TextEditingController();
  final TextEditingController _secondPasswordCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signInText(context),
      resizeToAvoidBottomInset: true, // Tránh bị tràn màn hình khi nhập
      appBar: BasicAppbar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 50,
          width: 50,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Form(
          key: _formKey, // Form key để validate dữ liệu
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _registerText(),
              const SizedBox(height: 15),
              _fullNameField(),
              const SizedBox(height: 20),
              _emailField(),
              const SizedBox(height: 20),
              _passField(),
              const SizedBox(height: 20),
              _secondPassField(),
              const SizedBox(height: 20),
              BasicAppButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Xử lý đăng ký khi dữ liệu hợp lệ
                    var result = await sl<SignupUseCase>().call(
                      params: CreateUserReq(
                          _fullNameCtl.text.toString(),
                          _emailCtl.text.toString(),
                          _passwordCtl.text.toString())
                    );
                    result.fold(
                            (l){
                              var snackBar = SnackBar(content: Text(l));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            },
                            (r){
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (BuildContext context) => const RootPage())
                                  ,(route) => false
                              );
                            }
                    );
                  }
                },
                title: 'Tạo tài khoản',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Đăng ký',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      textAlign: TextAlign.center,
    );
  }

  Widget _fullNameField() {
    return TextFormField(
      controller: _fullNameCtl,
      decoration: InputDecoration(
        hintText: 'Nhập Họ và Tên',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Vui lòng nhập họ và tên';
        }
        return null;
      },
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
  bool _obscureConfirmPassword = true;

  Widget _passField() {
    return TextFormField(
      controller: _passwordCtl,
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
        if (value.length < 6 || !RegExp(r'[a-zA-Z]').hasMatch(value) || !RegExp(r'\d').hasMatch(value)) {
          return 'Mật khẩu phải có ít nhất 6 ký tự,\nbao gồm ít nhất 1 chữ cái và 1 số';
        }
        return null;
      },
    );
  }

  Widget _secondPassField() {
    return TextFormField(
      controller: _secondPasswordCtl,
      obscureText: _obscureConfirmPassword,
      decoration: InputDecoration(
        hintText: 'Nhập lại mật khẩu',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon: IconButton(
          icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _obscureConfirmPassword = !_obscureConfirmPassword;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Vui lòng nhập lại mật khẩu';
        }
        if (value != _passwordCtl.text) {
          return 'Mật khẩu không khớp';
        }
        return null;
      },
    );
  }


  Widget _signInText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Bạn đã có tài khoản?',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
              );
            },
            child: const Text('Đăng nhập'),
          ),
        ],
      ),
    );
  }
}
