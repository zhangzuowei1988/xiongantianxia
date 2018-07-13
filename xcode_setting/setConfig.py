
import json
import os
import os.path
import shutil

import urllib
import urllib2
import zipfile

import sys

from biplist import *

url="https://github.com/AFNetworking/AFNetworking/archive/master.zip"

buildPath="./ios_1.0.0"
certPath =buildPath+"/file/"
certName="product_package_cert.p12"
buildJsonPath=buildPath+"/build.json"

configJsonPath=buildPath+"/config-version.json"

provisionName = "product_sign.mobileprovision"
userprovisionPath = "/Users/pdmi/Library/MobileDevice/Provisioning Profiles"

info_plist_path="../News/Info.plist"

loginKeyChainPath="/Users/pdmi/Library/Keychains/login.keychain"

iconPath=buildPath+"/image/icon/."
appIconPath="../News/Assets.xcassets/AppIcon.appiconset"
launchPath=buildPath+"/image/launch/."
appLaunchPath="../News/Image/launch"

splanchPath=buildPath+"/image/splash/."
appSplanchPath="../News/configure/splash"

appbuildJsonPath="../News/configure/build.json"
appconfigJsonPath="../News/configure/config-version.json"

pbxprojPath="../News.xcodeproj/project.pbxproj"

downLoadUrl=""
upLoadUrl=""
if __name__ == '__main__':
     for i in range(0,len(sys.argv)):
         if (i == 0):
             downLoadUrl=sys.argv[0]
         elif (i == 1):
              upLoadUrl=sys.argv[1]


print(downLoadUrl)
print(upLoadUrl)

#sys.exit(0)
#downLoad
#f = urllib2.urlopen(url)
#data = f.read()
#with open("demo2.zip", "wb") as code:
#    code.write(data)
#
#zipFile = zipfile.ZipFile(os.path.join(os.getcwd(), 'demo2.zip'))
#for file in zipFile.namelist():
#    zipFile.extract(file, r'.')
#zipFile.close()


def load(filePath):
    f = open(filePath)
    setting = json.load(f)
    return setting

def store(data,filePath):
    with open(filePath, "w") as json_file:
        json_file.write(json.dumps(data))








buildJson=load(buildJsonPath)


# provision-> plist
os.system('security cms -D -i '+certPath+provisionName  +' > ' +certPath +"/NewsProvision.plist")
#cert->txt
os.system('openssl pkcs12 -in '+certPath+certName +' -nodes -passin pass:'+buildJson["packagePassword"]+ ' |openssl x509 -noout -subject > ' + certPath +"certificate.txt")

#import cert
os.system('security import '+certPath+certName+'  -k  '+loginKeyChainPath +' -P '+ buildJson["packagePassword"] + ' -A')




#delete splach
os.system(' rm -rf '+appSplanchPath +'/*')
#delete json
#os.system(' rm -rf '+appbuildJsonPath)

#copy icon
os.system(' cp -r ' +iconPath+'  '+appIconPath)
#copy launch
os.system(' cp -r ' +launchPath+'  '+appLaunchPath)

#copy splach
os.system(' cp -r '+splanchPath +' '+appSplanchPath)

##copy json
os.system(' cp -r ' +buildJsonPath +' '+appbuildJsonPath)

#copy configureJson
os.system(' cp -r ' +configJsonPath +' '+appconfigJsonPath)

try:
    plist = readPlist(certPath+"/NewsProvision.plist")
    
except (InvalidPlistException, NotBinaryPlistException), e:
    print "Not a plist:", e


#appConfigure
try:
    appInfoPlist = readPlist(info_plist_path)

except (InvalidPlistException, NotBinaryPlistException), e:
    print "Not a plist:", e


file_object = open(certPath+"/certificate.txt")
try:
    
     certificateInfo = file_object.read()
     print(certificateInfo)
finally:
    file_object.close()







