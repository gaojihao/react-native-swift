export default {
  pages: [
    'pages/comment/index',
    'pages/course/index',
    'pages/detail/index',
    'pages/discovery/index',
    'pages/home/index',
    'pages/mine/index',
    'pages/play/index',
    'pages/read/index',
  ],
  window: {
    backgroundTextStyle: 'light',
    navigationBarBackgroundColor: '#fff',
    navigationBarTitleText: 'WeChat',
    navigationBarTextStyle: 'black'
  },
  tabBar: {
    color: '#8a8a8a',
    selectedColor: '#2298F8',
    borderStyle: 'black',
    backgroundColor: '#ffffff',
    position: 'bottom',
    list: [{
      pagePath: 'pages/home/index',
      text: '主页',
    },{
      pagePath: 'pages/discovery/index',
      text: '发现',
    },{
      pagePath: 'pages/mine/index',
      text: '我的',
    }]
  }
}
