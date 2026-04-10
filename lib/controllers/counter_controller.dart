import 'package:get/get.dart';

class CounterController extends GetxController {
  // 响应式变量
  var count = 0.obs;
  
  // 增加
  void increment() {
    count++;
  }
  
  // 减少
  void decrement() {
    if (count.value > 0) {
      count--;
    }
  }
  
  // 重置
  void reset() {
    count.value = 0;
  }
  
  @override
  void onInit() {
    super.onInit();
    print('CounterController 初始化');
  }
  
  @override
  void onClose() {
    print('CounterController 销毁');
    super.onClose();
  }
}