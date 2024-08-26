import 'package:flutter/material.dart';

enum CustomFieldStyle {
  text,
  email,
  password,
  number,
  comment,
  person,
}

class CustomField extends StatefulWidget {
  final CustomFieldStyle style;
  final String label;
  final TextInputType inputType;
  final TextEditingController? controller;
  final int? maxLines;
  final String? suffixText; // Tambahkan parameter untuk suffix text
  final bool readOnly; // Tambahkan parameter readOnly

  const CustomField.text({
    super.key,
    required this.label,
    this.controller,
    this.inputType = TextInputType.text,
    this.style = CustomFieldStyle.text,
    this.maxLines,
    this.suffixText,
    this.readOnly = false, // Atur default value
  });

  const CustomField.email({
    super.key,
    required this.label,
    this.controller,
    this.inputType = TextInputType.emailAddress,
    this.style = CustomFieldStyle.email,
    this.maxLines,
    this.suffixText,
    this.readOnly = false, // Atur default value
  });

  const CustomField.password({
    super.key,
    required this.label,
    this.controller,
    this.inputType = TextInputType.visiblePassword,
    this.style = CustomFieldStyle.password,
    this.maxLines,
    this.suffixText,
    this.readOnly = false, // Atur default value
  });

  const CustomField.number({
    super.key,
    required this.label,
    this.controller,
    this.inputType = TextInputType.number,
    this.style = CustomFieldStyle.number,
    this.maxLines,
    this.suffixText,
    this.readOnly = false, // Atur default value
  });

  const CustomField.comment({
    super.key,
    required this.label,
    this.controller,
    this.inputType = TextInputType.multiline,
    this.style = CustomFieldStyle.comment,
    this.maxLines,
    this.suffixText,
    this.readOnly = false, // Atur default value
  });

  const CustomField.person({
    super.key,
    required this.label,
    this.controller,
    this.inputType = TextInputType.text,
    this.style = CustomFieldStyle.person,
    this.maxLines,
    required this.suffixText, // Jadikan parameter required
    this.readOnly = false, // Atur default value
  });

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: TextFormField(
              controller: widget.controller,
              keyboardType: widget.inputType,
              textCapitalization: widget.style == CustomFieldStyle.text ? TextCapitalization.words : TextCapitalization.none,
              textInputAction: widget.style == CustomFieldStyle.password ? TextInputAction.done : TextInputAction.next,
              obscureText: _obscureText ? widget.style == CustomFieldStyle.password : false,
              cursorColor: Colors.blue,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              maxLines: widget.style == CustomFieldStyle.comment ? widget.maxLines ?? 3 : 1,
              readOnly: widget.readOnly, // Gunakan properti readOnly
              decoration: InputDecoration(
                hintText: 'Input ${widget.label.toLowerCase()}',
                hintStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14.0,
                  horizontal: 12.0,
                ),
                suffixIcon: widget.style == CustomFieldStyle.password
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(
                          _obscureText ? Icons.visibility_off : Icons.visibility,
                          color: _obscureText ? Colors.grey : Colors.blue,
                        ),
                      )
                    : null,
                suffixText: widget.style == CustomFieldStyle.person ? widget.suffixText : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
