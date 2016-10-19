library fire.miniprop;

import 'dart:convert' as conv;

class MiniProp {
  Map<String, Object> _content;

  MiniProp.fromMap(Map<String, Object> content) {
    _content = content;
  }

  factory MiniProp.fromByte(List<int> bytes, {errorIsThrow: false}) {
    var jsonText = conv.UTF8.decode(bytes, allowMalformed: true);
    return new MiniProp.fromString(jsonText, errorIsThrow: errorIsThrow);
  }

  MiniProp.fromString(String jsonText, {errorIsThrow: false}) {
    try {
      _content = conv.JSON.decode(jsonText);
    } catch (e) {
      if (errorIsThrow == true) {
        throw e;
      }
    }
    if (_content == null) {
      _content = {};
    }
  }

  Object getPropObject(String category, String key, Object defaultValue) {
    var categoryContainer = {};
    //
    // category
    if (category == null || category == "") {
      categoryContainer = _content;
    } else if (false == _content.containsKey(category)) {
      return defaultValue;
    } else {
      categoryContainer = _content[category];
    }
    //
    // key
    if (false == categoryContainer.containsKey(key)) {
      return defaultValue;
    }
    //
    var v = categoryContainer[key];
    if (v == null) {
      return defaultValue;
    }
    return v;
  }

  void setPropObject(String category, String key, Object defaultValue) {
    var categoryContainer = {};
    // category
    if (category == null || category == "") {
      categoryContainer = _content;
    } else {
      categoryContainer = _content[category];
    }
    categoryContainer[key] = defaultValue;
  }

  String getString(String key, String defaultValue) {
    return getPropString(null, key, defaultValue);
  }

  num getNum(String key, num defaultValue) {
    return getPropNum(null, key, defaultValue);
  }

  num getPropNum(String category, String key, num defaultValue) {
    var v = getPropObject(category, key, defaultValue);
    if (v is num || v is int || v is double) {
      return v;
    } else {
      return defaultValue;
    }
  }

  String getPropString(String category, String key, String defaultValue) {
    var v = getPropObject(category, key, defaultValue);
    if (v is String) {
      return v;
    } else {
      return defaultValue;
    }
  }

  void setString(String key, String value) {
    setPropObject(null, key, value);
  }

  void setNum(String key, num value) {
    setPropObject(null, key, value);
  }

  void setPropString(String category, String key, String value) {
    setPropObject(category, key, value);
  }

  void setPropNum(String category, String key, num value) {
    setPropObject(category, key, value);
  }
}
