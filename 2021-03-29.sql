SELECT ename,job,ROWUD
FROM emp
ORDER BY ename,job;

job,ename 컬럼으로 구성된 IDX_emp_03 인덱스 삭제

CREATE 객체타입 객체명;
DROP 객체타입 객체명;

DROP INDEX idx_emp_03;

CREATE INDEX idx_emp_04 ON emp (ename,job);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGERR'
 AND ename LIKE 'C%';
 
 SELECT *
 FROM TABLE(DBMS_XPLAN.DISPLAY);
 
 SELECT ROWID, dept.*
 FROM dept;
 
 CREATE INDEX idx_dept_01 ON dept(deptno);
 
 emp
 1. table full access
 2. idx_emp_01
 3. idx_emp_02
 4. idx_emp_04
 
 dept 
 1. table full access
 2. idx_dept_01
 
 EXPLAIN PLAN FOR
 SELECT ename, dname, loc
 FROM emp, dept
 WHERE emp.deptno = dept.deptno
    AND emp.empno = 7788;
    
응답성 : OLTP (Online Transaction Processing)
퍼포먼스 : OLAP (Online Analysis Processing)
            - 은행 이자계산
    
    
    
SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

Index Access
 . 소수의 데이터를 조회할 때 유리(응답속도가 필요할 때)
 .  index를 사용하는 Input/output Single Block I/O
 . 다량의 데이터를 인덱스로 접근할 경우 속도가 느리다(2000~3000건)
 
 TABLE Access
  . 테이블의 모든 데이터를 읽고 처리를 해야하는 경우 인덱스보다 빠름
  
    . I/O 기준이 multi block
    
    
    달력만들기
    주어진것: 년월 6자리 문자열 ex= 202103
    만들것 : 해당 년월에 해당하는 달력 (7칸짜리 테이블)
    
    SELECT DECODE(d,1,iw+1,iw) ,
            MIN(DECODE(d ,1, dt )) sun, MIN(DECODE(d ,2, dt )) mon,
            MIN(DECODE(d ,3, dt )) tue,MIN(DECODE(d ,4, dt )) wed,
            MIN(DECODE(d ,5, dt )) thu,MIN(DECODE(d ,6, dt )) fri,
            MIN(DECODE(d ,7, dt )) sat
    FROM
    (SELECT TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1) dt,
            TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1),'D') d,
            TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM')+(LEVEL-1),'IW') iw
    FROM dual
    CONNECT BY LEVEL <=TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')),'DD'))
    GROUP BY DECODE(d,1,iw+1,iw) 
    ORDER BY DECODE(d,1,iw+1,iw);
    
    
    
    
    '202103' ==> 31;
    SELECT TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')),'DD')
    FROM dual;
    
    일요일이면 dt- 아니면 null, 월요일이면 dt- 아니면 null,
    화요일이면 dt- 아니면 null, 수요일이면 dt- 아니면 null,
    목요일이면 dt- 아니면 null, 금요일이면 dt- 아니면 null,
    토요일이면 dt- 아니면 null

DECODE(d ,1, dt ) sun,DECODE(d ,2, dt ) mon,
DECODE(d ,3, dt ) tue,DECODE(d ,4, dt ) wed,
DECODE(d ,5, dt ) thu,DECODE(d ,6, dt ) fri,
DECODE(d ,7, dt ) sat

 계층쿼리 - 조직도, BOM()

사용방법 : 1. 시작위치를 설정
          2. 행과 행의 연결 조건을 기술
          
SELECT empno, ename, mgr
FROM emp
START WITH empno = 7839
CONNECT BY PRIOR empno = mgr;

CONNECT BY 내가 읽은 행의 사번과= 앞으로 읽을 행의 MGR컬럼;
CONNECT BY PRIOR empno = mgr;


PRIOR - 이전의, 사전의 , 이미 읽은 데이터
이미 읽은데이터        앞으로 읽을 데이터
KING의 사번 = mgr 컬럼의 값이 KING의 사번인 녀석
empno = mgr


SELECT empno,LPAD(' ',(LEVEL-1)*4) || ename, mgr, LEVEL
FROM emp
START WITH empno = 7839
CONNECT BY PRIOR empno = mgr;   // == CONNECT BY mgr = PRIOR empno;   // == 


SELECT LPAD('TEST', 1*10) 
FROM dual;

계층쿼리 방향에 따른 분류
상향식 : 최하위 노드(leap node)에서 자신의 부모를 방문하는 형태
하향식 : 최상위(root node) 노드에서 모든 자식 노드를 방문하는 형태

 상향식 쿼리
 SMITH부터 시작하여 노드의 부모를 따라가는 계층형 쿼리 작성

SMITH - FORD

SELECT empno, ename, mgr, LEVEL
FROM emp
START WITH empno = 7369
CONNECT BY PRIOR mgr = empno;


SELECT *
FROM dept_h;

최상위 노드부터 리프 노드까지 탐색하는 계층 쿼리 작성
(LPAD를 이용한 시각적 표현까지 포함);
SELECT deptcd, deptnm, p_deptcd
FROM dept_h
START WITH p_deptcd IS NULL
CONNECT BY PRIOR deptcd = p_deptcd;

SELECT deptcd, LPAD(' ',(LEVEL-1)*4) || deptnm, p_deptcd
FROM dept_h
START WITH deptcd= 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

실습 H_2
정보시스템부 하위의 부서계층을 조회하는 쿼리를 작성하세요
SELECT LEVEL lv, deptcd, LPAD(' ',(LEVEL-1)*4) || deptnm, p_deptcd
FROM dept_h
START WITH deptcd= 'dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd;


상향식 실습 H_3
디자인팀에서 시작하는 상향식 계층쿼리를 작성하세요
SELECT LEVEL lv, deptcd,RPAD('    ',(LEVEL-1)*4)||deptnm deptnm,p_deptcd
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY PRIOR p_deptcd = deptcd;

SELECT *
FROM h_sum;

SELECT LEVEL lv, LPAD('    ',(LEVEL-1)*4)||s_id s_id, value
FROM h_sum
START WITH s_id = '0'
CONNECT BY PRIOR s_id = ps_id;
