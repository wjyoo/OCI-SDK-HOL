# OCI Java SDK 사용하기

## JDK 에 권한 설정

### JDK Security Manager 권한 수정
OCI SDK를 사용하기 위해서는 기존의 환경에 있는 JDK에 대하여 권한을 설정해야 합니다.
아래 파일을 수정해서 권한을 변경합니다.

java.home/lib/security/java.policy  (Solaris, Linux, or Mac OS X)
java.home\lib\security\java.policy  (Windows)

https://docs.oracle.com/javase/8/docs/technotes/guides/security/PolicyFiles.html

```
grant {
    permission java.lang.RuntimePermission "getClassLoader";
    permission java.lang.reflect.ReflectPermission "suppressAccessChecks";
    permission java.lang.RuntimePermission "accessDeclaredMembers";
    permission java.util.PropertyPermission "*", "read,write";
    permission java.lang.RuntimePermission "setFactory";

    permission java.util.PropertyPermission "sun.net.http.allowRestrictedHeaders", "write";
    permission java.net.SocketPermission "*", "connect";
};
```
## SDK 다운로드

SDK는 두가지 방식으로 사용이 가능합니다. 
직접 SDK library 파일을 다운로드 받거나, Maven repository에서 다운로드 받으실 수 있습니다.
아래의 다운로드 주소에서 최신버전의 oci-java-sdk.zip 을 다운로드 받습니다.

https://github.com/oracle/oci-java-sdk/releases

여기에서는 직접 다운로드 방식으로 설명 드립니다.

Maven을 사용하시는 경우 pom.xml 파일은 다음과 같습니다. 

```
    <dependencyManagement>
        <dependencies>
          <dependency>
            <groupId>com.oracle.oci.sdk</groupId>
            <artifactId>oci-java-sdk-bom</artifactId>
            <!-- replace the version below with your required version -->
            <version>1.5.2</version>
            <type>pom</type>
            <scope>import</scope>
          </dependency>
        </dependencies>
      </dependencyManagement>
      <dependencies>
      <dependency>
        <groupId>com.oracle.oci.sdk</groupId>
        <artifactId>oci-java-sdk-audit</artifactId>
      </dependency>
      <dependency>
        <groupId>com.oracle.oci.sdk</groupId>
        <artifactId>oci-java-sdk-core</artifactId>
      </dependency>
      <dependency>
        <groupId>com.oracle.oci.sdk</groupId>
        <artifactId>oci-java-sdk-database</artifactId>
      </dependency>
```

## OCI 파일 설정
- 다운받은 SDK를 적절한 폴더에 압축을 풉니다.
- Home directory에 ~/.oci/config 폴더와 파일을 생성합니다.
- config 파일에는 아래의 내용을 계정 정보에 맞게 넣으시면 됩니다.

    ```
        [DEFAULT]
        user=ocid1.user.oc1..aaaaaaaajjy57b55ocddvsonkjvyptnleyul236m3u4wxyw5lr53xsy3rvya
        fingerprint=48:1a:98:8c:cd:f6:63:4b:fb:4d:8d:26:44:aa:37:f6
        key_file=/Users/user1/SSH/oci/oci_api_key.pem
        tenancy=ocid1.tenancy.oc1..aaaaaaaa6ma7kq3bsif76uzqidv22cajs3fpesgpqmmsgxihlbcemkklrsqa
        region=us-ashburn-1
    ```

위 내용에 대한 자세한 설명은 아래의 링크에서 확인하실 수 있습니다.

http://taewan.kim/oci_docs/98_misc_tips/how_to_collect_basic_info_of_oci/

key_file은 SSH 통신을 위한 private key와 public key를 생성하셔야 합니다.

https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Tasks/creatingkeys.htm


## SDK에 포함된 Example로 테스트 해보기
다운받은 SDK 폴더에 examples라는 폴더가 있습니다. 그 안에 많은 예제들이 있으니 소스 코드를 참고하면 됩니다.
 그 중에서 간단한 Sample로 SDK 환경 설정이 잘 되었는지 확인 합니다.

1. Example 소스를 수정합니다.

    ```
    public class ObjectStorageGetNamespaceExample {
        public static void main(String[] args) throws Exception {
            objectStorageClient.setRegion(Region.US_ASHBURN_1);        --> objectStorageClient.setRegion(Region.AP_SEOUL_1); //서울 리전의 경우: 
    ```
리전 정보는 아래에서 확인하실 수 있습니다.
https://docs.cloud.oracle.com/en-us/iaas/tools/java/1.17.1/com/oracle/bmc/Region.html

1. example을 compile 후 실행해 봅니다.

    #### 컴파일
  
    javac -cp lib/oci-java-sdk-full-<version>.jar:third-party/lib/* examples/ObjectStorageGetNamespaceExample.java
    
    예) javac -cp $(echo third-party/lib/*.jar |tr ' ' ':' ):examples:lib/oci-java-sdk-full-1.17.1.jar examples/ObjectStorageGetNamespaceExample.java

    #### 실행

    java -cp examples:lib/oci-java-sdk-full-<version>.jar:third-party/lib/* ObjectStorageGetNamespaceExample [compartment ocid]

* classpath에 third-party/lib안의 모든 jar파일을 클래스패스에 추가하셔야 합니다.
* Compartment ocid는 다음의 링크에서 확인하실 수 있습니다.  http://taewan.kim/oci_docs/98_misc_tips/how_to_collect_basic_info_of_oci/#compartment-ocid 

* mac에서 실행한 경우:

    java -classpath $(echo third-party/lib/*.jar |tr ' ' ':' ):examples:lib/oci-java-sdk-full-1.17.1.jar ObjectStorageGetNamespaceExample ocid1.compartment.oc1..aaaaaaaae2qsdvkc445……

## 기타 참고 사항
JDK11 사용시에는 JaxB dependency로 library를 별도로 추가하셔야 합니다.
javax.activation:javax.activation-api:1.2.0

기타 자세한 내용은 아래의 링크에서 확인하실 수 있습니다.

https://docs.cloud.oracle.com/en-us/iaas/Content/API/SDKDocs/javasdkgettingstarted.htm 
https://docs.cloud.oracle.com/en-us/iaas/Content/API/SDKDocs/javasdkconcepts.htm
https://docs.cloud.oracle.com/en-us/iaas/Content/API/SDKDocs/javasdkexamples.htm
https://docs.cloud.oracle.com/en-us/iaas/tools/java/1.17.1/

