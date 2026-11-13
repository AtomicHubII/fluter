
import 'package:flutter/material.dart';

class MyIndecator extends StatefulWidget {
  const MyIndecator({super.key});

  @override
  State<MyIndecator> createState() => _MyIndecatorState();
}

class _MyIndecatorState extends State<MyIndecator> {
  double w = 20;
  double h = 20;
  double s = 5;

  int currentIndex = 0;

  final List<String> images = [
    getUrlImage1(),
    getUrlImage2(),
    getUrlImage3(),
    getUrlImage4(),
    getUrlImage5(),
  ];

  int get totalImages => images.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hiển thị ảnh hiện tại
            buildImage(images[currentIndex]),

            const SizedBox(height: 10),

            // Nút Previous, indicator và Next
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentIndex =
                          (currentIndex - 1 + totalImages) %
                              totalImages;
                    });
                  },
                  child: const Text('Previous'),
                ),

                const SizedBox(width: 10),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    totalImages,
                    (index) => buildIndecator(
                      index == currentIndex
                          ? Colors.red
                          : Colors.grey,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentIndex =
                          (currentIndex + 1) % totalImages;
                    });
                  },
                  child: const Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage(String imageUrl) {
  return Container(
    width: 300,
    height: 200,
    margin: const EdgeInsets.all(5),
    child: Image.network(
      imageUrl,
      width: 300,
      height: 200,
      fit: BoxFit.cover,

      // Hiển thị khi đang tải
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;

        return const Center(
          child: CircularProgressIndicator(),
        );
      },

      // Hiển thị lỗi cụ thể
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Lỗi tải ảnh: $error');
        return const Center(
          child: Text('Không tải được ảnh'),
        );
      },
    ),
  );
}

  Widget buildIndecator(Color color) {
    return Container(
      width: w,
      height: h,
      margin: EdgeInsets.all(s),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: color,
      ),
    );
  }

  static String getUrlImage1() {
    return 'https://plus.unsplash.com/premium_photo-1781716619386-a7bee8f8d2a8?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D';
  }

  static String getUrlImage2() {
    return 'https://images.unsplash.com/photo-1791747725026-0af15bae3182?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D';
  }

  static String getUrlImage3() {
    return 'https://images.unsplash.com/photo-1790059718313-ffc4963313d0?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D';
  }

  static String getUrlImage4() {
    return 'https://images.unsplash.com/photo-1792103814866-5c90f4f63c41?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D';
  }

  static String getUrlImage5() {
    return 'https://images.unsplash.com/photo-1792163714276-04ac34422845?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D';
  }
}
