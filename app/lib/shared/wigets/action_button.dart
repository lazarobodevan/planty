import 'package:app/theme/theme_colors.dart';
import 'package:app/theme/typography_styles.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  final bool? isActive;
  final Function() onTap;
  const ActionButton({super.key, this.isActive, required this.onTap});

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {

  late bool _isActive;

  @override
  void initState() {
    _isActive = widget.isActive ?? true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        widget.onTap();
      },
      child: Ink(
        height: 60,
        decoration: BoxDecoration(
          color: ThemeColors.primary2,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0,6),
              spreadRadius: 2,
              blurRadius: 6
            )
          ]
        ),
        child: Center(
          child: Text("Concluir", style: TypographyStyles.label2().copyWith(color: Colors.white),),
        ),
      ),
    );
  }
}
