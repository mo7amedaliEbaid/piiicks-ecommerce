import 'package:flutter/material.dart';
import 'package:piiicks/configs/app.dart';
import 'package:piiicks/domain/entities/product/product.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final PageController _pageController = PageController();

  // Controller for ListView
  final PageController _listController = PageController();

  @override
  void initState() {
    super.initState();

    // Add a listener to the PageController
    _pageController.addListener(() {
      // When the page changes, scroll the Horizontal ListView to the corresponding index
      _listController.jumpToPage(_pageController.page!.round());
    });

    // Add a listener to the Horizontal ListView controller
    _listController.addListener(() {
      // When the Horizontal ListView scrolls, update the PageView index
      _pageController.jumpToPage((_listController.page!.round()));
    });
  }

  @override
  void dispose() {
    // Dispose the controllers to avoid memory leaks
    _pageController.dispose();
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Scaffold(
      body: SizedBox(
        height: 600,
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: 300,
              child: Expanded(
                child: PageView.builder(
                    itemCount: widget.product.images.length,
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      return Image.network(widget.product.images[index]);
                    }),
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _listController,
                  itemCount: widget.product.images.length,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      Image.network(widget.product.images[index])),
            ),
          ],
        ),
      ),
    );
  }
}
