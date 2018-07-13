#!/bin/sh
# 使用方法
# step 1. 复制脚本，新建shell文件，将其复制进去，然后相关参数改一下，复制保存为build.sh，终端运行chmod +x build.sh；
# step 2. 下载附件中的文件，将build.sh和附件中的文件，放在一起，新建文件夹为Shell，将这几文件复制进去，然后复制Shell文件夹到工程的根目录；
# step 3. 终端cd到工程目录，执行脚本 格式为 sh build.sh Debug
# step 4. Enjoy it!!
# 计时
SECONDS=0
# 是否编译工作空间 (例:若是用Cocopods管理的.xcworkspace项目,赋值true; 用Xcode默认创建的.xcodeproj, 赋值false)
is_workspace="true"
# 指定项目的scheme名称
scheme_name="News"
# 工程中Target对应的配置plist文件名称, Xcode默认的配置文件为Info.plist
info_plist_name="Info"
# 指定要打包编译的方式 : Release,Debug...
build_configuration=$1

# 是否上传FIR，默认是不上传Fir
UPLOADFIR=true

echo "\n\033[32;1m************************* 您选择了 $build_configuration 模式 ************************* \033[0m\n"

# ===============================自动打包部分============================= #

# 导出ipa所需要的plist文件路径 (默认为AdHocExportOptionsPlist.plist)
ExportOptionsPlistPath="./shell/AdHocExportOptionsPlist.plist"
# 返回上一级目录,进入项目工程目录
cd ..
# 获取项目名称
project_name=`find . -name *.xcodeproj | awk -F "[/.]" '{print $(NF-1)}'`
# 获取版本号,内部版本号,bundleID
info_plist_path="$project_name/$info_plist_name.plist"
bundle_version=`/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" $info_plist_path`
bundle_build_version=`/usr/libexec/PlistBuddy -c "Print CFBundleVersion"  $info_plist_path`
bundle_identifier=`/usr/libexec/PlistBuddy -c "Print CFBundleIdentifier" $info_plist_path`

# 强制删除旧的文件夹
rm -rf ./$scheme_name-IPA
# 指定输出ipa路径
export_path=./$scheme_name-IPA
# 指定输出归档文件地址
export_archive_path="$export_path/$scheme_name.xcarchive"
# 指定输出ipa地址
export_ipa_path="$export_path"
# 指定输出ipa名称 : scheme_name + bundle_version
suffix=`date +"%m%d%H%M"`
ipa_name="$scheme_name-v$bundle_version-$suffix"
version="$bundle_version.$suffix"
#/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $version" "$info_plist_path"

## certifcate
#CODE_SIGN_DISTRIBUTION="iPhone Distribution: People's Daily Media Innovation Co.,Ltd."
#CODE_SIGN_DEVELOPMENT="iPhone Developer: xxxx xxxx (5FN6xxxx2V)"
#
#Code_PROVISIONING_PROFILE="ca0f1b78-db50-4f51-af93-c6e0d4e3bce3"


## AdHoc, AppStore, Enterprise三种打包方式的区别: http://blog.csdn.net/lwjok2007/article/details/46379945
#echo "\033[36;1m请选择打包方式(输入序号, 按回车即可) \033[0m"
#echo "\033[33;1m1. AdHoc \033[0m"
#echo "\033[33;1m2. AppStore \033[0m"
#echo "\033[33;1m3. Enterprise \033[0m"
#echo "\033[33;1m4. Development \033[0m\n"
## 读取用户输入并存到变量里
#read parameter
#sleep 0.5
#method="$parameter"

method=$2
# 判读用户是否有输入
if test -n "$method"
then
if test "$method" = "1" ; then
ExportOptionsPlistPath="./shell/AdHocExportOptionsPlist.plist"
elif [ "$method" = "2" ]; then
ExportOptionsPlistPath="./shell/AppStoreExportOptionsPlist.plist"
elif [ "$method" = "3" ]; then
ExportOptionsPlistPath="./shell/EnterpriseExportOptionsPlist.plist"
elif [ "$method" = "4" ]; then
ExportOptionsPlistPath="./shell/DevelopmentExportOptionsPlist.plist"
else
echo "\n\033[31;1m************************* 您输入的参数无效!!! *************************\033[0m\n"
exit 1
fi
else
UPLOADFIR=false
fi



