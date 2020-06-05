
# Python SDK 사용하기
Python SDK를 사용하는 과정을 수행해 봅니다.
본 Lab에서는 간단한 Sample을 테스트 해봅니다. 보다 자세한 설명은 아래의 링크를 참조 하시기 바랍니다.

https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/en/latest/installation.html#set-up-a-virtual-environment

## Python SDK 설치 
Python 3.5 or 3.6 필요합니다.
1. [Python 설치](https://wiki.python.org/moin/BeginnersGuide/Download)
1. virtual env 설치
	
    python이 정상적으로 설치된 경우 아래의 명령어를 실행해서 가상환경을 만듭니다.
    pip install virtualenv
    
2. virtualenv oci_sdk_env

    source oci_sdk_env/bin/activate

3. pypi 설치

    pip install oci

4. SSL 버전 확인

    python -c "import ssl; print(ssl.OPENSSL_VERSION)"

    * 1.0.1 보다 낮은 경우 다음 실행합니다.
    - pip install requests[security]==2.18.4 

## 예제 다운로드 후 실행

아래 예제는 object storage에 python-sdk-example-bucket 이라는 이름으로 bucket 을 생성하고 파일을 하나 생성해서 upload 후 download까지 하는 예제입니다. 실행 후에는 object storage에 있는 bucket과 파일을 삭제합니다.

[python object_crud.py](https://github.com/oracle/oci-python-sdk/blob/master/examples/object_crud.py)

#### 소스 변경 필요한 부분

위 예제들은 tenancy id와 compartment_id를 동일한 경우에 해당 하는 예제이므로 이 부분을 확인 하여 다음과 같이 변경 하시기 바랍니다.
```
compartment_id = config["tenancy”] —> compartment_id ='ocid1.compartment.oc1..XXXX’
```

위 예제는 oci와 동일한 방식으로 config 파일의 위치가 default 위치에 있다고 가정합니다.


## 대용량 전송 테스트 
동일한 방식이나 아래 예제는 대용량을 전송을 위한 예제

https://github.com/oracle/oci-python-sdk/blob/master/examples/multipart_object_upload.py

---
이 과정을 완료하셨습니다.