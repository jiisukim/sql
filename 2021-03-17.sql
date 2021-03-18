WHERE 조건1 : 10건

WHERE 조건1:
 AND 조건2  : 10건을 넘을 수 없음
 
 
함수명을 보고
1. 피라미터가 어떤게 들어갈까?
2. 몇개의 피라미터가 들어갈까??
3. 반환되는 값은 무엇일까?

Function
 - Character
 -- 대소문자
 --- LOWER : 소문자로 바꿔줌
 --- UPPER : 대문자로바꿔줌
 --- INITCAP : 첫글자를 대문자로 바꿔줌
 --- CONCAT : 연결하다
 --- SUBSTR : 문자열의 일부분을 빼올 때
 --- LENGTH : 문자열 길이
 --- INSTR : 특정 문자열에 내가 찾고자하는 것이 있는지
 --- LPAD|RPAD : 특정 문자열 집어넣음
 --- TRIM : 공백을 제거 , 문자열의 앞과, 뒷부분에 있는 공백만
 --- REPLACE : 치환
 --- DUAL table 
    -sys계정에 있는 테이블
    - 누구나 사용가능
    - DUMMY컬럼 하나만 존재하며 값은 'X'이며  데이터 한 행만 존재
 - number : 숫자조작
--- ROUND : 반올림
--- TRUNC : 내림
--- MOD : 나눗셈의 나머지
 
 
 
 SELECT ename, Lower(ename), INITCAP(ename), INITCAP('TEST'), SUBSTR(ename, 2, 3)  --> 2번째 문자열부터 3개
        ,REPLACE(ename, 's','T')  
 FROM emp;
 
SELECT LOWER('TEST')
FROM dual;
 
SELECT *
FROM emp
WHERE LOWER(ename) = 'smith'; --> ename 에 LOWER을 실행시켜 14번 실행

SELECT *
FROM emp
WHERE  ename = UPPER('smith');  ---> 딱 한번 실행


ORACLE 문자열 함수

SELECT CONCAT(CONCAT('Hello', ' , ' ),'World') AS CONCAT, SUBSTR('Hello, World', 1, 5) SUBSTR
    , INSTR('Hello, World', 'o' , 6) INTSTR , LPAD('Hello,World', 15, '-') LPAD , REPLACE('Hello,World','o', 'x') REPLACE
    --TRIM -- 공백을 제거 , 문자열의 앞과, 뒷부분에 있는 공백만
    ,TRIM('    HELLO, WORLD      ') TRIM
FROM dual;



--number : 숫자조작
--- ROUND : 반올림
--- TRUNC : 내림
--- MOD : 나눗셈의 나머지
SELECT MOD(10,3)
FROM dual;


SELECT 
ROUND(105.54, 1) round1, -- 반올림결과가 소수점 첫번째 자리까지 나오도록 : 소수점 둘째자리에서 반올림   : 105.5
ROUND(105.55, 1) round2,-- 반올림결과가 소수점 첫번째 자리까지 나오도록 : 소수점 둘째자리에서 반올림    : 105.6
ROUND(105.55, 0) round3,-- 반올림결과가 첫번째(일의 자리) 자리까지 나오도록  : 소수점 첫번째 자리에서 반올림 : 106  
ROUND(105.55, -1) round4, -- 반올림결과가 십의자리까지 나오도록  : 정수 첫번째 자리에서 반올림 : 110
ROUND(105.55) round -- // ROUND(105.55, 0 과 같은 문장
FROM dual;

SELECT 
TRUNC(105.54, 1) trunc1, -- 절삭 결과가 소수점 첫번째 자리까지 나오도록 : 소수점 둘째자리에서 절삭  : 105.5
TRUNC(105.55, 1) trunc2,-- 절삭 결과가 소수점 첫번째 자리까지 나오도록 : 소수점 둘째자리에서 절삭  :  105.5
TRUNC(105.55, 0) trunc3,-- 절삭 결과가 첫번째(일의 자리) 자리까지 나오도록  : 소수점 첫번째 자리에서 절삭: 105
TRUNC(105.55, -1) trunc4, -- 절삭 결과가 십의자리까지 나오도록  : 정수 첫번째 자리에서 절삭 : 100
TRUNC(105.55, -1) trunc5
FROM dual;

--ex : 7499, ALLEN , 1600, 1 , 600
SELECT empno, ename, sal,  sal을 1000으로 나눴을 때의 몫, sal을 1000으로 나웠을 때의 나머지
FROM emp;

SELECT empno, ename
, MOD(sal,1000) 나머지, TRUNC(sal/1000) 몫
FROM emp;

날짜 <==> 문자
서버의 현재시간 : SYSDATE
SELECT SYSDATE 
FROM dual;
 
 
 /Functionn(date 실습 fn1)
 1. 2019년 12월 31일을 date 형으로 표현
 2. 2019년 12월 31일을 date 형으로 표현하고 5일 이전 날짜
 3. 현재날짜
 4. 현재날짜에서 3일전 값
 SELECT TO_DATE('2019/12/31','YYYY/MM/DD') LASTDAY,TO_DATE('2019/12/31','YYYY/MM/DD')-5 LASTDAY_BEFORE5 ,
        SYSDATE NOW, SYSDATE-3 NOW_BEFORE3
 FROM dual;
 
 TO_DATE :  인자 - 문자, 문자의 형식
 TO_CHAR : 인자 - 날짜 , 문자의 형식
 
 SELECT TO_DATE(SYSDATE)
 FROM dual;
 
 --주간일자(D) :  0 일요일 , 1 월요일, 2 화요일, 3 수요일, 4 목요일, 5 금요일 ,6 토요일 
 -- IW (1년 : 53주 ): 오늘 몇주차인지
 -- HH24 : 2자리 시간(24시간 표현)
 -- MI : 2자리 분
-- SS : 2자리 초
 
 SELECT TO_CHAR(SYSDATE, 'IW'),TO_CHAR(SYSDATE, 'D')  ---> 오늘 몇주차인지 : IW (1년 : 53주)
 FROM dual;
 
 
 Function (실습 fn2)
 오늘 날짜를 다음과 같은 포맷으로 조회하는 쿼리를 작성하시오
 1. 년 -월-일
 2. 년 -월-일 시간 -분-초
 3. 일-월-년
 
 SELECT TO_CHAR(SYSDATE,'YYYY/MM/DD') DT_DASH,
        TO_CHAR(SYSDATE,'YYYY/MM/DD HH24:MI:SS') DT_DASH
        ,TO_CHAR(SYSDATE,'DD/MM/YYYY' ) DT_DASH
 FROM dual;
 
 SELECT TO_CHAR(TO_DATE('2021/03/07', 'YYYY/MM/DD'),'YYYY/MM/DD HH24:MI:SS')
FROM dual; 
 
 
 SELECT SYSDATE, TO_DATE(TO_CHAR(SYSDATE-5, 'YYYY/MM/DD'),'YYYY/MM/DD')
 FROM dual;
 
 