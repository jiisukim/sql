
sem계정에 있는 prod 테이블의 모든 컬럼을 조회하는 SELECT쿼리 작성
SELECT *
FROM prod

sem계정에 있는 prod 테이블의 prod_id, prod_name 컬럼을 조회하는 SELECT쿼리 작성

SELECT prod_id,prod_name
FROM prod;


select1
SELECT *
FROM prod;

SELECT buyer_id,buyer_name
FROM buyer;

SELECT *
FROM cart;

SELECT mem_id,mem_pass,mem_name
FROM member;

컬럼 정보를 보는방법
1. SELECT * ==> 컬럼의 이름을 알 수 있다.
2. SQL DEVELOPER의 테이블 객체를 클릭하여 정보확인
3. DESC 테이블명 ;  // DESCRIBE 설명하다
숫자, 날짜에서 사용가능한 연산자
일반적인 사칙연산 + - / *, 우선순위 ()


DESC prod;

empmo : number ;
empno + 10 ==> expression
SELECT empno empnumber,empno + 10 emp_plus, 10,
        hiredate,hiredate-10
FROM emp;

컬럼정보가 아닌것은 expression
날짜에 대해서는 +, - 연산만 가능하다

ALIAS : 컬럼의 이름을 변경
        컬럼 | expression [AS][별칭명]
        
SELECT empno empno, empno+10 AS empno_plus
FROM emp;

NULL : 아직 모르는 값
        0과 공백은 NULL과 다르다
        **** NULL을 포함한 연산결과는 결과가 항상 NULL****
        ==> NULL값을 다른값으로 치환해주는 함수
        
SELECT ename, sal, comm, sal+comm, comm+100
FROM emp;

select2
SELECT prod_id id,prod_name AS name
FROM prod;

SELECT lprod_gu AS gu, lprod_nm nm
FROM lprod;         

SELECT buyer_id 바이어아이디, buyer_name AS 이름
FROM buyer;

literal : 값 자체
literal 표기법 : 값을 표현하는 방법

java 정수 값 표현
int x = 10;

SELECT empno, 10, 'Hello World'
FROM emp;

문자열 연산
java : String msg = "Hello" +" , World"

SELECT empno + 10,ename ||'Hello' || ',World',
        CONCAT(ename, ' Hello'||',World') --결합할 두개의 문자열을 입력받아 결합하고 결합된 문자열을 반환해준다.
FROM emp;

DESC emp;

SELECT '아이디 : ' || userid 아이디, 
        CONCAT('아이디 : ', userid)
FROM users;

SELECT table_name
FROM user_tables;   --내가 만든것이 아닌 오라클에서 관리하는 프로그램


SELECT 'SELECT * FROM '||table_name || ';', 
    CONCAT(CONCAT('SELECT * FROM ',table_name),';')      
FROM user_tables;

----부서번호가 10인 직원들만 조회
---- 부서번호 : depno
SELECT *
FROM emp
WHERE deptno = 10;

---users 테이블에서 userid 컬럼의 값이 brown인 사용자만 조회
--- SQL키워드는 대소문자를 가리지 않지만 데이터 값은 데소문자를 가린다. ex) WHERE userid ='brown';  0  WHERE userid ='brown'; X
SELECT *
FROM users
WHERE userid ='brown'; 

-- emp 테이블에서 부서번호가 20번보다 큰부서에 속한 직원 조회
SELECT *
FROM emp
WHERE DEPTNO >20;

-- emp 테이블에서 부서번호가 20번 부서에 속하지 않은 모든직원
SELECT *
FROM emp
WHERE DEPTNO !=20;

WHERE : 기술한 조건을 참(TRUE)으로  만족하는 행들만 조회한다.(FILTER)

SELECT *
FROM emp
WHERE 1=1;



SELECT empno, ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE('1981/03/01','YYYY/MM/DD' );

문자열을 날짜 타입으로 변환하는 방법
TO_DATE(날짜 문자열, 날짜 문자열의 포맷팅)

TO_DATE('1981/03/01','YYYY/MM/DD' )



