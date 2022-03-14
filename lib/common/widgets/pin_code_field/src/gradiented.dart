part of pin_code_fields;

/// Don't forget to set a child foreground color to white
class Gradiented extends StatelessWidget {
  final Gradient gradient;
  final Widget child;

  const Gradiented({Key? key, required this.child, required this.gradient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(shaderCallback: gradient.createShader, child: child);
  }
}
