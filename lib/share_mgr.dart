import 'dart:async';
import 'package:chedemo/second.dart';
import 'package:chedemo/share_model.dart';
import 'package:chedemo/third.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:convert' as convert;

class ShareMgr {
  BuildContext? mContext;
  bool _isInit = false;
  init(BuildContext context) {
    mContext = context;
    if (_isInit) {
      return;
    }
    _isInit = true;
    handleIncomingLinks();
    handleInitialUri();
  }

  //程序打开时介入
  StreamSubscription? sub;
  void handleIncomingLinks() {
    if (!kIsWeb) {
      sub = uriLinkStream.listen((Uri? uri) {
        pdebug('got uri: $uri');
        if (uri == null) {
          pdebug('no initial uri');
        } else {
          _getShareData(uri);
        }
      }, onError: (Object err) {
        pdebug('got err:$err');
      });
    }
  }

  //第一次打开app
  bool _initialUriIsHandled = false;
  Future<void> handleInitialUri() async {
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      try {
        final uri = await getInitialUri();
        if (uri == null) {
          pdebug('no initial uri');
        } else {
          _getShareData(uri);
        }
      } on PlatformException {
        pdebug('falied to get initial uri');
      } on FormatException catch (err) {
        pdebug(err);
      }
    }
  }

  //解数据
  _getShareData(Uri uri) {
    String passInfoStr = '';
    if (uri.path.contains('pass_info') &&
        uri.host.contains('share.chedemo.com')) {
      List<String> passList = uri.path.split('pass_info=');
      if (passList.length > 1) {
        passInfoStr = passList[1];
      }
    }
    if (passInfoStr.isNotEmpty) {
      ShareModel? shareModel = decodeScanModel(passInfoStr);
      if (shareModel != null) {
        if (shareModel.openType == ShareModel.ShareOpenTypePage) {
          if (mContext != null) {
            jumpToPage(shareModel);
          }
        } else {
          //外部链接
        }
      }
    }
  }

  jumpToPage(ShareModel shareModel) {
    switch (shareModel.pageId) {
      case 10000:
        to(mContext!, const SecondPage());
        break;
      case 10001:
        to(mContext!, const ThirdPage());
        break;
      default:
        pdebug('类型错误');
        break;
    }
  }

  /*
  * Base64转model
  */
  ShareModel? decodeScanModel(String base64Str) {
    try {
      String jsonStr = base64Decode(base64Str);
      var scanModel = ShareModel()..applyJson(convert.jsonDecode(jsonStr));
      return scanModel;
    } catch (e) {
      pdebug(e);
    }
    return null;
  }

  /*
  * Base64解密
  */
  String base64Decode(String data) {
    List<int> bytes = convert.base64Decode(data);
    String result = convert.utf8.decode(bytes);
    return result;
  }

  /*
  * Base64加密
  */
  String base64Encode(String data) {
    var content = convert.utf8.encode(data);
    var digest = convert.base64Encode(content);
    return digest;
  }

  //进入界面，支持回调函数
  static void to(BuildContext context, Widget page,
      {Function(dynamic value)? onBack}) {
    Navigator.push(
      context,
      MaterialPageRoute(
          maintainState: true,
          builder: (context) {
            return page;
          }),
    ).then((value) {
      if (onBack != null) {
        onBack(value);
      }
    });
  }
}

pdebug(info) {
  if (kDebugMode) {
    print(info);
  }
}
