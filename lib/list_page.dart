
import 'package:flutter/material.dart';
import 'package:app_demo/setting_page.dart';

import 'product.dart';
import 'giohang_page.dart';
import 'chi_tiet_san_pham.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final TextEditingController searchController =
      TextEditingController();

  String danhMucDangChon = 'Tất cả';
  String tuKhoa = '';

  // Lưu giỏ hàng: ID sản phẩm và số lượng
  Map<int, int> gioHang = {};

  int viTriHienTai = 0;

  // Tổng số lượng sản phẩm trong giỏ
  int get soLuongGioHang {
    return gioHang.values.fold(
      0,
      (tong, soLuong) => tong + soLuong,
    );
  }

  // Danh sách danh mục
  final List<String> danhSachDanhMuc = [
    'Tất cả',
    'Điện thoại',
    'Laptop',
    'Phụ kiện',
  ];

  // Danh sách sản phẩm
  final List<Product> danhSachSanPham = [
    Product(
      id: 1,
      name: 'iPhone 15 Pro Max',
      category: 'Điện thoại',
      price: 21990000,
      icon: Icons.phone_iphone,
    ),
    Product(
      id: 2,
      name: 'Samsung Galaxy S24',
      category: 'Điện thoại',
      price: 18990000,
      icon: Icons.phone_android,
    ),
    Product(
      id: 3,
      name: 'MacBook Air M2',
      category: 'Laptop',
      price: 21990000,
      icon: Icons.laptop_mac,
    ),
    Product(
      id: 4,
      name: 'Dell Inspiron 15',
      category: 'Laptop',
      price: 15990000,
      icon: Icons.laptop,
    ),
    Product(
      id: 5,
      name: 'Tai nghe Bluetooth',
      category: 'Phụ kiện',
      price: 590000,
      icon: Icons.headphones,
    ),
    Product(
      id: 6,
      name: 'Chuột không dây',
      category: 'Phụ kiện',
      price: 350000,
      icon: Icons.mouse,
    ),
    Product(
      id: 7,
      name: 'iPhone 14',
      category: 'Điện thoại',
      price: 14990000,
      icon: Icons.phone_iphone,
    ),
    Product(
      id: 8,
      name: 'Laptop Asus Vivobook',
      category: 'Laptop',
      price: 16990000,
      icon: Icons.laptop,
    ),
  ];

  // Lọc sản phẩm theo tên và danh mục
  List<Product> get sanPhamDaLoc {
    return danhSachSanPham.where((sp) {
      final dungDanhMuc =
          danhMucDangChon == 'Tất cả' ||
          sp.category == danhMucDangChon;

      final dungTuKhoa = sp.name
          .toLowerCase()
          .contains(tuKhoa.toLowerCase());

      return dungDanhMuc && dungTuKhoa;
    }).toList();
  }

  // Định dạng giá tiền
  String dinhDangGia(double gia) {
    return '${gia.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    )}đ';
  }

  // Thêm sản phẩm vào giỏ hàng
  void themVaoGio(Product sanPham) {
    setState(() {
      gioHang[sanPham.id] =
          (gioHang[sanPham.id] ?? 0) + 1;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Đã thêm ${sanPham.name} vào giỏ hàng!',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // Mở trang giỏ hàng
  void moGioHang() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GioHang(
          gioHang: gioHang,
          danhSachSanPham: danhSachSanPham,
          onCartChanged: (gioHangMoi) {
            if (!mounted) return;

            setState(() {
              gioHang = gioHangMoi;
            });
          },
        ),
      ),
    );
  }

  // Mở trang chi tiết sản phẩm
  void moChiTiet(Product sanPham) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChiTietSanPham(
          sanPham: sanPham,
          onAddToCart: () {
            themVaoGio(sanPham);
          },
        ),
      ),
    );
  }

  // Xử lý thanh điều hướng
  void chonTrang(int index) {
    if (index == 0) {
      setState(() {
        viTriHienTai = 0;
      });
    } else if (index == 1) {
      moGioHang();
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MySetting(),
        ),
      );
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      // THANH TIÊU ĐỀ
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'ShopEasy',
          style: TextStyle(
            color: Color(0xFF174A8B),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: moGioHang,
            icon: Badge(
              label: Text('$soLuongGioHang'),
              isLabelVisible: soLuongGioHang > 0,
              backgroundColor: Colors.red,
              child: const Icon(
                Icons.shopping_cart_outlined,
                color: Color(0xFF174A8B),
                size: 26,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),

      // NỘI DUNG TRANG
      body: SafeArea(
        child: CustomScrollView(
          keyboardDismissBehavior:
              ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            // Ô TÌM KIẾM
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  15,
                  16,
                  10,
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      tuKhoa = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Tìm sản phẩm...',
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.blue,
                    ),
                    suffixIcon: tuKhoa.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              searchController.clear();

                              setState(() {
                                tuKhoa = '';
                              });
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // DANH MỤC
            SliverToBoxAdapter(
              child: SizedBox(
                height: 55,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  itemCount: danhSachDanhMuc.length,
                  itemBuilder: (context, index) {
                    final danhMuc =
                        danhSachDanhMuc[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 5,
                      ),
                      child: FilterChip(
                        label: Text(danhMuc),
                        selected:
                            danhMucDangChon == danhMuc,
                        selectedColor: Colors.blue,
                        backgroundColor: Colors.white,
                        showCheckmark: false,
                        labelStyle: TextStyle(
                          color: danhMucDangChon == danhMuc
                              ? Colors.white
                              : Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                        onSelected: (selected) {
                          setState(() {
                            danhMucDangChon = danhMuc;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ),

            // TIÊU ĐỀ DANH SÁCH
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  12,
                  16,
                  12,
                ),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Sản phẩm nổi bật',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${sanPhamDaLoc.length} sản phẩm',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // DANH SÁCH SẢN PHẨM
            if (sanPhamDaLoc.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 65,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Không tìm thấy sản phẩm!',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  12,
                  0,
                  12,
                  16,
                ),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final sanPham =
                          sanPhamDaLoc[index];

                      return ProductCard(
                        sanPham: sanPham,
                        dinhDangGia: dinhDangGia,
                        onAdd: () => themVaoGio(sanPham),
                        onTap: () => moChiTiet(sanPham),
                      );
                    },
                    childCount: sanPhamDaLoc.length,
                  ),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.72,
                  ),
                ),
              ),
          ],
        ),
      ),

      // THANH ĐIỀU HƯỚNG DƯỚI
      bottomNavigationBar: NavigationBar(
        selectedIndex: viTriHienTai,
        backgroundColor: Colors.white,
        indicatorColor: Colors.blue.shade100,
        onDestinationSelected: chonTrang,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            selectedIcon: Icon(Icons.shopping_cart),
            label: 'Giỏ hàng',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Tài khoản',
          ),
        ],
      ),
    );
  }
}

// THẺ SẢN PHẨM
class ProductCard extends StatelessWidget {
  final Product sanPham;
  final String Function(double) dinhDangGia;
  final VoidCallback onAdd;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.sanPham,
    required this.dinhDangGia,
    required this.onAdd,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hình minh họa sản phẩm
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE0E6EF),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  child: Icon(
                    sanPham.icon,
                    size: 65,
                    color: const Color(0xFF8A9BB0),
                  ),
                ),
              ),

              // Thông tin sản phẩm
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  9,
                  8,
                  9,
                  8,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      sanPham.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      dinhDangGia(sanPham.price),
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 7),

                    SizedBox(
                      width: double.infinity,
                      height: 32,
                      child: ElevatedButton(
                        onPressed: onAdd,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Thêm vào giỏ',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
