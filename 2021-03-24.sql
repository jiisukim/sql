SELECT sido, sigungu,
        ROUND((SUM(DECODE(storecategory, 'BURGER KING',1,0)) +
        SUM(DECODE(storecategory, 'KFC',1,0)) +
        SUM(DECODE(storecategory, 'MACDONALD',1,0)) ) /
        DECODE(SUM(DECODE(storecategory, 'LOTTERIA',1,0)),0,1 ,SUM(DECODE(storecategory, 'LOTTERIA',1,0))),2) idx
FROM burgerstore
GROUP BY sido, sigungu
ORDER BY idx DESC;



SELECT deptno
FROM emp
WHERE ename = 'SMITH';


-- 서브쿼리의 활용
SELECT *
FROM emp
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE ename = 'SMITH' );
                
                
 -- 2개 이상의 값                
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                FROM emp
                WHERE ename = 'SMITH' OR ename = 'ALLEN');                
                
-- SUBQUERY : 쿼리의 일부로 사용되는 쿼리
1. 사용위치에 따른 분류
    . SELECT절에서 사용 : 스칼라 서브 쿼리 - 서브쿼리의 실행결과가 하나의 행, 하나의 컬럼을 반환하는 쿼리
    . FROM 절에서 사용 : 인라인 뷰
    . WHERE 절에서 사용 : 서브쿼리
            . 메인쿼리의 컬럼을 가져다가 사용할 수 있다.
            . 반대로 서브쿼리의 컬럼을 메인쿼리에 가져가서 사용할 수 없다.

2. 반환 값에 따른 분류 (행, 컬럼의 개수에 따른 분류)
    . 행 - 다중행, 단일행,     컬럼- 단일 컬럼 , 복수 컬럼
    . 다중행 단일 컬럼
    . 다중행 복수 컬럼
    . 단일행 단일 컬럼
    . 단일행 복수 컬럼
    
3. main-sub query의 관계에 따른 분류
    . 상호 연관 서브 쿼리(correalated subquery) - 메인 쿼리의 컬럼을 서브 쿼리에서 가져다 쓴 경우
        ==> 메인쿼리가 없으면 서브쿼리가 독자적으로 실행 불가능
    . 비상호 연관 서브 쿼리(non-correalated subquery) - 메인 쿼리의 컬럼을 서브 쿼리에서 가져다 쓰지 않은 경우
        ==> 메인쿼리가 없어도 서브쿼리로만 실행이 가능하다.

SELECT count(*)
FROM emp
WHERE sal >2073;
    ↓↓↓↓↓↓
SELECT count(sal)
FROM emp
WHERE sal >=(SELECT AVG(sal)
            FROM emp);
            

SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                FROM emp
                WHERE ename IN('SMITH','WARD'));                
            

MULTI ROW 연산
 IN : = + OR
 비교연산자 ANY
 비교연산자 ALL
 
 SELECT *
 FROM emp e
 WHERE sal < ANY(
                    SELECT s.sal
                    FROM emp s
                    WHERE s.ename IN('SMITH','WARD'));
                
직원중에 급여값이 SMITH나 WARD의 급여보다 작은 직원을 조회
        ==> 직원중 급여값이 1250보다 작은 직원 조회


직원의 급여가 800보다 작고 1250보다 작은 직원 조회
    ==>직원의 ㄱ브여가 800보다 작은 직원 조회
SELECT *
 FROM emp e
 WHERE sal <        (SELECT MIN(s.sal)
                    FROM emp s
                    WHERE s.ename IN('SMITH','WARD'));
 subquery 사용시 주의점 : NULL 값
 IN()
 NOT IN()

SELECT *
FROM emp
WHERE deptno IN(10, 20, NULL);

SELECT *
FROM emp
WHERE deptno NOT IN(SELECT mgr FROM emp);

SELECT *
FROM emp
WHERE empno NOT IN (SELECT NVL(mgr,9999)FROM emp);

