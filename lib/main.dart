import 'package:app_demo/login_page.dart';
import 'package:app_demo/register_page.dart';
import 'package:app_demo/setting_page.dart';
import 'package:flutter/material.dart';

void main() { 
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context)//cho phép xây dựng giao diện người dùng của ứng dụng. Nó trả về một widget, trong trường hợp này là một Placeholder, đại diện cho một phần của giao diện người dùng mà bạn có thể thay thế bằng các widget khác trong tương lai.
   {
    return MaterialApp(
      home: MySetting(), 
    );

  }
}