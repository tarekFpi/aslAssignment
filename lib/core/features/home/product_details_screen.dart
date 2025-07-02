import 'package:assignment_asl/core/features/home/model/product_reponse.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {

  final ProductReponseModel tasklist;

  const ProductDetailsScreen({super.key,required this.tasklist});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("product details"),
      ),
      body: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [

              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "${widget.tasklist.title}",
                    style: textTheme.bodySmall?.copyWith(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),

              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "${widget.tasklist.body}",
                    style: textTheme.bodySmall?.copyWith(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}
