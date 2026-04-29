import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_constants.dart';
import 'package:task_manager/widgets/my_text.dart';

class MyField extends StatefulWidget {
  final String? label;
  final String hint;
  final VoidCallback onTap;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final TextEditingController? controller;
  final IconData? icon;
  final bool openBoard;
  final int? maxLines;

  const MyField({
    super.key,
    required this.hint,
    required this.onTap,
    this.onClear,
    this.controller,
    this.label,
    this.icon,
    this.openBoard = false,
    this.onChanged,
    this.maxLines,
  });

  @override
  State<MyField> createState() => _MyFieldState();
}

class _MyFieldState extends State<MyField> {
  late final TextEditingController _controller;
  bool _hasText = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_handleTextChange);
  }

  void _handleTextChange() {
    if (!mounted) return;
    final hasText = _controller.text.isNotEmpty;
    if (hasText != _hasText) setState(() => _hasText = hasText);
    widget.onChanged?.call(_controller.text);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChange);
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    widget.onClear?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: MyText(
              text: widget.label!,
              color: Color(0xFF888888),
              size: 11,
              weight: FontWeight.w600,
              space: 1.5,
            ),
          ),

        Focus(
          onFocusChange: (focused) => setState(() => _isFocused = focused),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: const Color(0xFF141414),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _isFocused
                    ? const Color(0xFFE8C547)
                    : const Color(0xFF2A2A2A),
                width: 1.5,
              ),
            ),
            child: TextFormField(
              controller: _controller,
              readOnly: widget.openBoard,

              style: const TextStyle(
                color: Color(0xFFF0EDE6),
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              cursorColor: const Color(0xFFE8C547),
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: const TextStyle(
                  color: Color(0xFF555555),
                  fontSize: 14,
                ),
                prefixIcon: widget.icon != null
                    ? Icon(
                        widget.icon,
                        color: _isFocused
                            ? const Color(0xFFE8C547)
                            : const Color(0xFF555555),
                        size: 20,
                      )
                    : null,
                suffixIcon: _hasText
                    ? IconButton(
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Color(0xFF555555),
                          size: 18,
                        ),
                        onPressed: _clear,
                      )
                    : null,
                filled: false,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
              onTap: widget.onTap,
              onChanged: widget.onChanged,
              maxLines: widget.maxLines,
              validator: AppConstants.commonValidator,
            ),
          ),
        ),
      ],
    );
  }
}
