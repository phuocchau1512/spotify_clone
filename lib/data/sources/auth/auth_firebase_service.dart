import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_clone/data/models/auth/create_user_req.dart';
import 'package:spotify_clone/data/models/auth/signin_user_req.dart';

abstract class AuthFirebaseService {

  Future<Either> signIn(SignInUserReq signInUserReq);
  Future<Either> signUp(CreateUserReq createUserReq);
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {

  @override
  Future<Either> signIn(SignInUserReq signInUserReq) async {
    try {

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: signInUserReq.email,
          password: signInUserReq.password
      );

      return const Right('Đăng nhập thành công');
    }
    on FirebaseAuthException catch (e) {
      String message = '';

      if ( e.code == 'invalid-email' ){
        message = 'Email không được tìm thấy';
      } else if ( e.code == 'invalid-credential' ){
        message = 'Email hoặc mật khẩu không đúng';
      }

      return Left(message);
    }
  }



  @override
  Future<Either> signUp(CreateUserReq createUserReq) async {
    try {

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: createUserReq.email,
          password: createUserReq.password
      );

      return const Right('Đăng ký thành công');
    }
    on FirebaseAuthException catch (e) {
      String message = '';

      if ( e.code == 'weak-password' ){
        message = 'Mật khẩu phải lớn hơn 6 ký tự và có ít nhất 1 ký tự chữ và có ít nhất 1 ký tự số';
      } else if ( e.code == 'email-already-in-use' ){
        message = 'Email đã được sử dụng để đăng ký';
      }

      return Left(message);
    }
  }

}