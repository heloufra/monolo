import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPhoneField;
  final VoidCallback? onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.isPhoneField = false,
    this.onChanged,
    this.keyboardType,
    this.inputFormatters,
    this.maxLines
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
        ),
        SizedBox(height: 8),
        if (isPhoneField)
          Row(
            children: [
              Container(
                width: 80,
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    focusColor: Color(0xFF282828),
                    
                  ),
                  controller: TextEditingController(text: '+212'),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildTextField(),
              ),
            ],
          )
        else
          _buildTextField(),
      ],
    );
  }

  Widget _buildTextField() {
    return TextField(
      controller: controller,
      onChanged: (value) {
        if (onChanged != null) onChanged!();
      },
      keyboardType: keyboardType,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        focusColor: Colors.green,
        prefixIconColor: Colors.green,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
        
      ),
    );
  }
}