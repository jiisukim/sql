분석함수/ window함수
- LAG(col)
  : 파티션별 윈도우에서 이전 행의 컬럼 값
- LEAD(col)
 : 파티션별 윈도우에서 이후 행의 컬럼값

SELECT empno, ename, hiredate, sal, 
        LEAD(sal) OVER (ORDER BY sal DESC, hiredate)
FROM emp
;

자신보다 급여 순위가 한단계 낮은 사람의 급여를 5번째 컬럼으로 생성

실습 ana5
window function을 이용하여 모든 사원에 대해 사원번호, 사원이름, 입사일자, 급여, 전체 사원중 급여 순위가 1단계 높은 사람의 급여를 조회하는
쿼리를 작성하세요(급여가 같은경우 입사일이 빠른 사람이 높은순위)


실습 ana5-1
window function를 사용하지 않고 모든 사원에 대해 사원번호, 사원이름, 입사일자, 급여, 전체 사원중 급여 순위가 1단계 높은 사람의 급여를 조회하는
쿼리를 작성하세요(급여가 같은경우 입사일이 빠른 사람이 높은순위)
SELECT a.empno, a.ename, a.hiredate, a.sal, b.sal
FROM 
(SELECT a.*, ROWNUM rn
FROM (
SELECT empno, ename, hiredate, sal
FROM emp
ORDER BY sal DESC,hiredate) a) a,
(SELECT a.*, ROWNUM rn
FROM (
SELECT empno, ename, hiredate, sal
FROM emp
ORDER BY sal DESC,hiredate) a) b
WHERE a.rn-1 = b.rn(+)
ORDER BY a.sal DESC, a.hiredate;

window function을 이용하여 모든 사원에 대해 사원번호, 사원이름, 입사일자, 직군, 급여 정보와 담당업무 별 급여순위가 1단계 높은 사람의
급여를 조회하는 쿼리를 작성하세요

ana6]
SELECT empno, ename, hiredate,job, sal,
        LAG(sal) OVER (PARTITION BY job ORDER BY sal DESC, hiredate) 
FROM emp;


 LAG, LEAD 함수의 두번째 인자: 이전, 이후 몇번째 행을 가져올지 표기
SELECT empno, ename, hiredate,job, sal,
        LAG(sal, 2) OVER (ORDER BY sal DESC, hiredate) 
FROM emp;


SELECT,a.*, b.sal,
FROM
(SELECT ROWNUM rn, a.*
FROM
(SELECT empno, ename, sal
FROM emp
ORDER BY sal) a) a,
(SELECT ROWNUM rn, a.*
FROM
(SELECT empno, ename, sal 
FROM emp
ORDER BY sal) a) b
WHERE ;


SELECT a.empno, a.ename, a.sal, SUM(b.sal)
FROM
(SELECT a.*, ROWNUM rn
FROM
(SELECT empno, ename, sal
FROM emp
ORDER BY sal,empno) a) a,
(SELECT a.*, ROWNUM rn
FROM
(SELECT empno, ename, sal
FROM emp
ORDER BY sal,empno) a) b
WHERE a.rn >=b.rn
GROUP BY a.empno, a.ename, a.sal
ORDER BY a.sal , a.empno;

〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓
분석함수() over([PARTITION] [ORDER] [WINDOWING])
ex ) SUM(sal) OVER([PARTITION BY deptno] [ORDER BY sal, empno] [ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW]) c_sum
WINDOWING : 윈도우함수의 대상이 되는 행을 지정
UNBOUNDED PRECEDING : 특정 행을 기준으로 모든 이전 행(LAG)
        n PRECEDING : 특정행을 기준으로 n행 이전행(LAG)
CURRENT ROW: 현재 행
UNBOUNDED FOLLOWING : 특정 행을 기준으로 모든 이후행 (LEAD)
        n FOLLOWING : 특정 행을 기준으로 n행 이후행(LEAD)
〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓


SELECT empno, ename, sal, 
        SUM(sal) OVER(ORDER BY sal, empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum,
        SUM(sal) OVER(ORDER BY sal, empno ROWS UNBOUNDED PRECEDING) d_sum
FROM emp
ORDER BY sal, empno;


SELECT empno, ename, sal, 
        SUM(sal) OVER(ORDER BY sal, empno ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) c_sum
FROM emp
ORDER BY sal, empno;

ana7
사원번호,사원이름, 부서번호, 급여정보를  부서별로 급여, 사원번호 오름차순으로 정렬했을 때, 자신의 급여와 선행하는 사원들의 급여합을 조회하는
쿼리를 작성하세요
SELECT empno,ename,deptno,sal,
    SUM(sal) OVER(PARTITION BY deptno ORDER BY sal, empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum
FROM emp
ORDER BY sal, empno;

〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓
SELECT empno,ename,deptno,sal,
    SUM(sal) OVER(ORDER BY sal ROWS UNBOUNDED PRECEDING) rows_c_sum,
    SUM(sal) OVER(ORDER BY sal RANGE UNBOUNDED PRECEDING) range_c_sum,  --RANGE : 같은값을 하나의 행으로봄 // WARD와 MARTIN을 같은 행으로 봄
    SUM(sal) OVER(ORDER BY sal) no_win_c_sum,   -- windowing을 적용하지 않으면 기본으로 RANGE UNBOUNDED PRECEDING
    SUM(sal) OVER() no_ord_c_sum  -- 전체합
FROM emp
ORDER BY sal, empno
〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓〓



