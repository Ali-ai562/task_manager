import 'package:flutter/material.dart';

class MyField extends StatefulWidget {
  final String? label;
  final String hint;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final TextEditingController? controller;
  final IconData? icon;
  final bool openBoard;
  final bool isPassword;
  final int? maxLines;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const MyField({
    super.key,
    required this.hint,
    this.onTap,
    this.onClear,
    this.controller,
    this.label,
    this.icon,
    this.openBoard = false,
    this.onChanged,
    this.isPassword = false,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
  });

  @override
  State<MyField> createState() => _MyFieldState();
}

class _MyFieldState extends State<MyField> {
  late final TextEditingController _controller;
  bool _hasText = false;
  bool _obscure = true;
  bool _isFocused = false;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = FocusNode();

    _controller.addListener(_handleTextChange);
    _focusNode.addListener(() {
      if (mounted) setState(() => _isFocused = _focusNode.hasFocus);
    });
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
    _focusNode.dispose();
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    widget.onClear?.call();
  }

  // palette
  // static const _bg        = Color(0xFF0A0A0A);
  static const _surface = Color(0xFF141414);
  static const _border = Color(0xFF2A2A2A);
  static const _gold = Color(0xFFE8C547);
  static const _textMain = Color(0xFFF0EDE6);
  static const _textMuted = Color(0xFF6B6860);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //label
        if (widget.label != null) ...[
          Text(
            widget.label!.toUpperCase(),
            style: const TextStyle(
              color: _textMuted,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
        ],

        //field
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: _surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isFocused ? _gold : _border,
              width: _isFocused ? 1.5 : 1.0,
            ),
            boxShadow: _isFocused
                ? [
                    BoxShadow(
                      color: _gold.withOpacity(0.08),
                      blurRadius: 12,
                      spreadRadius: 0,
                    ),
                  ]
                : [],
          ),
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            readOnly: widget.openBoard,
            obscureText: widget.isPassword && _obscure,
            maxLines: widget.isPassword ? 1 : widget.maxLines,
            keyboardType: widget.keyboardType,
            style: const TextStyle(
              color: _textMain,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            cursorColor: _gold,
            cursorWidth: 1.5,

            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: const TextStyle(color: _textMuted, fontSize: 14),

              prefixIcon: widget.icon != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Icon(
                        widget.icon,
                        color: _isFocused ? _gold.withOpacity(0.8) : _textMuted,
                        size: 18,
                      ),
                    )
                  : null,
              prefixIconConstraints: const BoxConstraints(minWidth: 48),

              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: _textMuted,
                        size: 18,
                      ),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    )
                  : _hasText
                  ? IconButton(
                      icon: Icon(
                        Icons.close_rounded,
                        color: _textMuted,
                        size: 16,
                      ),
                      onPressed: _clear,
                    )
                  : null,

              filled: true,
              fillColor: Colors.transparent,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
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
          ),
        ),
      ],
    );
  }
}
