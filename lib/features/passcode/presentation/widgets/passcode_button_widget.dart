import 'package:flutter/material.dart';

class PasscodeButtonWidget extends StatelessWidget {
  const PasscodeButtonWidget({
    super.key,
    this.onTap,
    this.child,
  });

  PasscodeButtonWidget.text({
    required BuildContext context,
    required String text,
    Key? key,
    VoidCallback? onTap,
  }) : this(
          key: key,
          onTap: onTap,
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        );

  final VoidCallback? onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
        child: child,
      ),
    );
  }
}
