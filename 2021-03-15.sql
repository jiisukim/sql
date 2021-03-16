

---row : 14 , col: 8개
SELECT *
FROM emp
WHERE deptno != deptno;


-- 입사일자가 1982년 1월 1일 이후인 모든 직원 조회하는 SELECT 쿼리를 작성하세요
SELECT *
FROM emp
WHERE hiredate >= TO_DATE('1982/01/01','YYYY/MM/DD');


--WHERE절에서 사용가능한 연산자
(비교 ( =, !=, >,< ....))

비교대상 BETWEEN 비교대상의 허용 시작값 AND 비교대상의 혀용 종료값
ex) 부서번호가 10번에서 20번 사이의 속한 직원들만 조회;

SELECT *
FROM emp
WHERE deptno BETWEEN 10 AND 20;

emp 테이블에서 급여가 1000보다 크거나 같고 2000보다 작거나 같은 직원들만조회

SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

SELECT *
FROM emp
WHERE sal >= 1000 
    AND sal <=2000
    AND deptno = 10;

true AND true ==> true
true AND false ==> false
true OR true ==> true
true OR false ==> true

SELECT *
FROM emp;

 WHERE1]
-- emp 테이블에서 입사일자가 1982년 1월 1일이후부터 1983년 1월 1일 이전인 사원의 ename, hiredate 데이터를 조회하는 커리를 작성하시요
-- 단, 연산자는 between

SELECT ename,hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('1982/01/01','YYYY/MM/DD') AND TO_DATE('1983/01/01','YYYY/MM/DD');

BETWEEN AND : 포함(이상,이하)
              초과, 미만의 개념을 적용하려면 비교연산자를 사용해야한다.

IN 연산자
대상자 IN (대상자와 비교할 값1,대상자와 비교할 값2,대상자와 비교할 값3, .......) 

deptno IN(10,20); ==> deptno 값이 10이나 20 이면 TRUE;

SELECT *
FROM emp
WHERE deptno IN(10,20);

SELECT *
FROM emp
WHERE deptno = 10
    OR deptno =20;
    
SELECT *
FROM emp
WHERE 10 IN(10,20);
 ==> 10은 10과 같거나 20과 같다  TRUE(모든자료 출력)
          TRUE  OR  FALSE

WHERE2]
-- users 테이블에서  userid가 brown, cony, sally,인 데이터를 다음과 같이 조회하시오(연산자: IN)
SELECT userid "아 이 디",usernm AS 이름,alias AS 별명
FROM users
WHERE userid IN('brown','cony','sally');

LIKE 연산자 : 문자열 매칭 조회
게시글 : 제목 검색,내용 검색
        제목에 [맥북에어]가 들어가는 게시글만 조회
        % : 0개 이상의 문자
        _ : 1개의 문자
        
        
--userid가 c로 시작하는 모든사용자        
SELECT *
FROM users
WHERE userid LIKE 'c%';

userid가 c로 시작하면서 c 이후에 3개의 글자가 오는 사용자
SELECT *
FROM users
WHERE userid LIKE 'c___';

--userid에 1이 들어가는 모든 사용자 조회
SELECT *
FROM users 
WHERE userid LIKE '%l%';

where 4]
-- member 테이블에서 회원의 성이 [신] 씨인 사람의 mem_id, mem_name을 조회하는 쿼리를 작성하시오

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '신%';

where5]
member 테이블에서 회원의 이름에 글자 [이]가 들어가는 모든 사람의 meme_id, mem_name 을 조회하는 커리를 작성하시오
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%이%';

IS(NULL비교)
emp테이블에서 sal 칼럼이 NULL인사람 조회

SELECT *
FROM emp
WHERE comm IS NULL;

-- IS 부정
SELECT *
FROM emp
WHERE comm IS NOT NULL;

emp테이블에서 매니저가 없는 사람만 조회

SELECT *
FROM emp
WHERE mgr IS NULL;

BETWEEN, AND, IN, LIKE, IS

논리 연산자 : AND OR NOT
AND : 두가지 조건을 동시에 만족시키는지 확인할 때
   조건 1 AND 조건2
OR : 두가지 조건중 하나라도 만족 시키는지 확인할 때   
   조건1 OR 조건2

NOT : 보정형 논리연산자, 특정 조건을 부정
 mgr IS NULL: mgr 컬럼의 값이 NULL인 사람만 조회
 mgr IS NOT NULL : mgr 컬럼의 값이 NULL이 아닌사람만 조회
 
 emp테이블에서 mgr의 사번이 7698이면서 
 sal값이 1000보다 큰 직원만 조회
 
 -- 조건의 순서는 결과와 무관하다
 SELECT *
FROM emp
WHERE mgr = 7698
    AND sal > 1000;

AND 조건이 많아지면 : 조회되는 데이터 건수는 줄어든다
OR  조건이 많아지면 : 조회되는 데이 터 건수는 많아진다.
NOT : 부정형 연산자, 다른 연산자와 결합하여 쓰인닫.

--직원의 부서번호가 30번이 아닌 직원들
SELECT *
FROM emp
WHERE deptno  != 30;

★★ NOT IN 연산자 사용시 주의점 : 비교값중에 NULL이 포함되면 데이터가 조회되지 않는다. ★★
IN은 OR , NOT IN은 AND
WHERE mgr IN (7698,7839,NULL);  mgr이 7698 이거나 7839이거나 NULL(근데 널값은 안찾아짐)
WHERE mgr NOT IN (7698,7839,NULL);  mgr이 7698이 아니고 and 7839이아니고 and NULL도아님(근데 널값은 안찾아짐)


SELECT *
FROM emp
WHERE mgr IN (7698,7839,NULL);
 
where 7]
emp 테이블에서 job이 SALESMAN 이고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회하세요
SELECT *
FROM emp
WHERE job = 'SALESMAN' 
    AND hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD'); 

where8]
--emp 테이블 에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회하세요
SELECT *
FROM emp
WHERE deptno !=10
    AND hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD'); 
    
Where10]
-- emp 테이블 에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회하세요
--(부서는 10,20,30 만 있다고 가정하고 IN 연산자 사용)
SELECT *
FROM emp
WHERE deptno IN(20,30)
    AND hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD'); 
    
where 11] 
mep 테이블에서 job이 SALESMAN이거나 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회하세요
SELECT *
FROM emp
WHERE job = 'SALESMAN'
     OR hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD'); 
     
     
where 12]
--emp테이블에서 job이 SALESMAN이거나 사원번호가 78로 시작하는 직원의 정보를 다음과 같이 조회하세요
SELECT *
FROM emp
WHERE job = 'SALESMAN'
    OR empno BETWEEN 7800 AND 7900;


where 13]
--emp테이블에서 job이 SALESMAN이거나 사원번호가 78로 시작하는 직원의 정보를 다음과 같이 조회하세요
-- LIKE 사용 X
SELECT *
FROM emp
WHERE job = 'SALESMAN'
    OR empno BETWEEN 7800 AND 7899
    OR empno BETWEEN 78 AND 78
    OR empno BETWEEN 780 AND 789;

