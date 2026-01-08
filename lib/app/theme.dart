import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // static final ThemeData lightTheme = ThemeData.light().copyWith(
  //   // AppBar 全局样式更改
  //   appBarTheme: const AppBarTheme(
  //     elevation: 0.5,
  //     centerTitle: true,
  //     scrolledUnderElevation: 1,
  //     foregroundColor: Colors.black,
  //     shadowColor: Colors.grey,
  //     backgroundColor: Color(0xFFF0F0F0),
  //   ),
  //   // BottomNavigationBar 全局样式更改
  //   bottomNavigationBarTheme: const BottomNavigationBarThemeData(
  //     elevation: 10,
  //     selectedItemColor: Colors.blueAccent,
  //     unselectedItemColor: Colors.grey,
  //     backgroundColor: Color(0xFFF0F0F0),
  //     type: BottomNavigationBarType.fixed,
  //     selectedIconTheme: IconThemeData(size: 28),
  //     unselectedIconTheme: IconThemeData(size: 28),
  //     selectedLabelStyle: TextStyle(fontSize: 18),
  //     unselectedLabelStyle: TextStyle(fontSize: 18),
  //     enableFeedback: true,
  //   ),
  // );
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF006a6a), // 对应你的 --md-sys-color-primary
      surface: const Color(0xFFf6fbfa),
    ),
    // TODO 后续引入字体
    // fontFamily: 'Google Sans', // 确保在 pubspec.yaml 中导入了字体
  );
}