#appName
appInfoPlist["CFBundleDisplayName"] = buildJson["appName"]
appInfoPlist["CFBundleName"] = buildJson["appName"]
appInfoPlist["CFBundleShortVersionString"]=buildJson["version"]
appInfoPlist["CFBundleVersion"]=buildJson["version"]

#umengshare
if buildJson["weixinAppKey"].strip():
      appInfoPlist["CFBundleURLTypes"][0]["CFBundleURLSchemes"][0]=buildJson["weixinAppKey"]


if buildJson["qqAppId"].strip():
      qqid_16=hex(int(buildJson["qqAppId"]))
      qqid_16=qqid_16[2:len(qqid_16)]
      qqid_16 = str(qqid_16).zfill(8)
      appInfoPlist["CFBundleURLTypes"][1]["CFBundleURLSchemes"][0]="QQ"+qqid_16


if buildJson["sinaAppkey"].strip():
    appInfoPlist["CFBundleURLTypes"][2]["CFBundleURLSchemes"][0]="wb"+buildJson["sinaAppkey"]



if buildJson["qqAppId"].strip():
     appInfoPlist["CFBundleURLTypes"][3]["CFBundleURLSchemes"][0]="tencent"+buildJson["qqAppId"]


try:
    writePlist(appInfoPlist, info_plist_path)
except (InvalidPlistException, NotBinaryPlistException), e:
    print "Something bad happened:", e



jsonData = load("release.json")

teamId=plist["TeamIdentifier"][0]
teamIdlength=len(teamId)
bundleId=plist["Entitlements"]["application-identifier"][teamIdlength+1:]

location=certificateInfo.index('CN=')+3
location2=certificateInfo.index('/OU=')
certificateName=certificateInfo[location:location2]

print(certificateName)




jsonData["PRODUCT_BUNDLE_IDENTIFIER"]=bundleId
jsonData["PROVISIONING_PROFILE_SPECIFIER"]=plist["Name"]
jsonData["DEVELOPMENT_TEAM"]=plist["TeamIdentifier"][0]
jsonData["PROVISIONING_PROFILE"]=plist["UUID"]
jsonData["CODE_SIGN_IDENTITY"]=certificateName
#jsonData["CODE_SIGN_IDENTITY[sdk=iphoneos*]"]=plist["TeamName"]
jsonData["CODE_SIGN_IDENTITY[sdk=iphoneos*]"]=certificateName
store(jsonData,"release.json")


debugJsonData = load("debug.json")
debugJsonData["PRODUCT_BUNDLE_IDENTIFIER"]=bundleId
debugJsonData["PROVISIONING_PROFILE_SPECIFIER"]=plist["Name"]
debugJsonData["DEVELOPMENT_TEAM"]=plist["TeamIdentifier"][0]
debugJsonData["PROVISIONING_PROFILE"]=plist["UUID"]
debugJsonData["CODE_SIGN_IDENTITY"]=certificateName
#debugJsonData["CODE_SIGN_IDENTITY[sdk=iphoneos*]"]=plist["TeamName"]
debugJsonData["CODE_SIGN_IDENTITY[sdk=iphoneos*]"]=certificateName
store(debugJsonData,"debug.json")


shutil.copy(certPath +"/"+provisionName ,certPath+"/"+ plist["UUID"]+".mobileprovision");
shutil.copyfile(certPath+"/"+plist["UUID"]+".mobileprovision",userprovisionPath+'/'+plist["UUID"]+".mobileprovision")


#  os.system('cd ../Shell')

os.system('python xcode_auto_configurator.py '+pbxprojPath)

buildStr=""
if buildJson["packageType"] == "APP_STORE":
#os.system('sh ../Shell/build.sh Release 2')
    buildStr='sh ../Shell/build.sh Release 2'
elif  buildJson["packageType"] == "ENTERPRISE":
#   os.system('sh ../Shell/build.sh Release 3')
   buildStr='sh ../Shell/build.sh Release 3'

os.system(buildStr)

#p=os.popen(buildStr)
#x=p.readlines()
#for line in x:
#    print 'ssss='+line

#print(jsonData)