echo "\033[32m************************* 开始构建项目 ************************* \033[0m\n"
# 指定输出文件目录不存在则创建
if test -d "$export_path" ; then
echo $export_path
else
mkdir -pv $export_path
fi

if $is_workspace ; then
echo "\n\033[32m************************* 开始pod ************************* \033[0m"
pod install --verbose --no-repo-update
echo "\033[32m************************* pod完成 ************************* \033[0m\n"

if test $build_configuration = "Debug" ; then
echo "\n\033[32;1m************************* 您选择了以 xcworkspace-Debug 模式打包 *************************\033[0m"
# step 1. Clean
xcodebuild clean -workspace $project_name.xcworkspace -scheme $scheme_name -configuration $build_configuration -alltargets
# step 2. Build
#xcodebuild -workspace $project_name.xcworkspace -scheme $scheme_name -sdk iphoneos -configuration $build_configuration CODE_SIGN_IDENTITY="${CODE_SIGN_DISTRIBUTION}"
xcodebuild -workspace $project_name.xcworkspace -scheme $scheme_name -sdk iphoneos -configuration $build_configuration
# step 3. Archive
xcodebuild archive -workspace $project_name.xcworkspace -scheme $scheme_name -configuration $build_configuration -archivePath $export_archive_path
elif [ $build_configuration = "Release" ]; then
echo "\n\033[32;1m************************* 您选择了以 xcworkspace-Release 模式打包 *************************\033[0m"
# step 1. Clean
xcodebuild clean -workspace $project_name.xcworkspace -scheme $scheme_name -configuration $build_configuration -alltargets
# step 2. Build
#xcodebuild -workspace $project_name.xcworkspace -scheme $scheme_name -sdk iphoneos -configuration $build_configuration CODE_SIGN_IDENTITY="$CODE_SIGN_DISTRIBUTION" PROVISIONING_PROFILE="$Code_PROVISIONING_PROFILE"
xcodebuild -workspace $project_name.xcworkspace -scheme $scheme_name -sdk iphoneos -configuration $build_configuration
# step 3. Archive
xcodebuild archive -workspace $project_name.xcworkspace -scheme $scheme_name -configuration $build_configuration -archivePath $export_archive_path
else
echo "\n\033[31;1m************************* 您定义的打包方式的不正确 😢 😢 😢 *************************\033[0m\n"
echo "Usage:\n"
echo "sh build.sh Debug"
echo "sh build.sh Release"
exit 1
fi
else
if test $build_configuration = "Debug" ; then
echo "\n\033[32;1m************************* 您选择了以 xcodeproj-Debug 模式打包 *************************\033[0m"
# step 1. Clean
xcodebuild clean -project $project_name.xcodeproj -scheme $scheme_name -configuration $build_configuration -alltargets
# step 2. Build
#xcodebuild -project $project_name.xcodeproj -scheme $scheme_name -sdk iphoneos -configuration $build_configuration CODE_SIGN_IDENTITY="${CODE_SIGN_DISTRIBUTION}"
xcodebuild -project $project_name.xcodeproj -scheme $scheme_name -sdk iphoneos -configuration $build_configuration
# step 3. Archive
xcodebuild archive -project $project_name.xcodeproj -scheme $scheme_name -configuration $build_configuration -archivePath $export_archive_path
elif [ $build_configuration = "Release" ]; then
echo "\n\033[32;1m************************* 您选择了以 xcodeproj-Release 模式打包 *************************\033[0m"
# step 1. Clean
xcodebuild clean -project $project_name.xcodeproj -scheme $scheme_name -configuration $build_configuration -alltargets
# step 2. Build
#xcodebuild -project $project_name.xcodeproj -scheme $scheme_name -sdk iphoneos -configuration $build_configuration CODE_SIGN_IDENTITY="${CODE_SIGN_DISTRIBUTION}"
xcodebuild -project $project_name.xcodeproj -scheme $scheme_name -sdk iphoneos -configuration $build_configuration
# step 3. Archive
xcodebuild archive -project $project_name.xcodeproj -scheme $scheme_name -configuration $build_configuration -archivePath $export_archive_path
else
echo "\n\033[31;1m************************* 您定义的打包方式的不正确 😢 😢 😢 *************************\033[0m\n"
echo "Usage:\n"
echo "sh build.sh Debug"
echo "sh build.sh Release"
exit 1
fi
fi

