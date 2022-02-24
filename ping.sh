#!/bin/bash

#判断第一个参数是否是文件，不是则退出
if [[ -f $1 ]];then
    do_name=(`cat $1`)
else
    echo "$1文件不存在"
    exit 1
fi
#设置ping的包个数
package_num=2

echo -e "解析地址\t\t域名">>res_ok.txt
echo "域名">>res_error.txt

#循环ping文件中的域名,并记录结果
for name in ${do_name[*]}
do 
    ip=`ping -c $package_num $name | awk -F "[()]" 'NR==1{print $2}'`
    if [ "$ip" != "" ];then
            echo -e "$ip\t\t$name">>res_ok.txt
    else
            echo "$name">>res_error.txt
    fi
done
