import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'routers/app_pages.dart';
import 'routers/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoutes.home,
      getPages: AppPages.pages,
      defaultTransition: Transition.fade,
      debugShowCheckedModeBanner: false,
      // ==================== 这里添加主题设置 ====================
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,

        // 全局背景颜色（最重要）
        scaffoldBackgroundColor: const Color(0xFF0A0E17),

        // ColorScheme 正确写法
        colorScheme: ColorScheme.dark().copyWith(
          surface: const Color(0xFF0A0E17),        // 替换 background
          // surfaceContainer: const Color(0xFF0A0E17), // 可选，更精细控制
          onSurface: Colors.white,
          primary: const Color(0xFF2196F3),        // Logo 蓝色，可根据需要调整
        ),
      ),

      // 建议加上这一行，强制使用深色主题
      themeMode: ThemeMode.dark,
    );
  }
}