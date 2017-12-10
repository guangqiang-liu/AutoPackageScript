#!/bin/sh

#  autoPackage.sh
#  CRM
#
#  Created by 刘光强 on 2017/6/19.
#  Copyright © 2017年 Facebook. All rights reserved.

#  ******************** 安卓一键式打包并上传到fir生成二维码并直接扫描安装 ********************

# 预先定义对应的环境变量
envionmentVariables(){

# 打包时间初始值
SECONDS=0
# 当前的路径
pwd
#安卓项目工程路径
android_project_path=$(pwd)
# 安卓apk目录路径
apk_dir_path="$android_project_path/app/build/outputs/apk"
# apk 路径
apk_path="$apk_dir_path/app-dev-release.apk"
# fir账户的token,这个token换成自己fir账号生成的token即可
firim_token="1b91e3f54c6e6b106be7afdd13674a43"
}

apkBuild(){

# 删除老的apk
rm -rf $apk_path
cd "$android_project_path"
echo "\033[37;45m打包开始！！！ 🎉  🎉  🎉   \033[0m"
sleep 1
# 执行安卓打包脚本
./gradlew assembleRelease
# 检查apk文件（app-LSW-release.apk）是否存在
if [ -f "$apk_path" ]; then
echo "$apk_path"
echo "\033[37;45m打包成功 🎉  🎉  🎉   \033[0m"
sleep 1
else
echo "\033[37;45m没有找到对应的apk文件 😢 😢 😢   \033[0m"
exit 1
fi
}

# 预览apk信息
previewIPAInfo(){
echo "\033[37;43m*************************  step4:预览apk信息 💩 💩 💩  *************************  \033[0m"
fir info $apk_path
sleep 1
}

# 将apk目录下的app-LSW-release.apk 上传到fir
publishIPAToFir(){

echo "\033[37;43m*************************  step5:上传中 🚀 🚀 🚀  *************************  \033[0m"
echo "\033[37;43m*************************  step4:预览用户登录信息 💩 💩 💩  *************************  \033[0m"
fir login "$firim_token"
fir publish $apk_path -Q
echo "\033[37;43m*************************  step6:上传完成 🚀 🚀 🚀  *************************  \033[0m"
# 输出总用时
echo "\033[37;46m总用时: ${SECONDS}s 👄 👄 👄 \033[0m"
open $apk_dir_path
}

envionmentVariables
apkBuild
previewIPAInfo
publishIPAToFir
