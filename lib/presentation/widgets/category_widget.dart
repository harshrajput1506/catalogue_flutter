import 'package:catalogue_project/presentation/blocs/product/product_bloc.dart';
import 'package:catalogue_project/presentation/blocs/product/product_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryWidget extends StatelessWidget {
  final String? text;
  final int index;
  final bool isSelected;
  final Function(int) onSelected;

  const CategoryWidget({required this.text, required this.index ,required this.isSelected, required this.onSelected ,super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onSelected(index),
      child: Text(
        text ?? "",
        style: GoogleFonts.nunito(
          fontSize: isSelected ? 24.0 : 18.0,
          fontWeight: FontWeight.normal,
          color: Colors.black
        ),
      ),
    );
  }
}