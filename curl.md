# Curl을 사용해 호출하기

1. curl 설치 및 다운로드
윈도우의 경우 아래의 주소에서 다운로드 받습니다.
https://curl.haxx.se/download.html

mac의 경우 package manager인 brew를 사용해서 설치합니다.
mac : brew install curl
linux : sudo apt-get install curl

1. apicall.sh 호출
미리 준비된 shell script를 이용해 curl로 호출을 해봅니다.

[apicall.sh](./files/apicall.sh) 를 다운로드 받습니다.

<수정이 필요한 부분>
targetApi="/20160918/instances" (이전 Page의 모니터링 URL을 참조하여 수정)
targetURL="$targetApi?compartmentId=ocid1.compartment.oc1..aaaaaaaazkc77in3r w4rghnz7ipxqtvnlvr32hsjmhupuooxmuzmhrnlflxa" (이전 Page의 URL을 참조하여 수정)
privateKeyPath="/Users/wj/SSH/oci/oci_api_key.pem"; (파일이 저장된 위치로 수정)

다른 계정을 사용할 시에는 아래 부분도 수정을 해야 함 Host, tenancyOCID, userOCID, keyFingerprint 의 값도 수정해야 함.
