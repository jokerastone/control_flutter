import 'package:flutter/material.dart';
import '../routers/app_routes.dart';
import 'package:get/get.dart';


class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 主内容（居中）
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Container(
                  width: 92,
                  height: 92,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2196F3),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2196F3).withValues(alpha: 0.6),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.cloud_outlined,
                    size: 48,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 32),

                // 主标题
                const Text(
                  '云控系统',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),

                const SizedBox(height: 8),

                // 副标题
                const Text(
                  'Cloud Control System · Client Edition',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    letterSpacing: 1.5,
                  ),
                ),

                const SizedBox(height: 80),

                // 五个菜单按钮
                // Wrap(
                //   spacing: 12,
                //   runSpacing: 12,
                //   alignment: WrapAlignment.center,
                //   children: [
                //     _buildMenuButton('设备管理',AppRoutes.detail),
                //     _buildMenuButton('远程控制',AppRoutes.home),
                //     _buildMenuButton('任务调度',AppRoutes.home),
                //     _buildMenuButton('日志监控',AppRoutes.home),
                //     _buildMenuButton('系统设置',AppRoutes.home),
                //   ],
                // ),
              ],
            ),
          ),

          // 右下角版本信息（使用 Positioned）
          const Positioned(
            right: 20,
            bottom: 20,
            child: Text(
              'v1.0.0',
              style: TextStyle(
                color: Colors.white38,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 菜单按钮
  Widget _buildMenuButton(String text, String route) {
    return GestureDetector(
      onTap: (){
        Get.offNamed(route);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white24, width: 1.5),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
        ),
      )
    );
  }
}