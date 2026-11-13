
import 'package:flutter/material.dart';
import 'login_page.dart';

class MySetting extends StatefulWidget {
  const MySetting({super.key});

  @override
  State<MySetting> createState() => _MySettingState();
}

class _MySettingState extends State<MySetting> {
  bool nhanThongBao = true;
  bool cheDoToi = false;
  bool nhoDangNhap = true;

  String ngonNgu = 'Tiếng Việt';
  String coChu = 'Vừa';

  // Màu giao diện
  Color get mauNen =>
      cheDoToi ? const Color(0xFF202124) : Colors.white;

  Color get mauThe =>
      cheDoToi ? const Color(0xFF303134) : Colors.white;

  Color get mauChu =>
      cheDoToi ? Colors.white : Colors.black87;

  Color get mauPhu =>
      cheDoToi ? Colors.white70 : Colors.grey;

  // Hiển thị BottomSheet chọn ngôn ngữ
  void chonNgonNgu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: mauThe,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 15),
            Text(
              'Chọn ngôn ngữ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: mauChu,
              ),
            ),
            const SizedBox(height: 10),

            ListTile(
              title: Text(
                'Tiếng Việt',
                style: TextStyle(color: mauChu),
              ),
              trailing: ngonNgu == 'Tiếng Việt'
                  ? const Icon(Icons.check, color: Colors.blue)
                  : null,
              onTap: () {
                setState(() {
                  ngonNgu = 'Tiếng Việt';
                });
                Navigator.pop(context);
              },
            ),

            ListTile(
              title: Text(
                'English',
                style: TextStyle(color: mauChu),
              ),
              trailing: ngonNgu == 'English'
                  ? const Icon(Icons.check, color: Colors.blue)
                  : null,
              onTap: () {
                setState(() {
                  ngonNgu = 'English';
                });
                Navigator.pop(context);
              },
            ),

            const SizedBox(height: 15),
          ],
        );
      },
    );
  }

  // Hiển thị BottomSheet chọn cỡ chữ
  void chonCoChu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: mauThe,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 15),
            Text(
              'Chọn cỡ chữ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: mauChu,
              ),
            ),

            ListTile(
              title: Text('Nhỏ', style: TextStyle(color: mauChu)),
              trailing: coChu == 'Nhỏ'
                  ? const Icon(Icons.check, color: Colors.blue)
                  : null,
              onTap: () {
                setState(() {
                  coChu = 'Nhỏ';
                });
                Navigator.pop(context);
              },
            ),

            ListTile(
              title: Text('Vừa', style: TextStyle(color: mauChu)),
              trailing: coChu == 'Vừa'
                  ? const Icon(Icons.check, color: Colors.blue)
                  : null,
              onTap: () {
                setState(() {
                  coChu = 'Vừa';
                });
                Navigator.pop(context);
              },
            ),

            ListTile(
              title: Text('Lớn', style: TextStyle(color: mauChu)),
              trailing: coChu == 'Lớn'
                  ? const Icon(Icons.check, color: Colors.blue)
                  : null,
              onTap: () {
                setState(() {
                  coChu = 'Lớn';
                });
                Navigator.pop(context);
              },
            ),

            const SizedBox(height: 15),
          ],
        );
      },
    );
  }

  // Hiển thị thông tin ứng dụng
  void veUngDung() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: mauThe,
          title: Text(
            'Về ứng dụng',
            style: TextStyle(color: mauChu),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 35,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.apps,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'MyAPP',
                style: TextStyle(
                  color: mauChu,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Ứng dụng MyAPP phiên bản 1.0.0',
                textAlign: TextAlign.center,
                style: TextStyle(color: mauPhu),
              ),
            ],
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

  // Xác nhận đăng xuất
  void dangXuat() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: mauThe,
          title: Text(
            'Xác nhận đăng xuất',
            style: TextStyle(color: mauChu),
          ),
          content: Text(
            'Bạn có chắc chắn muốn đăng xuất không?',
            style: TextStyle(color: mauChu),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyLogin(),
                  ),
                  (route) => false,
                );
              },
              child: const Text('Đăng xuất'),
            ),
          ],
        );
      },
    );
  }

  // Tiêu đề nhóm
  Widget tieuDeNhom(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12,
        top: 15,
        bottom: 8,
      ),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: mauPhu,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Trang cài đặt
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mauNen,

      appBar: AppBar(
        title: const Text(
          'Cài đặt',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF263B78),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // NHÓM 1: SWITCH
            tieuDeNhom('Cài đặt chung'),

            Container(
              decoration: BoxDecoration(
                color: mauThe,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [

                  SwitchListTile(
                    secondary: const Icon(
                      Icons.notifications,
                      color: Colors.blue,
                    ),
                    title: Text(
                      'Nhận thông báo',
                      style: TextStyle(color: mauChu),
                    ),
                    value: nhanThongBao,
                    onChanged: (value) {
                      setState(() {
                        nhanThongBao = value;
                      });
                    },
                  ),

                  Divider(
                    height: 1,
                    color: mauPhu.withOpacity(0.2),
                  ),

                  SwitchListTile(
                    secondary: const Icon(
                      Icons.dark_mode,
                      color: Colors.blue,
                    ),
                    title: Text(
                      'Chế độ tối',
                      style: TextStyle(color: mauChu),
                    ),
                    value: cheDoToi,
                    onChanged: (value) {
                      setState(() {
                        cheDoToi = value;
                      });
                    },
                  ),

                  Divider(
                    height: 1,
                    color: mauPhu.withOpacity(0.2),
                  ),

                  SwitchListTile(
                    secondary: const Icon(
                      Icons.login,
                      color: Colors.blue,
                    ),
                    title: Text(
                      'Nhớ đăng nhập',
                      style: TextStyle(color: mauChu),
                    ),
                    value: nhoDangNhap,
                    onChanged: (value) {
                      setState(() {
                        nhoDangNhap = value;
                      });
                    },
                  ),
                ],
              ),
            ),

            // NHÓM 2: LISTTILE
            tieuDeNhom('Thiết đặt'),

            Container(
              decoration: BoxDecoration(
                color: mauThe,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [

                  ListTile(
                    leading: const Icon(
                      Icons.language,
                      color: Colors.blue,
                    ),
                    title: Text(
                      'Ngôn ngữ',
                      style: TextStyle(color: mauChu),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: mauPhu,
                    ),
                    onTap: chonNgonNgu,
                  ),

                  Divider(
                    height: 1,
                    color: mauPhu.withOpacity(0.2),
                  ),

                  ListTile(
                    leading: const Icon(
                      Icons.text_fields,
                      color: Colors.blue,
                    ),
                    title: Text(
                      'Cỡ chữ',
                      style: TextStyle(color: mauChu),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: mauPhu,
                    ),
                    onTap: chonCoChu,
                  ),

                  Divider(
                    height: 1,
                    color: mauPhu.withOpacity(0.2),
                  ),

                  ListTile(
                    leading: const Icon(
                      Icons.info_outline,
                      color: Colors.blue,
                    ),
                    title: Text(
                      'Về ứng dụng',
                      style: TextStyle(color: mauChu),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: mauPhu,
                    ),
                    onTap: veUngDung,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // NÚT ĐĂNG XUẤT
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                onPressed: dangXuat,
                style: OutlinedButton.styleFrom(
                  foregroundColor: mauChu,
                  side: const BorderSide(
                    color: Colors.blue,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Đăng xuất',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
