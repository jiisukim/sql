SELECT *
from emp;

sELECT *
from emp;

-- 데이터 조회 방법
-- FROM : 데이터를 조회할 테이블
-- SELECT : 테이블에 있는 컬럼명 , 조회하고자 하는 컬럼명 
--          테이블의 모든 컬럼을 조회할 경우 *

SELECT *
FROM emp;
-- EMPNO : 직원번호,   ENAME : 직원이름, 
-- JOB: 담담업무,      MGR: 상위 담당자
-- HIREDATE: 입사일자, SAL: 급여
-- COMM: 상여금,       DEPNO: 부서번호

SELECT empno, ename
FROM emp;