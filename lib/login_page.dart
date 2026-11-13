
import 'package:app_demo/forgotpass_page.dart';
import 'package:app_demo/list_page.dart';
import 'package:app_demo/setting_page.dart';
import 'package:flutter/material.dart';
import 'register_page.dart';
class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void dangNhap() {
  String email = emailController.text.trim();
  String matKhau = passwordController.text.trim();

  // Kiểm tra dữ liệu trống
  if (email.isEmpty || matKhau.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Vui lòng nhập đầy đủ Email và mật khẩu!'),
        backgroundColor: Colors.orange,
      ),
    );
    return;
  }

  // Kiểm tra tài khoản
  if (email == 'admin' && matKhau == '123') {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đăng nhập thành công!'),
        backgroundColor: Colors.green,
      ),
    );
     Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const ProductList(),
    ),
  ); 
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Email hoặc mật khẩu không đúng!'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(25),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 38,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.apps,
                      size: 45,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  const Text(
                    'MyAPP',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Colors.blue,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Nhập email của bạn',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Nhập Mật khẩu',
                  
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyForgotPassword(),
                        ),
                      );
                    },
                    child: const Text('Quên mật khẩu?'),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyRegister(),
                        ),
                      );
                    },
                    child: const Text('Đăng ký'),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: dangNhap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Đăng nhập',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
