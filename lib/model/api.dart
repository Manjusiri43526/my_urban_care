class Welcome {
  Info info;
  List<Item> item;

  Welcome({
    required this.info,
    required this.item,
  });
}

class Info {
  String postmanId;
  String name;
  String schema;
  String exporterId;
  String collectionLink;

  Info({
    required this.postmanId,
    required this.name,
    required this.schema,
    required this.exporterId,
    required this.collectionLink,
  });
}

class Item {
  String name;
  Request request;
  List<dynamic> response;

  Item({
    required this.name,
    required this.request,
    required this.response,
  });
}

class Request {
  Method method;
  List<dynamic> header;
  Body? body;
  Url url;

  Request({
    required this.method,
    required this.header,
    this.body,
    required this.url,
  });
}

class Body {
  Mode mode;
  List<Formdatum> formdata;

  Body({
    required this.mode,
    required this.formdata,
  });
}

class Formdatum {
  String key;
  String value;
  Type type;

  Formdatum({
    required this.key,
    required this.value,
    required this.type,
  });
}

enum Type { TEXT }

enum Mode { FORMDATA }

enum Method { GET, POST }

class Url {
  String raw;
  Protocol protocol;
  List<Host> host;
  List<String> path;

  Url({
    required this.raw,
    required this.protocol,
    required this.host,
    required this.path,
  });
}

enum Host { COLLEGEPROJECTZ, COM }

enum Protocol { HTTPS }
