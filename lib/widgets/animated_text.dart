import 'package:flutter/material.dart';

class AnimatedText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final TextAlign textAlign;
  final Duration delay;
  final Duration duration;
  final Animation<double>? parentAnimation;
  final AnimationType animationType;
  
  const AnimatedText({
    Key? key,
    required this.text,
    required this.style,
    this.textAlign = TextAlign.left,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 500),
    this.parentAnimation,
    this.animationType = AnimationType.slideUp,
  }) : super(key: key);
  
  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  
  @override
  void initState() {
    super.initState();
    
    // If parent animation is provided, use it instead of creating a new controller
    if (widget.parentAnimation != null) {
      _controller = AnimationController(
        vsync: this,
        duration: widget.duration,
        value: widget.parentAnimation!.value,
      );
      
      // Sync with parent animation
      widget.parentAnimation!.addListener(() {
        if (mounted) {
          _controller.value = widget.parentAnimation!.value;
        }
      });
    } else {
      _controller = AnimationController(
        vsync: this,
        duration: widget.duration,
      );
      
      if (widget.delay == Duration.zero) {
        _controller.forward();
      } else {
        Future.delayed(widget.delay, () {
          if (mounted) {
            _controller.forward();
          }
        });
      }
    }
    
    // Configure animations based on type
    switch (widget.animationType) {
      case AnimationType.slideUp:
        _slideAnimation = Tween<Offset>(
          begin: const Offset(0, 0.25),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOutCubic,
        ));
        break;
      case AnimationType.slideRight:
        _slideAnimation = Tween<Offset>(
          begin: const Offset(-0.25, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOutCubic,
        ));
        break;
      case AnimationType.slideLeft:
        _slideAnimation = Tween<Offset>(
          begin: const Offset(0.25, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOutCubic,
        ));
        break;
      case AnimationType.scale:
        _slideAnimation = Tween<Offset>(
          begin: Offset.zero,
          end: Offset.zero,
        ).animate(_controller); // No slide for scale animation
        break;
    }
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
  }
  
  @override
  void dispose() {
    // Only dispose if we created the controller
    if (widget.parentAnimation == null) {
      _controller.dispose();
    }
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    if (widget.animationType == AnimationType.scale) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.95, end: 1.0).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic)
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Text(
            widget.text,
            style: widget.style,
            textAlign: widget.textAlign,
          ),
        ),
      );
    }
    
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Text(
          widget.text,
          style: widget.style,
          textAlign: widget.textAlign,
        ),
      ),
    );
  }
}

enum AnimationType {
  slideUp,
  slideRight,
  slideLeft,
  scale,
}

