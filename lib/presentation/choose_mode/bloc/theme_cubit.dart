import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  // Khởi tạo với trạng thái mặc định là hệ thống
  ThemeCubit() : super(ThemeMode.system);

  // Cập nhật theme
  void updateTheme(ThemeMode themeMode) => emit(themeMode);

  // Chuyển đổi từ JSON sang ThemeMode
  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    try {
      // Lấy trạng thái từ JSON, chuyển thành enum ThemeMode
      return ThemeMode.values[json['themeMode'] as int];
    } catch (e) {
      return ThemeMode.system; // Mặc định nếu lỗi
    }
  }

  // Chuyển đổi ThemeMode thành JSON
  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    return {'themeMode': state.index}; // Lưu chỉ số của ThemeMode
  }
}
