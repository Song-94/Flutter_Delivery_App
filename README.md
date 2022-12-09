# flutter_delivery_app

# tips

1. misc 의미 (miscellaneous)
- 기타, 여러가지 잡다한
2. flutter_secure_storage
- https://pub.dev/packages/flutter_secure_storage
- android\app\build.gradle: minSdkVersion 18
3. unicode center dot
- ·

# Sites
1. Base64 Encoder
- https://www.base64encode.org/
2. JWT (JSON Web Tokens) decode
- https://jwt.io/

# Sever Test ID/PW
1. id              : ai
2. pw              : testtest
3. key             : authorization
4. value           : Basic test@codefactory.ai:testtest
5. Base64 encode   : dGVzdEBjb2RlZmFjdG9yeS5haTp0ZXN0dGVzdA==
6. JWT-Secret code : codefactory

# Dio vs Http
- Http 로 리턴받은 JSON 데이터는 decode 후 Map 형태로 바꿔주어 사용하지만
  Dio 로 리턴 받은 JSON 데이터는 decode 과정 없이 바로 Map 형태로 사용하면 된다.

# Network Status Check API
1. network_info_plus
- android\app\build.gradle: compileSdkVersion 33
2. connectivity_plus 

# async / await
1. await 키워드는 async 키워드가 붙어있는 함수 내부에서만 사용
2. await 키워드를 사용하면 일반 비동기 처리처럼 바로 실행이 다음 라인으로 넘어가는 것이 아니라 
   결과값을 얻을 수 있을 때까지 기다려줍니다.

#images link
- https://pixabay.com/ko/vectors/%ea%b8%b0%eb%a6%b0-%ec%95%84%ed%94%84%eb%a6%ac%ec%b9%b4-%ec%9b%90%ec%a0%95-%ec%97%ac%ed%96%89-308963/
- https://pixabay.com/ko/vectors/%ea%b8%b0%eb%a6%b0-%ec%96%bc%ea%b5%b4-%eb%a8%b8%eb%a6%ac-%ec%b4%88%ec%83%81%ed%99%94-38209/
- https://pixabay.com/ko/vectors/%ea%b8%b0%eb%a6%b0-%ec%a3%bc%ed%99%a9%ec%83%89-%eb%a8%b8%eb%a6%ac-%eb%a7%8c%ed%99%94-%ec%9b%90-306478/