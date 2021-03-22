emp테이블에서 다음을 구하시오
- grp2 에서 작성한 쿼리를 사용하여
  depno 대신 부서명이 나올 수 있도록 수정하시오
  
  SELECT MAX(sal), MIN(sal), ROUND(AVG(sal), 2), sum(sal), count(sal),count(mgr),count(*)
    FROM emp
    GROUP BY deptno;
    
- emp 테이블을 이용하여 다음을 구하시오
 직원의 입사 년월별로 몇명의 직원이 입사했는지 조회하는 쿼리를 작성하세요

SELECT TO_CHAR(hiredate, 'yyyymm'), count(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'yyyymm')
ORDER BY TO_CHAR(hiredate, 'yyyymm');

SELECT TO_CHAR(hiredate, 'yyyy'), count(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'yyyy')
ORDER BY TO_CHAR(hiredate, 'yyyy');

SELECT count(deptno)
FROM dept;

SELECT *
FROM emp;

SELECT COUNT(*)
FROM
(SELECT deptno
FROM emp
GROUP BY deptno );

데이터를 확장(결합)
1. 컬럼에 대한 확장 : JOIN
2. 행에대한 확장 : 집합 연산자 (UNION ALL, UNION(합집합), MINUS(차집합), INTERSECT(교집합))

 - JOIN 
- 중복을 최소화 하는 RDBMS방식으로 설계한 경우
- emp 테이블에서는 부서코드만 존재, 부서정보를 담은 dept 테이블 별도로 생성
- emp 테이블과 dept 테이블의 연결고리로 조인하여 실제 부서명을 조회한다.

JOIN
1. 표준 SQL => ANSI SQL
2. 비표준 SQL - DBMS를 만드는 회사에서 만드는 고유의 SQL 문법

ANSI : SQL
ORACLE : SQL 

ANSI - NATURAL JOIN
 . 조인하고자하는 테이블의 연결 컬럼명(타입도 동일)이 동일한 경우(emp.deptno, dept.deptno)
 . 연결컬럼의 값이 동일할 때(=) 컬럼이확장된다.
 
 SELECT ename, dname
 FROM emp NATURAL JOIN dept;
 
 SELECT *
 FROM emp, dept
 WHERE emp.deptno = dept.deptno;
 
 7369 SMITH, 7902 FORD
 SELECT e.empno, e.ename, m.empno, m.ename
 FROM emp e, emp m
 WHERE e.mgr = m.empno;

ANSI SQL : JOIN wITH USING
조인하려고 하는 테이블의 컬럼명과 타입이 같은 컬럼이 두개 이상인 상황에서 두 컬럼을 모두 조인 조건으로 참여시키지 않고,
개발자가 원하는 특정 컬럼으로만 연결을 시키고 싶을때 사용

SELECT *
FROM emp JOIN dept USING(deptno);

SELECT *
FROM emp,dept
WHERE emp.deptno = dept.deptno;

JOIN WITH ON : NATURAL JOIN , JOIN WITH USING을 대체할 수 있는 보편적인 문법
조인 컬럼 조건을 개발자가 임의로  지정

SELECT *
FROM emp JOIN dept ON(emp.deptno = dept.deptno)

-- 사원번호, 사원이름, 해당사원의 상사 사번, 해당 사원의 상사 이름 : JOIN WITH  ON 을 이용해 쿼리작성
;
 SELECT e.empno, e.ename, m.empno, m.ename
 FROM emp e, emp m;

SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e JOIN emp m ON(e.mgr = m.empno);
WHERE e.empno BETWEEN 7369 AND 7698;
   ↑↑↑ 동일 ↑↑↑
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

select * 
FROM emp;

논리적인 조건 형태
1. SELF JOIN : 조인 테이블이 같은 경우
    - 계층 구조
2. NONEQUII - JOIN : 조인 조건이 =(equal) 가 아닌 조인    

SELECT *
FROM emp, dept
WHERE emp.deptno != dept.deptno;

SELECT*
FROM salgrade;

-- salgrade를 이용해 직원의 급여등급 구하기
-- empno, ename, sall, 급여 등급
SELECT e.empno, e.ename, e.sal, s.grade
FROM emp e JOIN 
;

 emp, dept 테이블을 이용해 다음과 같이 조회되도록 쿼리를 작성하세요
 
SELECT e.empno,e.ename,m.deptno,m.dname
FROM emp e, dept m;

select *
FROM dept;

SELECT empno,ename,dept.deptno,dept.dname
FROM emp , dept 
WHERE emp.deptno = dept.deptno;

-- emp, dept 테이블을 이용하여 다음과 같이 조회되도록 쿼리를 작성하세요
SELECT empno,ename,dept.deptno,dept.dname
FROM emp , dept 
WHERE emp.deptno = dept.deptno
        AND emp. deptno IN(10,30);

SELECT *
FROM dept;

SELECT empno, ename, sal , emp.deptno, dname
FROM emp,dept
WHERE emp.deptno = dept.deptno
    AND sal> 2500
    AND empno > 7600
    AND dname = 'RESEARCH';
    
    
    
    