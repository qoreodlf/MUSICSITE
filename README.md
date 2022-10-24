# RECOMU (개인프로젝트, 2022.09 ~ 2022.10)

## 프로젝트 개요
사용자들 간 음악 정보를 공유할 수 있는 커뮤티니 사이트입니다. 원하는 음악(앨범, 싱글)을 검색하고 해당 음악의 YOUTUBE URL을 등록하여 게시하면 해당 음악을 공유할 수 있습니다. 

## 기술스택
* 개발 환경
  * JAVA
  * Spring Framework
  * JavaScript
  * Oracle Database
  * MyBatis
  * JSP
  
* OPEN API
  * Last.fm Music Discovery API
  * YouTube Iframe Player API

## ERD
![image](https://user-images.githubusercontent.com/105340836/197390867-4039bba7-8c85-47d4-a2ac-a273eb44223e.png)

## 주요 개발 사함
* Spring Framework를 이용한 MVC패턴 백엔드 개발
  * 카테고리 별 게시판 구현
  * 회원가입, 로그인, 회원정보 변경 등 
  
* Oracle Database 이용한 DB 구축
  * DB 테이블 설계
  * MyBatis로 백엔드 서버와 연결 및 SQL Query 
  
* AJAX 이용한 프론트, 백엔드 비동기 통신
  * 댓글(작성, 수정, 삭제), 추천 기능 등 동적 처리
  * 비밀번호 확인, 사용자 정보 중복 확인

* Open API 이용한 음악공유(게시판)
  * Last.fm Music Discovery API 이용한 음원 정보 검색
  * YouTube Iframe Player API 이용한 음원 동영상 재생

## 기능 구현
* 게시판 작성 (음원 등록)
  * 아티스트와 음악제목을 검색하고 YOUTUBE URL을 추가합니다.

![addex](https://user-images.githubusercontent.com/105340836/197394642-5d45e98f-8d06-4aa1-aa69-052581656f5f.gif)

* 게시판
  * 게시판 작성 시 등록한 YOUTUBE URL과 YouTube Iframe Player API를 활용하여 음원을 재생할 수 있습니다.
  * 앨범 게시판의 경우 앨범 전체를 연속 재생할 수 있습니다. (트랙 종료 시 다음트랙 자동 재생)

![albumplayex](https://user-images.githubusercontent.com/105340836/197396080-1633a66d-a607-4fa4-aea6-bc3cf0e96711.gif)


