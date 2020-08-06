
import 'package:external_plugin/external_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class OpenGLWidget extends StatefulWidget {
  OpenGLWidget({
    Key key,
    this.width,
    this.height
  }):super(key:key);

  var width = 200.0;
  var height = 200.0;

  @override
  State<StatefulWidget> createState() {
    return _TextureState();
  }
}

class _TextureState extends State<OpenGLWidget> {

  final _externalPlugin = ExternalPlugin();


  @override
  Future<void> initState() async {
    super.initState();
    await _externalPlugin.initialize(widget.width, widget.height);
    setState(() {});
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await _externalPlugin.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: _externalPlugin.isInitialized
          ? Texture(textureId: _externalPlugin.textureId)
          : Container(color: Colors.blue)
    );
  }

}