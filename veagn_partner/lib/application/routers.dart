import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;

import 'package:partner/application/splash/page.dart';
import 'package:partner/application/home/page.dart';

import 'package:partner/application/home/index_page/page.dart';
import 'package:partner/application/home/message_page/page.dart';
import 'package:partner/application/home/mine_page/page.dart';
import 'package:partner/application/home/mine_page/change_skin/page.dart';
import 'package:partner/partner/gank/welfare/page.dart';

import 'package:partner/partner/pic_insect/pic_insect_gallery/page.dart';
import 'package:partner/partner/pic_insect/pic_insect_list_page/attention_page/page.dart';
import 'package:partner/partner/pic_insect/pic_insect_list_page/hot_page/page.dart';
import 'package:partner/partner/pic_insect/pic_insect_list_page/recommend_page/page.dart';
import 'package:partner/partner/pic_insect/pic_insect_list_page/video_page/page.dart';

import 'global_store/state.dart';
import 'global_store/store.dart';

class Routers {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext appContext;

  /// 创建应用的根 Widget
  /// 1. 创建一个简单的路由，并注册页面
  /// 2. 对所需的页面进行和 AppStore 的连接
  /// 3. 对所需的页面进行 AOP 的增强
  static final AbstractRoutes router = PageRoutes(
    pages: <String, Page<Object, dynamic>>{
      'home_page': HomePage(),
      'splash_page': SplashPage(),

      /// home
      'index_page': IndexPage(),
      'msg_page': MessagePage(),
      'mine_page': MinePage(),
      'change_skin_page': ChangeSkinPage(),

      'pic_insect_gallery_page': PicInsectGalleryPage(),
      'attention_page': AttentionPage(),
      'recommend_page': RecommendPage(),
      'hot_page': HotPage(),
      'video_page': VideoPage(),

      'wel_fare_page' : WelFarePage(),
    },
    visitor: (String path, Page<Object, dynamic> page) {
      /// 只有特定的范围的 Page 才需要建立和 AppStore 的连接关系
      /// 满足 Page<T> ，T 是 GlobalBaseState 的子类
      if (page.isTypeof<GlobalBaseState>()) {
        /// 建立 AppStore 驱动 PageStore 的单向数据连接
        /// 1. 参数1 AppStore
        /// 2. 参数2 当 AppStore.state 变化时, PageStore.state 该如何变化
        page.connectExtraStore<GlobalState>(GlobalStore.store, (Object pageState, GlobalState appState) {
          final GlobalBaseState p = pageState;
          if (p.themeColor != appState.themeColor) {
            if (pageState is Cloneable) {
              final Object copy = pageState.clone();
              final GlobalBaseState newState = copy;
              newState.themeColor = appState.themeColor;

              return newState;
            }
          }
          return pageState;
        });
      }

      /// AOP
      /// 页面可以有一些私有的 AOP 的增强， 但往往会有一些 AOP 是整个应用下，所有页面都会有的。
      /// 这些公共的通用 AOP ，通过遍历路由页面的形式统一加入。
      page.enhancer.append(
        /// View AOP
        viewMiddleware: <ViewMiddleware<dynamic>>[
          safetyView<dynamic>(),
        ],

        /// Adapter AOP
        adapterMiddleware: <AdapterMiddleware<dynamic>>[safetyAdapter<dynamic>()],

        /// Effect AOP
        effectMiddleware: <EffectMiddleware<dynamic>>[
          _pageAnalyticsMiddleware<dynamic>(),
        ],

        /// Store AOP
        middleware: <Middleware<dynamic>>[
          logMiddleware<dynamic>(tag: page.runtimeType.toString()),
        ],
      );
    },
  );
}

/// 简单的 Effect AOP
/// 只针对页面的生命周期进行打印
EffectMiddleware<T> _pageAnalyticsMiddleware<T>({String tag = 'redux'}) {
  return (AbstractLogic<dynamic> logic, Store<T> store) {
    return (Effect<dynamic> effect) {
      return (Action action, Context<dynamic> ctx) {
        if (logic is Page<dynamic, dynamic> && action.type is Lifecycle) {
          print('${logic.runtimeType} ${action.type.toString()} ');
        }
        return effect?.call(action, ctx);
      };
    };
  };
}
