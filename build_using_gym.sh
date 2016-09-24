#!/bin/bash

#计时
SECONDS=0

#假设脚本放置在与项目相同的路径下
project_path=$(pwd)
#取当前时间字符串添加到文件结尾
now=$(date +"%Y_%m_%d_%H_%M_%S")

#指定项目的scheme名称
scheme="boxster"
#指定要打包的配置名
configuration="Release"
#指定打包所使用的输出方式，目前支持app-store, package, ad-hoc, enterprise, development, 和developer-id，即xcodebuild的method参数
export_method='ad-hoc'

#指定项目地址
workspace_path="$project_path/boxster.xcworkspace"
#指定输出路径
output_path="/Users/huang/Documents/output_path"
#指定输出归档文件地址
archive_path="$output_path/boxster_${now}.xcarchive"
#指定输出ipa地址
ipa_path="$output_path/boxster_${now}.ipa"
#指定输出ipa名称
ipa_name="boxster_${now}.ipa"
#获取执行命令时的commit message
commit_msg="$1"

#输出设定的变量值
echo "===workspace path: ${workspace_path}==="
echo "===archive path: ${archive_path}==="
echo "===ipa path: ${ipa_path}==="
echo "===export method: ${export_method}==="
echo "===commit msg: $1==="
pod update --verbose --no-repo-update
#先清空前一次build
gym --workspace ${workspace_path} --scheme ${scheme} --clean --configuration ${configuration} --archive_path ${archive_path} --export_method ${export_method} --output_directory ${output_path} --output_name ${ipa_name} --use_legacy_build_api


#输出总用时
echo "===Finished. Total time: ${SECONDS}s==="

#蒲公英上的User Key
uKey="4c1fae6816ae743b2fa3debfdf4ebeaf"
#蒲公英上的API Key
apiKey="831beb159d6908f453c21c59b8b68c47"
#要上传的ipa文件路径
IPA_PATH="/Users/huang/Documents/output_path/${ipa_name}"

rm -rf boxster_$(date +"%Y_%m_%d_%H_%M_%S").ipa

#执行上传至蒲公英的命令
echo "++++++++++++++upload+++++++++++++"
curl -F "file=@${IPA_PATH}" -F "uKey=${uKey}" -F "_api_key=${apiKey}" http://www.pgyer.com/apiv1/app/upload
