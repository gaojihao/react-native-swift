import React, { Component } from 'react'
import { View, Text } from '@tarojs/components'
import './index.less'

export default class Comment extends Component {

  componentWillMount () { }

  componentDidMount () { }

  componentWillUnmount () { }

  componentDidShow () { }

  componentDidHide () { }

  render () {
    return (
      <View className='comment'>
        <Text>Hello world!</Text>
      </View>
    )
  }
}
