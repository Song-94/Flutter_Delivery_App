# flutter_delivery_app

# Android studio

1. File Nesting

- 프로젝트 옆 설정 버튼을 눌러 File Nesting 하여 '.g.dart' 을 추가하면 프로젝트에서 파일을 볼 때 .g.dart 해당 파일을 같은 이름을 지닌 해당 dart
  파일 밑으로 숨길 수 있다.

2. Dart Json Serialization Generator

- Generate Plugin about json_serialize

# tips

1. misc 의미 (miscellaneous)

- 기타, 여러가지 잡다한

2. flutter_secure_storage

- https://pub.dev/packages/flutter_secure_storage
- android\app\build.gradle: minSdkVersion 18

3. unicode center dot

- ·

4. http error 404

- url 을 다시 한번 확인해본다.

5. Pagination

- Page Based Pagination
    - 페이지 기준으로 데이터를 잘라서 요청하는 Pagination
    - 요청을 보낼때 원하는 데이터 갯수와 몇번째 페이지를 가져올지 명시
    - 페이지 숫자를 누르면 다음 페이지로 넘어가는 형태의 UI에서 많이 사용
    - Pagination 도중에 데이터베이스에서 데이터가 추가되거나 삭제될경우 저장되는 데이터가 누락되거나 중복될 수 있음
    - Pagination 알고리즘이 매우 간단함
- Cursor Based Pagination
    - 가장 최근에 가져온 데이터를 기준으로 다음 데이터를 가져오는 Pagination
    - 요청을 보낼때 마지막 데이터의 기준값(ID등 Unique 값)과 몇개의 데이터를 가져올지 명시
    - 스크롤 형태의 리스트에서 자주 사용 예) 앱의 ListView
    - 최근 데이터의 기준값을 기반으로 쿼리가 작성되기때문에 데이터가 누락되거나 중복될 확률이 적음

6. FutureBuilder에서 future 함수 중복 호출 방지

- https://landroid.tistory.com/16

7. enum.firstWhere

<pre>
<code>
  final numbers = <>[1, 2, 3, 5, 6, 7];
  var result = numbers.firstWhere((element) => element < 5); // 1
  result = numbers.firstWhere((element) => element > 5); // 6
</code>
</pre>

8. Caching

- FutureBuilder, StreamBuilder 데이터를 한번 요청하여 소유하고 있는 데이터가 있으면 데이터를 소유하고 있음.

# Code Generation

- flutter pub run build_runner (cmd)
- (cmd = build) : 1회성 실행
- (cmd = watch) : 프로젝트에서 파일 변경을 바라봄

# Sites

1. Base64 Encoder

- https://www.base64encode.org/

2. JWT (JSON Web Tokens) decode

- https://jwt.io/

3. BoxFit of Image widget

- https://devmg.tistory.com/181

4. design pattern

- https://brunch.co.kr/@oemilk/113

5. extends / implements

- https://wooono.tistory.com/261

6. POSTMAN settings of environment value

- https://inpa.tistory.com/entry/POSTMAN-%F0%9F%92%BD-%ED%8F%AC%EC%8A%A4%ED%8A%B8%EB%A7%A8-%EB%B3%80%EC%88%98-%EC%82%AC%EC%9A%A9-%EB%B0%A9%EB%B2%95-%ED%99%98%EA%B2%BD-%EB%B3%80%EC%88%98-%EC%A0%84%EC%97%AD-%EB%B3%80%EC%88%98#:~:text=%EB%8B%A4%EB%A4%84%20%EB%B3%BC%20%EA%B2%83%EC%9D%B4%EB%8B%A4.-,%ED%8F%AC%EC%8A%A4%ED%8A%B8%EB%A7%A8%20%ED%99%98%EA%B2%BD%EB%B3%80%EC%88%98%20(environment),%EB%B3%B5%EC%A0%9C%2C%20%EB%82%B4%EB%B3%B4%EB%82%B4%EA%B8%B0%20%EB%93%B1%EC%9D%B4%20%EC%89%BD%EB%8B%A4
  .

7. Equatable & Immutable

- https://blog.codefactory.ai/flutter/equatable/

8. Dependency Injection (DI)

- https://mangkyu.tistory.com/150

# Sever Test ID/PW

1. id              : ai
2. pw              : testtest
3. key             : authorization
4. value           : Basic test@codefactory.ai:testtest
5. Base64 encode   : dGVzdEBjb2RlZmFjdG9yeS5haTp0ZXN0dGVzdA==
6. JWT-Secret code : codefactory

# Dio vs Http

- Http 로 리턴받은 JSON 데이터는 decode 후 Map 형태로 바꿔주어 사용하지만 Dio 로 리턴 받은 JSON 데이터는 decode 과정 없이 바로 Map 형태로
  사용하면 된다.

# Network Status Check API

1. network_info_plus

- android\app\build.gradle: compileSdkVersion 33

2. connectivity_plus

# async / await