# 检查是否构建成功
# xcarchive 实际是一个文件夹不是一个文件所以使用 -d 判断
if test -d "$export_archive_path" ; then
echo "\n\033[32;1m************************* 项目构建成功 🚀 🚀 🚀 *************************\033[0m\n"
else
echo "\n\033[31;1m************************* 项目构建失败 😢 😢 😢 *************************\033[0m\n"
exit 1
fi

echo "\033[32m************************* 开始导出ipa文件 ************************* \033[0m"
xcodebuild -exportArchive -archivePath $export_archive_path -exportPath $export_ipa_path -exportOptionsPlist $ExportOptionsPlistPath
# 修改ipa文件名称
mv $export_ipa_path/$scheme_name.ipa $export_ipa_path/$ipa_name.ipa

# 检查文件是否存在
if test -f "$export_ipa_path/$ipa_name.ipa" ; then
echo "\n\033[32;1m************************* 导出 $ipa_name.ipa 包成功 🎉 🎉 🎉 *************************\033[0m\n"
## 选择用fir或者是pgyer上传
#echo "\033[36;1m请选择ipa测试发布平台(输入序号, 按回车即可) \033[0m"
#echo "\033[33;1m1. fir \033[0m"
#echo "\033[33;1m2. pgyer \033[0m"
#echo "\033[33;1m3. fir and pgyer \033[0m\n"
#
## 读取用户输入并存到变量里
#read parameter
#sleep 0.5
#uploadType="$parameter"
#
#if test -n "$uploadType"
#then
#if test "$uploadType" = "1" ; then
## 登录fir，此处将APIToken换成自己申请的APIToken
#fir login -T 396exxxxb4b88b012474fcc7c0e1xxxx
## 发布
#fir publish "$export_ipa_path/$ipa_name.ipa"
#echo "\n\033[32;1m************************* 上传 $ipa_name.ipa 包 到 fir 成功 🎉 🎉 🎉 *************************\033[0m\n"
#elif [ "$uploadType" = "2" ]; then
#curl -F "file=@$export_ipa_path/$ipa_name.ipa" \
#-F "uKey=68413ffb92d28a126729c6537aa0bbdb" \
#-F "_api_key=215930df29d28b3b383ce3b45db95d7c"\
#-F "publishRange=2" \
#"http://www.pgyer.com/apiv1/app/upload"
#echo "\n\033[32;1m************************* 上传 $ipa_name.ipa 包 到 pgyer 成功 🎉 🎉 🎉 *************************\033[0m\n"
#elif [ "$uploadType" = "3" ]; then
#fir publish "$export_ipa_path/$ipa_name.ipa"
#echo "\n\033[32;1m************************* 上传 $ipa_name.ipa 包 到 fir 成功 🎉 🎉 🎉 *************************\033[0m\n"
#
#curl -F "file=@$export_ipa_path/$ipa_name.ipa" \
#-F "uKey=6841xxxx92d28a126729c6537aa0xxxx" \
#-F "_api_key=2159xxxx29d28b3b383ce3b45db9xxxx"\
#-F "publishRange=2" \
#"http://www.pgyer.com/apiv1/app/upload"
#echo "\n\033[32;1m************************* 上传 $ipa_name.ipa 包 到 pgyer 成功 🎉 🎉 🎉 *************************\033[0m\n"
#else
#echo "\n\033[31;1m************************* 您输入的参数无效!!! *************************\033[0m\n"
#exit 1
#fi

  open $export_path

#fi

else
  echo "\n\033[31;1m************************* 导出 $ipa_name.ipa 包失败 😢 😢 😢 *************************\033[0m\n"
exit 1
fi

# 输出打包总用时
echo "\033[36;1m************************* 使用Shell脚本打包总用时: ${SECONDS}s *************************\033[0m\n"


