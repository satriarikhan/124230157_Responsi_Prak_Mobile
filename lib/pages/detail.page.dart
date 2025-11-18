import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsi_apk/models/product_model.dart';
import 'package:responsi_apk/providers/cart_provider.dart';

class DetailPage extends StatefulWidget {
  final Product product;
  const DetailPage({super.key, required this.product});
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isCart = false;

  @override
  void initState() {
    super.initState();
    final fav = Provider.of<CartProvider>(context, listen: false);
    _isCart = fav.isCart(widget.product.id);
  }

  @override
  Widget build(BuildContext context) {
    final favProv = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text(widget.product.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: Image.network(
                widget.product.image,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (_, __, ___) => Container(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.product.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _isCart ? Icons.favorite : Icons.favorite_border,
                      color: _isCart ? Colors.red : null,
                    ),
                    onPressed: () async {
                      await favProv.toggleCart(widget.product.id);
                      setState(() {
                        _isCart = !_isCart;
                      });
                    },
                  )
                ],
              ),
            ),
            ListTile(
              title: const Text('Description'),
              trailing: Text(widget.product.description),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                widget.product.category.isEmpty
                    ? 'No synopsis available.'
                    : widget.product.category,
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}