1. await 키워드는 async 키워드가 붙어있는 함수 내부에서만 사용
2. await 키워드를 사용하면 일반 비동기 처리처럼 바로 실행이 다음 라인으로 넘어가는 것이 아니라 결과값을 얻을 수 있을 때까지 기다려줍니다.

# factory Class

- 현재 클래스의 인스턴스 뿐만 아니라 상속하고 있는 클래스도 인스턴스화 해서 반환 할 수 있다.

<pre>
<code>
void main() {
  final parent = Parent(id:1);
  final child = Child(id:3);
  final child2 = Parent.fromInt(2);
  print(parent);  // Instance of 'Parent'
  print(child);   // Instance of 'Child'
  print(child2);  // Instance of 'Child'
}

class Parent {
  final int id;
  Parent({
    required this.id,
  });

  factory Parent.fromInt(int id) {
    return Child(id: id);
  }
}

class Child extends Parent {
  Child({
    required super.id,
  });
}
</code>
</pre>

# images link

- https://pixabay.com/ko/vectors/%ea%b8%b0%eb%a6%b0-%ec%95%84%ed%94%84%eb%a6%ac%ec%b9%b4-%ec%9b%90%ec%a0%95-%ec%97%ac%ed%96%89-308963/
- https://pixabay.com/ko/vectors/%ea%b8%b0%eb%a6%b0-%ec%96%bc%ea%b5%b4-%eb%a8%b8%eb%a6%ac-%ec%b4%88%ec%83%81%ed%99%94-38209/
- https://pixabay.com/ko/vectors/%ea%b8%b0%eb%a6%b0-%ec%a3%bc%ed%99%a9%ec%83%89-%eb%a8%b8%eb%a6%ac-%eb%a7%8c%ed%99%94-%ec%9b%90-306478/

# Server Errors

1. 401 : Token 문제.
2. 404 : 잘못된 Url

# 클래스(class), 객체(object), 인스턴스(instance) 차이

클래스란 객체를 정의하고 만들어 내기 위한 설계도 혹은 틀을 말한다. 클래스 안에는 객체를 만들어내기 위해 필요한 변수와 메서드들이 존재한다. 객체란 클래스에 선언된 모양 그대로
생성된 실체를 말하며 '클래스의 인스턴스'라고 부른다. 인스턴스란 클래스를 통해서 구현해야할 대상(객체)이 실제로 구현된 구체적인 실체를 말한다. 예를들어 붕어빵을 만든다고 상황을
가정해보자. 여기서 클래스는 붕어빵을 만들기 위한 틀이 되고 객체는 붕어빵이다. 그리고 인스턴스는 붕어빵 틀로 찍어낸 각각의 붕어빵이다. 팥붕어빵과 슈크림붕어빵은 같은 타입의
객체이지만, 인스턴스 관점으로 보았을 때는 다르다.

# JsonSerializable options.

const JsonSerializable({ @Deprecated('Has no effect') bool? nullable, this.anyMap, this.checked,
this.constructor, this.createFieldMap, this.createFactory, this.createToJson,
this.disallowUnrecognizedKeys, this.explicitToJson, this.fieldRename, this.ignoreUnannotated,
this.includeIfNull, this.converters, this.genericArgumentFactories, });

# extends & implements

extends 와 implement s는 구현 내용에서도 차이가 있습니다. extends 를 통해 상속을 하는 경우에는 클래스의 모든 내용을 재정의할 필요가 없지만
implements 를 통해 인터페이스를 구현하는 경우에는 클래스의 모든 내용을 빠짐 없이 구현해야 합니다.

- implement :
  class, abstract class 상속 필수구현 다중상속 가능
- extends :
  class 상속 선택구현, abstract class 면 상속 필수구현, 다중상속 불가능
- with :
  상속 X, 기능을 가져오거나 오버라이드 가능
- mixin :
  extends 를 통한 다중 상속을 허용하지 않습니다. 다중 상속을 하려면 class 대신 mixin 을 사용해야 합니다

예시)
(가능) class Class1 implements Abstract1, Abstract2, Abstract3{}
(불가능) class Class1 extends Abstract1, Abstract2, Abstract3{}
(가능) class Class2 extends Abstract1 implements Abstract2, Abstract3{}
(불가능) class Class2 implements Abstract2, Abstract3 extends Abstract1{}
(가능) class Class1 implements Abstract1, Abstract2, Abstract3 with Class2, Class3
(가능) class Class2 extends Abstract1 implements Abstract2, Abstract3 with Class2, Class3 정리)

- extends 는 속성이나 메소드들도 모두 상속받기 때문에 하위 클래스에서 부모 클래스의 메소드들을 특별한 구현없이 바로 사용 가능.
- implements 는 여러 부모 클래스를 가질 수 있었지만, 인터페이스의 구현과 마찬가지로 하위 클래스에서 모든 메소드를 오버라이딩으로 구현 필수.
- with 는 여러 개의 부모 클래스를 가질 수 있으며, 각 메소드를 일일이 구현하지 않더라도 부모에서 구현된 메소드 호출을 할 수 있음.