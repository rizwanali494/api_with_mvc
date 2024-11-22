import 'package:api_with_mvc/Controller/post_product_ctrl.dart';
import 'package:flutter/material.dart';
import '../Models/post_post_model.dart';
import 'package:toast/toast.dart';



class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _productIdController = TextEditingController();
  final _productNameController = TextEditingController();
  final _productDescriptionController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _productQuantityController = TextEditingController();
  final _productController = ProductController();


  void _addProduct() async {
    String productId = _productIdController.text;
    String productName = _productNameController.text;
    String productDescription = _productDescriptionController.text;
    double productPrice = double.tryParse(_productPriceController.text) ?? 0.0;
    int productQuantity = int.tryParse(_productQuantityController.text) ?? 0;

    if (productId.isNotEmpty && productName.isNotEmpty && productDescription.isNotEmpty && productPrice > 0 && productQuantity > 0) {
      ProductRequest product = ProductRequest(
        productId: productId,
        productName: productName,
        productDescription: productDescription,
        productPrice: productPrice,
        productQuantity: productQuantity,
      );

      ProductResponse? response = await _productController.addProduct(product);

      if (response != null) {
        print("Product Added Successfully: ${response.message}");
        Toast.show("Product Added Successfully",gravity: Toast.bottom, duration: Toast.lengthShort);
        // Handle successful product addition (e.g., show success message)
      } else {
        print("Failed to add product");
        Toast.show("Failed to add product" , gravity: Toast.bottom, duration: Toast.lengthShort);
        // Handle product addition failure (e.g., show error message)
      }
    } else {
      print("All fields are required and must be valid");
      // Show error message for invalid input
    }
  }




  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Product'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _productIdController,
                decoration: const InputDecoration(labelText: 'Product ID'),
              ),
              TextField(
                controller: _productNameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
              ),
              TextField(
                controller: _productDescriptionController,
                decoration: const InputDecoration(labelText: 'Product Description'),
              ),
              TextField(
                controller: _productPriceController,
                decoration: const InputDecoration(labelText: 'Product Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _productQuantityController,
                decoration: const InputDecoration(labelText: 'Product Quantity'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addProduct,

                child: const Text('Add Product'),
              ),
            ],
          ),
        ),
      );
  }
}
