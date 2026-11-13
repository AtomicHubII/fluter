
import 'package:flutter/material.dart';
import 'product.dart';

class ChiTietSanPham extends StatefulWidget {
  final Product sanPham;
  final VoidCallback onAddToCart;

  const ChiTietSanPham({
    super.key,
    required this.sanPham,
    required this.onAddToCart,
  });

  @override
  State<ChiTietSanPham> createState() => _ChiTietSanPhamState();
}

class _ChiTietSanPhamState extends State<ChiTietSanPham> {
  final PageController pageController = PageController();

  int viTriAnh = 0;
  bool yeuThich = false;
  bool moRongMoTa = false;

  String dinhDangGia(double gia) {
    return '${gia.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    )}đ';
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sanPham = widget.sanPham;

    final moTa = '''
${sanPham.name} là sản phẩm được thiết kế hiện đại, phù hợp với nhu cầu sử dụng hằng ngày.

Sản phẩm có thiết kế đẹp, dễ sử dụng và mang lại trải nghiệm tiện lợi cho người dùng.

Danh mục: ${sanPham.category}

ShopEasy cam kết cung cấp sản phẩm chất lượng và hỗ trợ khách hàng trong quá trình mua sắm.
''';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      // Thanh tiêu đề
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF174A8B),
          ),
        ),
        title: const Text(
          'Chi tiết sản phẩm',
          style: TextStyle(
            color: Color(0xFF174A8B),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                yeuThich = !yeuThich;
              });
            },
            icon: Icon(
              yeuThich ? Icons.favorite : Icons.favorite_border,
              color: yeuThich ? Colors.red : Colors.grey,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),

      // Nội dung có thể cuộn
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Khu vực hình ảnh vuốt ngang
                  Container(
                    height: 290,
                    color: const Color(0xFFE0E6EF),
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: pageController,
                          itemCount: 3,
                          onPageChanged: (index) {
                            setState(() {
                              viTriAnh = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return Center(
                              child: Container(
                                width: 220,
                                height: 220,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Icon(
                                  sanPham.icon,
                                  size: 110,
                                  color: const Color(0xFF174A8B),
                                ),
                              ),
                            );
                          },
                        ),

                        // Dấu chấm vị trí ảnh
                        Positioned(
                          bottom: 12,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              3,
                              (index) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  width: viTriAnh == index ? 9 : 7,
                                  height: viTriAnh == index ? 9 : 7,
                                  decoration: BoxDecoration(
                                    color: viTriAnh == index
                                        ? Colors.blue
                                        : Colors.blue.shade100,
                                    shape: BoxShape.circle,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        // Nút yêu thích trên ảnh
                        Positioned(
                          top: 12,
                          right: 15,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  yeuThich = !yeuThich;
                                });
                              },
                              icon: Icon(
                                yeuThich
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: yeuThich ? Colors.red : Colors.grey,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Thông tin sản phẩm
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sanPham.name,
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 19,
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 19,
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 19,
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 19,
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 19,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '4.8  |  125 đánh giá',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        Row(
                          children: [
                            Text(
                              dinhDangGia(sanPham.price),
                              style: const TextStyle(
                                color: Color(0xFF174A8B),
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Text(
                                '-25%',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        const Divider(),

                        const Text(
                          'Mô tả sản phẩm',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        AnimatedCrossFade(
                          duration: const Duration(milliseconds: 250),
                          crossFadeState: moRongMoTa
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          firstChild: Text(
                            moTa,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.6,
                            ),
                          ),
                          secondChild: Text(
                            moTa,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.6,
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                moRongMoTa = !moRongMoTa;
                              });
                            },
                            child: Text(
                              moRongMoTa ? 'Thu gọn' : 'Xem thêm',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Thông tin sản phẩm',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text('Danh mục: Sản phẩm công nghệ'),
                        SizedBox(height: 8),
                        Text('Thương hiệu: Chính hãng'),
                        SizedBox(height: 8),
                        Text('Bảo hành: 12 tháng'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),

      // Thanh hành động cố định phía dưới
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 10,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: widget.onAddToCart,
                  icon: const Icon(Icons.shopping_cart_outlined),
                  label: const Text('Thêm vào giỏ'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF174A8B),
                    side: const BorderSide(
                      color: Color(0xFF174A8B),
                    ),
                    minimumSize: const Size(0, 46),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    widget.onAddToCart();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Đã thêm sản phẩm! Bạn có thể tiến hành thanh toán trong giỏ hàng.',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(0, 46),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Mua ngay',
                    style: TextStyle(
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
