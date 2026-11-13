
import 'package:flutter/material.dart';
import 'product.dart';

class GioHang extends StatefulWidget {
  final Map<int, int> gioHang;
  final List<Product> danhSachSanPham;
  final ValueChanged<Map<int, int>> onCartChanged;

  const GioHang({
    super.key,
    required this.gioHang,
    required this.danhSachSanPham,
    required this.onCartChanged,
  });

  @override
  State<GioHang> createState() => _GioHangState();
}

class _GioHangState extends State<GioHang> {
  late Map<int, int> gioHang;

  static const double phiVanChuyen = 50000;

  @override
  void initState() {
    super.initState();
    gioHang = Map<int, int>.from(widget.gioHang);
  }

  Product? timSanPham(int id) {
    for (final sp in widget.danhSachSanPham) {
      if (sp.id == id) return sp;
    }
    return null;
  }

  String dinhDangGia(double gia) {
    return '${gia.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    )}đ';
  }

  double get tamTinh {
    double tong = 0;

    gioHang.forEach((id, soLuong) {
      final sp = timSanPham(id);
      if (sp != null) {
        tong += sp.price * soLuong;
      }
    });

    return tong;
  }

  double get tongThanhToan {
    return gioHang.isEmpty ? 0 : tamTinh + phiVanChuyen;
  }

  int get tongSoLuong {
    return gioHang.values.fold(0, (a, b) => a + b);
  }

  void capNhatGioHang() {
    widget.onCartChanged(Map<int, int>.from(gioHang));
  }

  void thayDoiSoLuong(int id, int soLuong) {
    setState(() {
      if (soLuong <= 0) {
        gioHang.remove(id);
      } else {
        gioHang[id] = soLuong;
      }
    });

    capNhatGioHang();
  }

  void xoaSanPham(int id) {
    final soLuongCu = gioHang[id];

    setState(() {
      gioHang.remove(id);
    });

    capNhatGioHang();

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Đã xóa sản phẩm khỏi giỏ hàng'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Hoàn tác',
          onPressed: () {
            if (soLuongCu != null) {
              setState(() {
                gioHang[id] = soLuongCu;
              });
              capNhatGioHang();
            }
          },
        ),
      ),
    );
  }

  Widget nutSoLuong({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 30,
        height: 28,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 17),
      ),
    );
  }

  Widget hienThiSanPham(Product sanPham, int soLuong) {
    return Dismissible(
      key: ValueKey(sanPham.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 28,
        ),
      ),
      onDismissed: (_) => xoaSanPham(sanPham.id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            // Hình minh họa sản phẩm
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: const Color(0xFFE8EDF5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sanPham.icon,
                size: 34,
                color: const Color(0xFF174A8B),
              ),
            ),

            const SizedBox(width: 12),

            // Tên, giá và số lượng
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sanPham.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    dinhDangGia(sanPham.price),
                    style: const TextStyle(
                      color: Color(0xFF174A8B),
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      nutSoLuong(
                        icon: Icons.remove,
                        onPressed: () {
                          thayDoiSoLuong(
                            sanPham.id,
                            soLuong - 1,
                          );
                        },
                      ),

                      SizedBox(
                        width: 35,
                        child: Text(
                          '$soLuong',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      nutSoLuong(
                        icon: Icons.add,
                        onPressed: () {
                          thayDoiSoLuong(
                            sanPham.id,
                            soLuong + 1,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: () => xoaSanPham(sanPham.id),
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget thongTinThanhToan() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tạm tính'),
                Text(dinhDangGia(tamTinh)),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Phí vận chuyển'),
                Text(dinhDangGia(phiVanChuyen)),
              ],
            ),

            const Divider(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tổng cộng',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  dinhDangGia(tongThanhToan),
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: gioHang.isEmpty
                    ? null
                    : () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Chức năng thanh toán sẽ được bổ sung sau!',
                            ),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2864E8),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
                child: const Text(
                  'Thanh toán',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final danhSachTrongGio = gioHang.entries
        .where((e) => timSanPham(e.key) != null)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFF174A8B),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text('Giỏ hàng ($tongSoLuong)'),
        centerTitle: false,
      ),

      body: gioHang.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.shopping_cart_outlined,
                    size: 85,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Giỏ hàng đang trống',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Hãy chọn sản phẩm bạn muốn mua nhé!',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2864E8),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Tiếp tục mua sắm'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: danhSachTrongGio.length,
                    itemBuilder: (context, index) {
                      final entry = danhSachTrongGio[index];
                      final sanPham = timSanPham(entry.key)!;

                      return hienThiSanPham(
                        sanPham,
                        entry.value,
                      );
                    },
                  ),
                ),

                thongTinThanhToan(),
              ],
            ),
    );
  }
}
