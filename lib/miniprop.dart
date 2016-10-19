library fire.miniprop;

import 'dart:convert' as conv;

class MiniProp {
  Map<String,Object> _content;

  factory MiniProp.fromByte(List<int> bytes) {
    var jsonText = conv.UTF8.decode(bytes,allowMalformed: true);
    return new MiniProp.fromString(jsonText);
  }

  MiniProp.fromString(String jsonText) {
    _content = conv.JSON.decode(jsonText);
  }

}