SELECT *
FROM emp
WHERE mgr IN(SELECT mgr 
            FROM emp
            WHERE empno IN(7499,7782))
    AND deptno IN (SELECT deptno
                    FROM emp
                    WHERE empno IN(7499,7782));
                    

SELECT ename, mgr, deptno
FROM emp
WHERE empno IN(7499,7882);

SELECT *
FROM emp
WHERE mgr IN(7698,7839)
    AND deptno IN(10, 30);
    
    요구사항 : ALLEN 또는 CLARK의 소속부서와 같으면서 상사도 같은 직원들을 조회

-- 페어와이즈    
SELECT *
FROM emp
WHERE (mgr, deptno) IN (SELECT mgr, deptno
                        FROM emp
                        WHERE ename IN('ALLEN', 'CLARK'));


스칼라 서브쿼리 : SELECT 절에 사용된 쿼리, 하나의 행, 하나의 컬럼을 반환하는 서브쿼리(스칼라 서브쿼리)
DISTINCT 가 나오는 경우 
1. 설계가 잘못된 경우
2. 개발자가 SQL을 잘 작성하지 못하는 사람인 경우
3. 요구사항이 이상한 경우

SELECT empno, ename, SYSDATE
FROM emp;

SELECT SYSDATE
FROM dual;

SELECT empno, ename, (SELECT SYSDATE FROM dual)
FROM emp;

emp 테이블에는 해당 직원이 속한 부서번호는 관리하지만 해당 부서명 정보는 dept테이블에만 있다.
해당 직원이 속한 부서 이름을 알고 싶으면 dept 테이블과 조인을 해야한다.

SELECT*
FROM emp;

SMITH : SELECT dname FROM dept WHERE deptno = 20;
ALLEN : SELECT dname FROM dept WHERE deptno = 30;
CLARK : SELECT dname FROM dept WHERE deptno = 10;

- 상호연관 서브쿼리는 항상 메인 쿼리가 먼저 실행된다.
- 비상호연관 서브쿼리는 메인쿼리가 먼저 실행될 수도 있고 서브쿼리가 먼저 실행 될 수도 있다.
    ==> 성능 측면에서 유리한  쪽으로 오라클이 선택
    
- 인라인 뷰 : SELECT QUERY
 .  inline : 해당 위치에 직접 기술 함
 .  inline view : 해당 위치에 직접 기술한 view
        view : QUERY(O)(데이터를 정의한 쿼리) ==> view table(X)

SELECT *
FROM
(SELECT deptno , ROUND(AVG(sal),2)avg_sal1
FROM emp
GROUP BY deptno);



SELECT pid, pnm, cid, cnm, day, cnt
FROM(SELECT product.pid, pnm, NVL(cid, 1) cid1, NVL(day,0) day, NVL(cnt,0) cnt
FROM product LEFT OUTER JOIN cycle ON (product.pid = cycle.pid AND cid = 1)) join customer ON(customer.cid = cid1);

SELECT product.pid, pnm, :cid, cnm, NVL(day, 0) day, NVL(cnt, 0) cnt
FROM product LEFT OUTER JOIN cycle ON (product.pid = cycle.pid AND cycle.cid = :cid)
    JOIN customer ON (:cid = customer.cid);
    
아래 쿼리는 전체 직원의 급여 평균보다 높은 급여를 받는 직원을 조회하는 쿼리
SELECT *
FROM emp
WHERE sal >= (SELECT AVG(sal)
                FROM emp);
    
    직원이 속한 부서의 급여 평균보다 높은 급여를 받는 직원을 조회
    SELECT empno, ename, sal, deptno
    FROM emp;
    
    20번 부서의 급여 평균(2175)
    SELECT empno, ename, sal, deptno
    FROM emp e 
    WHERE e.sal > (SELECT AVG(sal)
                FROM emp a
                WHERE a.deptno = e.deptno);

SELECT * 
FROM dept
WHERE deptno NOT IN( SELECT deptno
                        FROM emp);


SELECT pid
FROM cycle
WHERE cid = 1;

SELECT *
FROM product
WHERE pid NOT IN(SELECT pid
FROM cycle
WHERE cid = 1);