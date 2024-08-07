import 'dart:io';
import 'package:a2zjewelry/features/product/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:a2zjewelry/features/register/presentation/widgets/loading_widget.dart';
import 'package:a2zjewelry/features/vendor/presentation/providers/vendor_providers.dart';

class ProductFormPage extends ConsumerStatefulWidget {
  const ProductFormPage({super.key});

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends ConsumerState<ProductFormPage> {
  final _categoryNameController = TextEditingController(text: 'watch');
  final _productNameController = TextEditingController();
  final _slugController = TextEditingController();
  final _introController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockQuantityController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedImages = [];

  @override
  void dispose() {
    _categoryNameController.dispose();
    _productNameController.dispose();
    _slugController.dispose();
    _introController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockQuantityController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    if (_selectedImages.length >= 4) {
      // Limit to 4 images
      return;
    }

    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _selectedImages.addAll(pickedFiles);
        if (_selectedImages.length > 4) {
          _selectedImages = _selectedImages.sublist(0, 4); // Limit to 4 images
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final productFormState = ref.watch(vendorAddProductProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: productFormState.when(
        data: (_) => _buildForm(context),
        loading: () => const LoadingWidget(),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Product Image"),
            SizedBox(
              height: 120,
              child: Row(
                children: List.generate(
                  _selectedImages.length < 4
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
                            child: const Center(
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
              controller: _categoryNameController,
              decoration: const InputDecoration(labelText: 'Category Name'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _productNameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _slugController,
              decoration: const InputDecoration(labelText: 'Slug'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _introController,
              decoration: const InputDecoration(labelText: 'Intro'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _stockQuantityController,
              decoration: const InputDecoration(labelText: 'Stock Quantity'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final List<ProductImage> imageItems = _selectedImages
                      .map((image) => ProductImage( image: image.path))
                      .toList();
                  final product = Product(
                    id: null,
                    category: Category(name: _categoryNameController.text),
                    name: _productNameController.text,
                    slug: _slugController.text,
                    intro: _introController.text,
                    description: _descriptionController.text,
                    price: double.parse(_priceController.text),
                    stockQuantity: int.parse(_stockQuantityController.text),
                    listInEcommerce: true,
                    images: imageItems,
                  );

                  await ref
                      .read(vendorAddProductProvider.notifier)
                      .addProduct(product);

                  // Clear the form after submission
                  _clearForm();
               
                },
                child: const Text("Add Product"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _clearForm() {
    _categoryNameController.clear();
    _productNameController.clear();
    _slugController.clear();
    _introController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _stockQuantityController.clear();
    setState(() {
      _selectedImages.clear();
    });
  }
}
