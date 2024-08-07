import 'dart:io';
import 'package:a2zjewelry/features/product/domain/entities/product_entity.dart';
import 'package:a2zjewelry/features/vendor/presentation/providers/vendor_product_edit_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class EditProductForm extends ConsumerWidget {
  final Product product;

  const EditProductForm({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _EditProductFormBody(product: product);
  }
}

class _EditProductFormBody extends ConsumerStatefulWidget {
  final Product product;

  const _EditProductFormBody({required this.product, Key? key}) : super(key: key);

  @override
  _EditProductFormBodyState createState() => _EditProductFormBodyState();
}

class _EditProductFormBodyState extends ConsumerState<_EditProductFormBody> {
  final _formKey = GlobalKey<FormState>();
  late String _categoryName;
  late String _productName;
  late String _intro;
  late String _description;
  late String _price;
  late int _stockQuantity;
  List<XFile> _selectedImages = [];

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _categoryName = widget.product.category.name;
    _productName = widget.product.name;
    _intro = widget.product.intro;
    _description = widget.product.description;
    _price = widget.product.price.toString();
    _stockQuantity = widget.product.stockQuantity;
  }

  Future<void> _pickImages() async {
    if (_selectedImages.length >= 10) {
      return;
    }

    final List<XFile>? pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles != null) {
      setState(() {
        _selectedImages.addAll(pickedFiles);
        if (_selectedImages.length > 10) {
          _selectedImages = _selectedImages.sublist(0, 10);
        }
      });
    }
  }

  void _saveChanges() {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedProduct = Product(
        id: widget.product.id,
        slug: widget.product.slug,
        category: Category(name: _categoryName),
        name: _productName,
        intro: _intro,
        description: _description,
        price: double.tryParse(_price) ?? 0.0,
        stockQuantity: _stockQuantity,
        listInEcommerce: true,
        images: _selectedImages.map((file) => ProductImage(image: file.path)).toList(),
      );

      ref.read(vendorUpdateProvider.notifier).updateProduct(updatedProduct, widget.product.id!)  ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Product Images"),
              SizedBox(
                height: 120,
                child: Row(
                  children: List.generate(
                    _selectedImages.length < 10
                        ? _selectedImages.length + 1
                        : _selectedImages.length,
                    (index) {
                      if (index < _selectedImages.length) {
                        return Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(_selectedImages[index].path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Expanded(
                          child: GestureDetector(
                            onTap: _pickImages,
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              color: Colors.grey[200],
                              child: Center(
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _categoryName,
                decoration: const InputDecoration(labelText: 'Category Name'),
                onChanged: (value) => _categoryName = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter category name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _productName,
                decoration: const InputDecoration(labelText: 'Product Name'),
                onChanged: (value) => _productName = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _intro,
                decoration: const InputDecoration(labelText: 'Intro'),
                onChanged: (value) => _intro = value,
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) => _description = value,
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _price,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onChanged: (value) => _price = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _stockQuantity.toString(),
                decoration: const InputDecoration(labelText: 'Stock Quantity'),
                keyboardType: TextInputType.number,
                onChanged: (value) => _stockQuantity = int.tryParse(value) ?? 0,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter stock quantity';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  child: const Text('Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
