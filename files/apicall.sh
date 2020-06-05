#!/bin/bash
export LANG=c

host="iaas.ap-seoul-1.oraclecloud.com"

# Get Instance List
#targetApi="/20160918/instances"
#targetURL="$targetApi?compartmentId=ocid1.compartment.oc1..aaaaaaaae2qsdvkc445vjwam54hj6jes2ancvefcnqzoyd57rlmskzv3tenq"

# Get Bucket List
namespaceName="apackrsct01"
targetApi="/n/$namespaceName/b/"
targetURL="$targetApi?compartmentId=ocid1.compartment.oc1..aaaaaaaae2qsdvkc445vjwam54hj6jes2ancvefcnqzoyd57rlmskzv3tenq"
tenancyOCID=ocid1.tenancy.oc1..aaaaaaaa6ma7kq3bsif76uzqidv22cajs3fpesgpqmmsgxihlbcemkklrsqa
userOCID=ocid1.user.oc1..aaaaaaaajjy57b55ocddvsonkjvyptnleyul236m3u4wxyw5lr53xsy3rvya
keyFingerprint=48:1a:98:8c:cd:f6:63:4b:fb:4d:8d:26:44:aa:37:f6
ocidKeyId=$tenancyOCID/$userOCID/$keyFingerprint
curDate=$(date -u +'%a, %d %b %Y %H:%M:%S %Z')
printf $curDate

privateKeyPath="/Users/wyatt/SSH/oci/oci_api_key.pem";
date_header="date: "$curDate
host_header="host: "$host 
request_target="(request-target): get "$targetURL
signing_string="$request_target\n$date_header\n$host_header"
printf '%b' "signing string is $signing_string \n"
printf '%b' "signed request is \n"
printf '%b' "$signing_string" | openssl dgst -sha256 -sign $privateKeyPath | openssl enc -e -base64 | tr -d '\n'
printf "\n\n"

signedstr=$(printf '%b' "$signing_string" | openssl dgst -sha256 -sign $privateKeyPath | openssl enc -e -base64 | tr -d '\n') 
printf $signedstr"\n"

curl -v -X GET -sS https://$host$targetURL -H "$date_header" -H "Authorization: Signature version=\"1\",keyId=\"$ocidKeyId\",algorithm=\"rsa-sha256\",headers=\"(request-target) date host\",signature=\"$signedstr\""
