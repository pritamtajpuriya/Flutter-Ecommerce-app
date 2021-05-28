import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sajilo_dokan/config/theme.dart';

import 'package:sajilo_dokan/domain/model/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  ProductTile(this.product);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Stack(
        children: [
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                        child: Image.network(
                      'https://onlinehatiya.herokuapp.com' + product.image,
                      height: 170,
                      width: 130,
                      fit: BoxFit.fill,
                    )),
                  ),
                  SizedBox(height: 8),
                  Text(
                    product.title,
                    maxLines: 2,
                    style: GoogleFonts.ptSans(),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  SizedBox(height: 8),
                  Text('Rs. ' + '${product.price}',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFF7643))),
                ],
              ),
            ),
          ),
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: 20,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: Colors.red),
                child: Center(
                  child: Text(
                    product.price <= 30 ? 'New' : '-30%',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )),
          Positioned(
              bottom: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                      )),
                ),
              )),
        ],
      ),
    );
  }
}
