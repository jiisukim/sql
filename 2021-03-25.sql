(실습 sub6)
cycle 테이블을 이용하여 cid =1인 고객이 애음하는 제품중 cid=2 인 고객도 애음하는 제품의 애음정보를 조회하는 쿼리를 작성하세요
;
SELECT *
FROM product;
SELECT *
FROM customer;

SELECT *
FROM cycle
WHERE cid = 1;

SELECT *
FROM cycle
WHERE cid = 2;

SELECT *
FROM cycle
WHERE cid = 1
    AND pid IN(SELECT pid 
                FROM cycle
                WHERE cid = 2);
                
(실습 sub7)
 --customer, cycle, product테이블을 이용하여 cid =1인 고객이 애음하는 제품중 cid = 2 인 고객도 애음하는 제품의 애음정보를 조회하고
 -- 고객명과 제품명 까지 포함하는 쿼리를 작성하세요
 ;
 SELECT *
 FROM cycle c, customer r, product p
 WHERE  c.cid = 1 
    AND c.cid = r.cid
    AND c.pid = p.pid
    AND c.pid IN(SELECT pid
                FROM cycle 
                WHERE cid = 2);
 
 
EXISTS 서브쿼리 연산자  // 단항연산자
IN : WHERE 컬럼 | EXPRESSION IN(값1, 값2, 값3 ...)
EXISTS : WHERE EXISTS (서브쿼리)
  ==> 서브쿼리의 실행결과로 조회되는 행이 **하나라도**있으면 TRUE 없으면 FALSE
    EXISTS 연산자와 사용되는 서브쿼리는 상호연관, 비상호연관 서브쿼리 둘 다 사용이 가능하지만
    행을 제한하기 위해서 상호연관 서브쿼리와 사용되는 경우가 일반적이다.
    
    서브쿼리에서 EXISTS 연산자를 만족하는 행을 하나라도 발견을 하면 더이상 진행하지 않고 효율적으로 일을 끊어버린다.
    서브쿼리가 1억건이라 하더라도 10번째 행에서 EXISTS 연산을 만족하는 행을 발견하면 나머지 9999만 건 정도의 데이터는 확인 안한다
  
  
  -- 매니저가 존재하는 직원
SELECT *
FROM emp
WHERE mgr IS NOT NULL;


SELECT *
FROM emp e
WHERE EXISTS (SELECT empno
                FROM emp m
                WHERE e.mgr = m.empno);
                
-- EXISTS가 있는 SELECT절은 관습적으로 'X'를 사용한다.       

SELECT COUNT(*) cnt
FROM emp
WHERE deptno = 10;

SELECT *
FROM dual
WHERE EXISTS (SELECT 'X' FROM emp WHERE deptno= 10);


(실습 sub9) // 반대 구할때는 NOT EXISTS 쓰면됨
 cycle , product 테이블을 이용하여 cid = 1인 고객이 애음하는 제품을 조회하는 쿼리를 EXISTS 연산자를 이용해 작성하세요
 ;
 SELECT pid, pnm
 FROM product
 WHERE EXISTS (SELECT 'X' FROM cycle WHERE cid=1 AND product.pid = cycle.pid );
 
// 집합 연산
INTERSECT : 교집합
MINUS : 차집합 
UNION/UNION ALL : 합집합  // UNION ALL : 중복을 허용하는 합집합 {a, b}{a, c} - UNION: {a, b, c}, UNION ALL : {a,b,a,c}(중복을 제거하지않아 속도가 더 빠르다)
 - 집합연산 : 행을 확장 -> 위아래
 - JOIN : 열을 확장 -> 양 옆

UNION : 합집합, 두개의 SELECT 결과를 하나로 합친다, 단 중복되는 데이터는 중복을 제거한다

SELECT empno, ename
FROM emp
WHERE empno IN(7369,7499)

UNION
 -- 타입의 일치 : SELECT절의 개수 일치
SELECT empno, ename
FROM emp
WHERE empno IN(7369,7521);
------------------------------
SELECT empno, ename
FROM emp
WHERE empno IN(7369,7499)

UNION ALL
 
SELECT empno, ename
FROM emp
WHERE empno IN(7369,7521);
----------------------------
SELECT empno, ename
FROM emp
WHERE empno IN(7369,7499)

INTERSECT
 
SELECT empno, ename
FROM emp
WHERE empno IN(7369,7521);
--------------------------
SELECT empno, ename
FROM emp
WHERE empno IN(7369,7499)

MINUS
 
SELECT empno, ename
FROM emp
WHERE empno IN(7369,7521);

// 집합연산 특징
1. 집합연산의 결과로 조회되는 데이터의 컬럼 이름은 첫번째 집합의 컬럼을 따른다
2. 집합 연산의 결과를 정렬하고 싶으면 가장 마지막 집합 뒤에 ORDER BY를 기술한다.
    .개별 집합에 ORDER BY를 사용한 경우 에러
    단 ORDER BY를 적용한 인라인 뷰를 사용하는 것은 가능
3. 중복이 제거된다. (예외 UNION ALL)

DML
        .SELECT
        . 데이터 신규 입력 : INSERT
        . 기존 데이터의 수정 : UPDATE
        . 기존 데이터 삭제 : DELETE
        
INSERT 문법
INSERT INTO 테이블명 (컬럼명1,컬럼명2,컬럼명3.....)
            VALUE(값1,값2,값3....)
테이블에 존재하는 모든 컬럼에 데이터를 입력하는 경우 컬럼을 생략 가능하고 
값을 기술하는 순서를 테이블에 정의된 컬럼 순서와 일치시킨다.
INSERT INTO 테이블명 VALUE(값1,값2,값3 ...);            
INSERT INTO 테이블명 [(값1,값2,값3 ...)];        
DESC dept;
INSERT INTO dept VALUES(99, 'ddit', 'daejeon')
INSERT INTO dept (deptno, dname,loc)
                    VALUES(99, 'ddit', 'daejeon');
                    
INSERT INTO emp (empno,ename, job) VALUES(9999,'brown', 'RANGER');                    
SELECT *
FROM emp;

//여러건을 한번에 입력하기
INSERT INTO 테이블 명
SELECT 쿼리 
;
INSERT INTO dept
SELECT 90, 'DDIT', '대전' FROM dual UNION ALL
SELECT 80, 'DDIT8', '대전' FROM dual;

SELECT *
FROM dept;

ROLLBACK;  //커밋을 안하면 그전에 했던 내용이 전부 취소된다.

SELECT *
FROM dept;

SELECT *
FROM emp;


UPDATE : 테이블에 존재하는 기존 데이터의 값을 변경
UPDATE 테이블명 SET 컬럼명1 = 값1 , 컬럼명2 = 값2, ......
WHERE ;

SELECT *
FROM dept;

-- 부서번호 99반 부서정보를 부서명 = 대덕IT로, loc = 영민빌딩으로 변경
UPDATE dept SET dname = '대덕IT', loc = '영민빌딩'
WHERE deptno = 99;
// UPDATE 주의할점 : WHERE 절 누락 되었는지 확인
                    WHERE 절 누락 되었을 경우 테이블의 모든 행에 대해 업데이트 진행
                    
                    
SELECT *
FROM dept;