
#cd ..
#project_name=`find . -name *.xcodeproj | awk -F "[/.]" '{print $(NF-1)}'`
#cd xcode_setting


downLoadPath=$1
upLoadPath=$2





loginKeyChainPath="/Users/pdmi/Library/Keychains/login.keychain"

#pbxprojPath="../$project_name.xcodeproj/project.pbxproj"







#解锁钥匙串
echo "请输入钥匙串密码"
read parameter
sleep 0.5
keyChainPassword="$parameter"
security unlock-keychain -p $keyChainPassword $loginKeyChainPath


##替换icon文件
#cp -r $iconPath $appIconPath
#
##替换launch 文件
#
#cp -r $launchPath  $appLaunchPath


#
##将签名文件写入plist文件
#security cms -D -i "$certPath/$provisionName" >"$certPath/NewsProvision.plist"
#sleep 1.0
#
##将证书文件名称写入文件用于解析
#openssl pkcs12 -in "$certPath/$certName" -nodes -passin pass:123 |openssl x509 -noout -subject > "$certPath/certificate.txt"
#sleep 1.0

#将plist文件写入debug.json release.json
python setConfig.py $downLoadPath  $upLoadPath


## 将debug.json release.json 写入 工程 config 文件
#python xcode_auto_configurator.py $pbxprojPath



#echo $jsonPath
##app  配置信息
#bundleVerison=$(cat $jsonPath |sed 's/\"//g' |awk -F"[:,]" '/version/{print$2}')
#appName=$(cat $jsonPath |sed 's/\"//g' |awk -F"[:,]" '/defaultColumn/{print$2}')
#
#echo $appName
#/usr/libexec/PlistBuddy -c "Set :CFBundleName $appName" "$info_plist_path"
#/usr/libexec/PlistBuddy -c "Set :CFBundleDisplayName $appName" "$info_plist_path"
#


#
##解锁钥匙串
#
#keyChainPassword=$(cat  version.txt |sed 's/\"//g' |awk -F"[:,]" '/version/{print$2}')
#
#
##echo $keyChainPassword
#
#security unlock-keychain -p $keyChainPassword "/Users/pdmi/Library/Keychains/login.keychain"
#
##echo security unlock-keychain -p $keyChainPassword "/Users/pdmi/Library/Keychains/login.keychain"
#




#
##导入证书
#echo "请输入证书密码"
#read parameter
#sleep 0.5
#certificatePassword="$parameter"
#
#security import "$certPath/$certName" -k $loginKeyChainPath -P $certificatePassword –A




#更改info.plist bundleName,bundleVersion, bundleId

#/usr/libexec/PlistBuddy -c "Set :CFBundleDisplayName 测试" "$info_plist_path"
#/usr/libexec/PlistBuddy -c "Set :CFBundleName 测试" "$info_plist_path"
#/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $version" "$info_plist_path"
#/usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier $version" "$info_plist_path"

#更改info.plist 分享文件
#/usr/libexec/PlistBuddy -c "Set :CFBundleURLTypes:0:CFBundleURLSchemes:0 wxfaf533ad431302a5" "$info_plist_path"


#cd ../Shell
#
#sh build.sh Release


#security delete-certificate -c "$2" ~/Library/Keychains/login.keychain
