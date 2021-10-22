启用flutter桌面请参考

https://flutter.dev/desktop

kraken: ^0.9.0-rc.2 需要 flutter 2.2.3

mac这样安装老版本的flutter

```
wget https://raw.githubusercontent.com/Homebrew/homebrew-cask/71d00aa6e43d3227cdf6c9bed9538472f2ea0e05/Casks/flutter.rb
brew install flutter.rb
```

```
flutter create .
```

可以生成新的 macos 、windows 、linux 工程

## 安卓调试

在安卓调试需要安装java和cocoapods

mac 这样安装 `brew install oracle-jdk android-sdk`

编辑 `android/gradle/wrapper/gradle-wrapper.properties`

修改 `gradle-6.9-all.zip` → `gradle-7.2-all.zip`

### 无线连接小米手机

先在开发者选项中启用无线调试，然后选择使用配对码配对。

然后运行 `adb pair ip:端口`。

注意：**pair的端口和connect的端口不一样**

输入验证码

然后，`adb connect ip:端口` 即可

`adb devices -l` 和 `flutter devices` 可以看到已经连接的设备

## macos 调试

`brew install cocoapods `

编辑 macos/Runner/Release.entitlements 和 macos/Runner/DebugProfile.entitlements  加上

```
<key>com.apple.security.network.server</key>
<true/>
<key>com.apple.security.network.client</key>
<true/>
```

支持网络请求

