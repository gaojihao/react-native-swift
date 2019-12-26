import Taro, { Component } from "@tarojs/taro";
import Index from "./pages/index";

import "./assets/iconfont/iconfont.css";
import "./app.scss";
// 如果需要在 h5 环境中开启 React Devtools
// 取消以下注释：
// if (process.env.NODE_ENV !== 'production' && process.env.TARO_ENV === 'h5')  {
//   require('nerv-devtools')
// }

class App extends Component {
  // eslint-disable-next-line react/sort-comp
  config = {
    pages: [
      "pages/index/index",
      "pages/index/index2",
      "pages/index/index3",
      "pages/index/index4"
    ],
    window: {
      backgroundTextStyle: "light",
      navigationBarBackgroundColor: "#fff",
      navigationBarTitleText: "WeChat",
      navigationBarTextStyle: "black"
    },
    tabBar: {
      list: [
        {
          text: "首页",
          pagePath: "pages/index/index",
          selectedIconPath: "./assets/images/tab-home-current.png",
          iconPath: "./assets/images/tab-home.png"
        },
        {
          text: "分类",
          pagePath: "pages/index/index2",
          selectedIconPath: "./assets/images/tab-cate-current.png",
          iconPath: "./assets/images/tab-cate.png"
        },
        {
          text: "购物车",
          pagePath: "pages/index/index3",
          selectedIconPath: "./assets/images/tab-cart-current.png",
          iconPath: "./assets/images/tab-cart.png"
        },
        {
          text: "我的",
          pagePath: "pages/index/index4",
          selectedIconPath: "./assets/images/tab-my-current.png",
          iconPath: "./assets/images/tab-my.png"
        }
      ]
    }
  };

  componentDidMount() {}

  componentDidShow() {}

  componentDidHide() {}

  componentDidCatchError() {}

  // 在 App 类中的 render() 函数没有实际作用
  // 请勿修改此函数
  render() {
    return <Index />;
  }
}

Taro.render(<App />, document.getElementById("app"));
