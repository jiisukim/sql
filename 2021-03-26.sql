INSERT 단건, 여러건
 
 UPDATE 테이블명 SET 컬러명1 =( 스칼라 서브쿼리 ),
                    컬러명2 =( 스칼라 서브쿼리 ),
                    컬러명3 = 'TEST';
                    
                    
9999번 사번(empno)을 갖는 brown 직원(ename)을 입력

INSERT INTO emp (empno,  ename) VALUES (9999,'brown');
INSERT INTO emp (empno,  ename) VALUE ('brown', 9999);

DESC emp;

SELECT *
FROM emp;

 --9999번 직원의 deptno와 job 정보를 SMITH사원의 deptno, job정보로 업데이트
 
SELECT deptno, job
FROM emp
WHERE ename = 'SMITH';

UPDATE emp SET deptno =(SELECT deptno
                        FROM emp
                        WHERE ename = 'SMITH'),
                job = (SELECT job
                        FROM emp
                        WHERE ename = 'SMITH')
WHERE empno = 9999;
                    
SELECT *
FROM emp;

MERGE 

DELETE : 기존에 존재하는 데이터를 삭제
DELETE 테이블명
WHERE 조건;

DELETE 테이블명;

DELETE emp;
ROLLBACK;

SELECT *
FROM emp;

삭제테스트를 위한 데이터 입력
INSERT INTO emp(empno, ename) VALUES (9999,'brown');

DELETE emp
WHERE empno = 9999;

mgr가 7698사번인 직원들 모두 삭제


DBMS 는 DML 문장을 실행하게 되면 LOG를 남긴다

로그를 남기지 않고 더 빠르게 데이터를 삭제하는 방법 : TRUNCATE
    . DML이 아님(DDL)
    . ROLLBACK 불가능
    . 주로 테스트 환경에서 사용
    
    TRUNCATE TABLE 테이블명;
    
    // 트랜잭션 : 논리적인일의 단위
    -- 관련된 여러 DML문장을 하나로 처리하기 위해 사용
    - 첫번째 DML문을 실행함과 동시에 트랜잭션 시작
    
    // 읽기 일관성
   - 읽기일관성 레벨 (0->3까지)  // 전문가가 아니면 건들지 않는게 좋다. 위험
   트랜잭션에서 실행한 결과가 다른 트랜잭션에 어떻게 영향을 미치는지 정의한 레벨단계
   
   LEVEL 0 :  READ UNCOMMITED  
        .dirty(변경이 가해졌다.) read 
        .커밋을 하지 않은 변경 사항도 다른 트랜잭션에서 확인 가능
        . Oracle에서는 지원하지 않는다.
        
    LEVEL 1 : READ COMMITED
        . 대부분의 DBMS 읽기 일관성 설정 레벨
        . 커밋한 데이터만 다른 트랜잭션에서 읽을 수 있다.
        . 커밋하지 않은 데이터는 다른 트랜잭션에서 볼 수 없음.

    LEVEL 2 : REPEATABLE READ
        . 선행 트랜잭션에서 읽은 데이터를 후행 트랜잭션에서 수행하지 못하도록 방지.
        . 선행 트랜잭션에서 읽었던 데이터를 트랜잭션의 마지막에서 다시 조회해도 됭일한 결과가 나오게끔 유지.
        . 신규 입력 데이터에 대해서는 막울 수 없음   ==>  Phantom Read(유령 읽기) - 없던 데이터가 조회되는 현상
        . 기존 데이터에 대해서는 동일한 데이터가 조회 되도록 유지
        . oracle 에서는 LEVEL2에 대해 공시적으로 지원하지 않으나 FOR UPDATE구문을 이용해 효과를 만들어 낼 수 있다.
        
    LEVEL 3 : Serializable Read         
        . 후행 트랜잭션에서 수정, 입력, 삭제한 데이터가 선행 트랜잭션에 영향을 주지 않음
        . 선 : 데이터 조회(14)
        . 후: 신규 입력(15)
        . 선: 데이터 조회(14)
    
    
 //인덱스
  .눈에 안보임
  . 테이블의 일부 컬럼을 사용해 데이터를 정렬한 객체
    ==> 원하는 데이터를 빠르게 찾을 수 있다.
  . 일부 컬럼과 함께 그 컬럼의 행을 찾을 수 있는 ROWID가 같이 저장됨
    .ROWID : 테이블에 저장된 행의 물리적 위치, 집 주소 같은 개념
            주소를 통해서 해당 행의 위치로 빠르게 접근하는 것이 가능
            데이터가 입력 될 때 생성   
SELECT ROWID , emp.*
FROM emp;
  
  SELECT emp.*
  FROM emp
  WHERE empno = '7782';
  
  EXPLAIN PLAN FOR
  SELECT *
  FROM emp
  WHERE empno = 7782;
  
  SELECT *
  FROM TABLE(DBMS_XPLAN.DISPLAY);
  
 //오라클 객체 생성
 CREATE 객체 타입(INDEX, TABLE ....) 객체명
         int 변수명

인덱스 생성
CREATE [UNIQUE] INDEX 인덱스이름 ON 테이블명(컬럼1,컬럼2.....);

CREATE UNIQUE INDEX PK_emp ON emp(empno);

EXPLAIN PLAN FOR
  SELECT empno
  FROM emp
  WHERE empno = 7782;
  
  SELECT *
  FROM TABLE(DBMS_XPLAN.DISPLAY);

DROP INDEX PK_EMP;

CREATE INDEX IDX_emp_01 ON emp (empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

job 컬럼에 인덱스 생성
CREATE INDEX idx_emp_02 ON emp(job);

SELECT job,ROWID
FROM emp
ORDER BY job;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);


EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
    

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);
;
CREATE INDEX IDX_EMP_03 ON emp(job,ename);

SELECT job,ROWID
FROM emp
ORDER BY job;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER';


