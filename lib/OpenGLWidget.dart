
import 'package:external_plugin/external_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class OpenGLWidget extends StatefulWidget {
  OpenGLWidget({
    Key key,
    this.width = 200,
    this.height = 200
  }):super(key:key);

  var width;
  var height;

  @override
  State<StatefulWidget> createState() {
    return _TextureState();
  }
}

class _TextureState extends State<OpenGLWidget> {

  final _externalPlugin = ExternalPlugin();

  @override
  void initState() {
    super.initState();
    initPlugin();
  }

  void initPlugin() async {
    await _externalPlugin.initialize(widget.width, widget.height);
    setState(() {});
  }

  @override
  Future<void> dispose() {
    super.dispose();
    _externalPlugin.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width.toDouble(),
      height: widget.height.toDouble(),
      child: _externalPlugin.isInitialized
          ? Texture(textureId: _externalPlugin.textureId)
          : Container(color: Colors.blue)
    );
  }

}