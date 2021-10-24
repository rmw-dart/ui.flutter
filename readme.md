# [2021-10-23] kraken 学习笔记 · 01 （ 开发环境配置 & 打包界面到应用 ）

想写一个去中心化的微博，记录下开发笔记。

## 本文代码库地址

* 前端界面 https://github.com/rmw-dart/ui
* 应用打包 https://github.com/rmw-dart/ui.flutter


## 安装 kraken

kraken:版本0.8.4

用yarn安装总是失败，改用npm安装如下

```
npm install -g @openkraken/cli
```


## 前端界面加载图片的问题

kraken无法读取本地目录。

为了调试时候可以加载图片，需要启动一个服务器，配置比较复杂，如下

package.json

```
{
  "scripts": {
    "dev": "concurrently --kill-others \"vite build --mode=development --watch\" \"npx nodemon --exec 'kraken http://localhost:5000/main.js' --watch 'dist/**/*' -e coffee,js,mjs,json,wasm,txt,yaml\"",
    "build": "vite build"
  },
  "dependencies": {
    "vue": "^3.2.12"
  },
  "devDependencies": {
    "@vitejs/plugin-vue": "^1.9.3",
    "coffeescript": "^2.6.1",
    "concurrently": "^6.3.0",
    "nodemon": "^2.0.14",
    "rollup-plugin-coffee2": "^0.1.16",
    "rollup-plugin-pug": "^1.1.1",
    "vite": "^2.6.10"
  },
  "type": "module"
}
```

dev.sh

```
npx concurrently --kill-others "vite preview --host 0.0.0.0" "yarn dev"
```

vite.config.js

```
import { defineConfig } from 'vite'

import vue from '@vitejs/plugin-vue'
import coffee from 'rollup-plugin-coffee2'
import pug from 'rollup-plugin-pug'

export default defineConfig(
  ({ mode }) =>{
    const isDev = mode !== 'production';

    return {
      base: isDev ? 'http://localhost:5000':'',
      plugins: [
        coffee({
          bare:true,
          sourceMap: true // 不设置true会报错，很奇怪
        }),
        pug(),
        vue()
      ],

      build: {
        minify: !isDev,
        rollupOptions: {
          input: 'src/main.js',
          output: {
            entryFileNames: `[name].js`,
            manualChunks: {}
          }
        }
      }
    }
  }
)
```

使用图片，先import然后传参数。

打包的时候，把build后图片打包到flutter即可。

## 图标的使用


Kraken还不支持svg，所以用字体来渲染图标

图标使用

* https://feathericons.com ( size 20 ; stroke width 1.5 )
* https://iconpark.oceanengine.com 字节跳动IconPark图标库

有些svg不太能转换为字体，可用 https://iconly.io/tools/svg-convert-stroke-to-fill 预处理下。

https://iconfont.cn 上，项目设置Font Family可以定义字体的名字。

下载后安装.ttf到本机。

应用打包可以参考 [flutter使用自定义字体](https://flutter.cn/docs/cookbook/design/fonts)，flutter只支持ttf的字体。




# 集成vite到实际应用

kraken: ^0.8.4 需要 flutter 2.2.3

mac这样安装老版本的flutter

```
wget https://raw.githubusercontent.com/Homebrew/homebrew-cask/71d00aa6e43d3227cdf6c9bed9538472f2ea0e05/Casks/flutter.rb
brew install flutter.rb
```

创新项目

```
flutter create -i swift -a kotlin rmw_link
```

然后如下，可以生成新的 macos 、windows 、linux 工程

```
flutter config --enable-macos-desktop
flutter config --enable-linux-desktop
flutter config --enable-windows-desktop
flutter create .
```

更多启用flutter桌面端的细节可以参考 https://flutter.dev/desktop

## 生成安卓应用

### 纯命令行下生成apk

研究纯命令行下打包是为了方便将来ci上进行自动打包

mac 这样安装

```
brew install --cask temurin11
brew install android-platform-tools android-commandlinetools
```

看一下最新版的sdk版本号
```
sdkmanager --list|rg platforms
```

运行 `yes | sdkmanager --licenses`

安装
```
sdkmanager "platform-tools" "platforms;android-31"
ln -s /usr/local/share/android-commandlinetools/platform-tools/adb /usr/local/bin/adb
```

编辑 `~/.bash_alias`
```
export ANDROID_HOME=$(brew --prefix)/share/android-commandlinetools
```

编辑 `android/gradle/wrapper/gradle-wrapper.properties`

修改 `gradle-6.9-all.zip` → `gradle-7.2-all.zip`

### android-studio 方式

```
brew install --cask android-studio
```

编辑 `.bash_alias`

```
export ANDROID_HOME=$HOME/Library/Android/sdk
```

然后

```
source ~/.bash_alias
```

然后

[Tools -> SDK Manager -> SDK Tools. 安装 Google Play Licensing Library](https://stackoverflow.com/a/65372165/2030331)

### 无线连接小米手机

先在开发者选项中启用无线调试，然后选择使用配对码配对。

然后运行 `adb pair ip:端口`。

注意：**pair的端口和connect的端口不一样**

输入验证码

然后，`adb connect ip:端口` 即可

`adb devices -l` 和 `flutter devices` 可以看到已经连接的设备

## mac 桌面版本打包

需要 cocoapods

`brew install cocoapods `

编辑 macos/Runner/Release.entitlements 和 macos/Runner/DebugProfile.entitlements  加上

```
<key>com.apple.security.network.server</key>
<true/>
<key>com.apple.security.network.client</key>
<true/>
```

支持网络请求


## 修改本地化应用名称

参考以下文档

[【Flutter】修改图标、应用名称、包名等](https://www.jianshu.com/p/8488b334926d)

[Android开发之本地化显示应用名称](https://jingyan.baidu.com/article/0a52e3f4338477bf62ed72e4.html)

Android 语言环境语言代码可以参见 https://android.googlesource.com/platform/packages/apps/Settings/+/master/res/



## flutter 热重载

在命令行输入r
