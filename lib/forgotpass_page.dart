
import 'dart:math';
import 'package:flutter/material.dart';
import 'login_page.dart';

class MyForgotPassword extends StatefulWidget {
  const MyForgotPassword({super.key});

  @override
  State<MyForgotPassword> createState() =>
      _MyForgotPasswordState();
}

class _MyForgotPasswordState extends State<MyForgotPassword> {
  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController otpController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  final TextEditingController confirmController =
      TextEditingController();

  String maOTP = '';
  bool daGuiMa = false;

  bool hienMatKhau = false;
  bool hienXacNhan = false;

  // Hiển thị thông báo
  void hienThongBao(String noiDung, Color mau) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(noiDung),
        backgroundColor: mau,
      ),
    );
  }

  // Gửi mã OTP
  void guiMaOTP() {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      hienThongBao('Vui lòng nhập email!', Colors.red);
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      hienThongBao('Email không hợp lệ!', Colors.red);
      return;
    }

    // Tạo mã OTP 6 chữ số
    maOTP = (Random().nextInt(900000) + 100000).toString();

    setState(() {
      daGuiMa = true;
    });

    // Mô phỏng gửi mã OTP
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Mã xác nhận OTP'),
          content: Text(
            'Mã OTP demo của bạn là: $maOTP',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  // Gửi lại mã OTP
  void guiLaiMaOTP() {
    maOTP = (Random().nextInt(900000) + 100000).toString();
    otpController.clear();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Mã OTP mới'),
          content: Text('Mã OTP demo: $maOTP'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  // Đặt lại mật khẩu
  void datLaiMatKhau() {
    String email = emailController.text.trim();
    String otp = otpController.text.trim();
    String matKhau = passwordController.text;
    String xacNhan = confirmController.text;

    // Kiểm tra email
    if (email.isEmpty ||
        !email.contains('@') ||
        !email.contains('.')) {
      hienThongBao('Vui lòng nhập email hợp lệ!', Colors.red);
      return;
    }

    // Kiểm tra đã gửi OTP
    if (!daGuiMa) {
      hienThongBao('Vui lòng nhấn Gửi mã OTP!', Colors.red);
      return;
    }

    // Kiểm tra mã OTP
    if (otp.isEmpty) {
      hienThongBao('Vui lòng nhập mã OTP!', Colors.red);
      return;
    }

    if (otp != maOTP) {
      hienThongBao('Mã OTP không chính xác!', Colors.red);
      return;
    }

    // Kiểm tra mật khẩu
    if (matKhau.isEmpty || xacNhan.isEmpty) {
      hienThongBao('Vui lòng nhập đầy đủ mật khẩu!', Colors.red);
      return;
    }

    if (matKhau.length < 6) {
      hienThongBao(
        'Mật khẩu phải có ít nhất 6 ký tự!',
        Colors.red,
      );
      return;
    }

    if (matKhau != xacNhan) {
      hienThongBao(
        'Mật khẩu xác nhận không khớp!',
        Colors.red,
      );
      return;
    }

    // Thành công
    hienThongBao(
      'Đặt lại mật khẩu thành công!',
      Colors.green,
    );

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MyLogin(),
        ),
        (route) => false,
      );
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    otpController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text(
          'Quên mật khẩu',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(25),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                // Logo
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.apps,
                    size: 45,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  'MyAPP',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Colors.blue,
                    letterSpacing: 2,
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  'QUÊN MẬT KHẨU?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Nhập email, mã OTP và mật khẩu mới '
                  'để khôi phục tài khoản.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 25),

                // Email
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Nhập email của bạn',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // OTP và nút gửi mã
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        decoration: InputDecoration(
                          counterText: '',
                          labelText: 'Mã OTP',
                          prefixIcon: const Icon(Icons.password),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    SizedBox(
                      height: 55,
                      child: ElevatedButton(
                        onPressed: guiMaOTP,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          daGuiMa ? 'Gửi lại' : 'Gửi mã',
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // Mật khẩu mới
                TextField(
                  controller: passwordController,
                  obscureText: !hienMatKhau,
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu mới',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        hienMatKhau
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          hienMatKhau = !hienMatKhau;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Xác nhận mật khẩu
                TextField(
                  controller: confirmController,
                  obscureText: !hienXacNhan,
                  decoration: InputDecoration(
                    labelText: 'Xác nhận mật khẩu mới',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        hienXacNhan
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          hienXacNhan = !hienXacNhan;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Nút đặt lại mật khẩu
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: datLaiMatKhau,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'ĐẶT LẠI MẬT KHẨU',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Quay lại đăng nhập
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Đã nhớ mật khẩu?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyLogin(),
                          ),
                        );
                      },
                      child: const Text(
                        'Đăng nhập',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
