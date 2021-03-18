날짜 관련함수
MONTHS+BETWEEN : 인자 - start date ,end date , 반환값 : 두 일자 사이의 개월 수

ADD_MONTHS
인자 : date, 더할 개월수 : date로 부터 x개월 뒤의 날짜

NEXT_DAY
 인자 : date ,number(weekday,주간일자)
 date 이후의 가장 첫번째 주간 일자에 해당하는 date를 반환
 
 LAST_DAY
 인자 : date : date가 속한 월의 마지막 일자를 date로 반환
 
 MONTHS_BETWEEN
 SELECT ename, TO_CHAR(hiredate, 'yyyy/mm/dd HH24:mi:ss') hiredate,
        MONTHS_BETWEEN(sysdate,hiredate)
        ,ADD_MONTHS(SYSDATE,5)
        ,ADD_MONTHS(TO_DATE('2021-02-15','YYYY/MM/DD'),5)
        ,NEXT_DAY(SYSDATE, 2) NEXT_DAY
        ,LAST_DAY(SYSDATE) LAST_DAY
    --SYSDATE를 이용하여 SYSDATE가 속한월의 첫번째 날짜 구하기
        ,TO_DATE(TO_CHAR(SYSDATE,'YYYY/MM/DD') || '01','YYYY/MM/DD') FIRST_DAY
 FROM emp;
 
 SELECT TO_DATE('2021','YYYY')
 FROM dual;


FUNCTION(실습 fn3)
-- 피라미터로 yyyymm형식의 문자열을 사용하여 해당 년월에 해당하는 일자 수를 구해보세요


SELECT TO_CHAR(To_DATE('201912','YYYYMM'), 'YYYYMM') PARAM,
       LAST_DAY(TO_CHAR(To_DATE('201912','YYYYMM'), 'YYYYMM'))
FROM dual;

SELECT :YYYYMM , TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')), 'DD')
FROM dual;

형변환
 · 명시적 형변환
    TO_DATE, TO_CHAR, TO_NUMBER
 · 묵시적 형변환
 
 1. 위에서 아래로
 2. 단, 들여쓰기가 되어이을 경우(자식노드)자식노드 부터 읽는다
 
 
 SELECT *
 FROM emp
 WHERE empno = '7369';
 
 FUNCTION( NUMBER )
 FORMAT
  , :1000자리표시
 . : 소수점
  L : 화폐단위

 - NULL처리 함수 : 4가지
 - NVL(expr1,expr2)  :expr1이 NULL값이 아니면 expr1을 사용하고, expr1이 NULL값이면 expr2로 대채해서 사용한다
if(expr1 == null)
    System.out.println(expr2)
 else 
    System.out.println(expr1)
 
 emp테이블에서 comm컬럼의 값이 NULL일 경우 0으로 대체 해서 조회
 SELECT empno, comm,sal + NVL(comm, 0), NVL(sal + comm, 0)
 FROM emp;
 
  - NVL2(expr1, expr2, expr3)  
 if(expr1 != null)
    System.out.println(expr2);
    else
    System.out.println(expr3);
 
 
 comm이 null이 아니면 sal + comm+ 을 반환,
 comm이 null이면 sal을 반환
 
 SELECT NVL2(comm,sal+comm,sal)
 FROM emp;
 
  - NULLIF(expr1, expr2)
 if(expr1 == expr2)
    System.out.println(null)
    else
    System.out.println(expr1)
    
    SELECT empno, sal , NULLIF(sal, 1250)
    FROM emp;
    
    COALESCE(expr1, expr2, exp3, ...)
    인자들 중에 가장먼저 등장하는 null이 아닌 인자를 반환
    if(expr1 != null)
     System.out.println(expr1);
     else
     COALESCE(expr2,expr3 , ...);
    
    SELECT empno, sal, comm, COALESCE()
    
    FUNCTION(실습 fn4)
    emp 테이블의 정보를 다음과 같이 조회 되도록 쿼리를 작성하시오
    ;
    
    SELECT empno,ename,mgr, nvl(mgr,9999), nvl2(mgr,mgr,9999), COALESCE(mgr,9999)
    FROM emp;
    
    FUNCTION(실습 fn5)
    users 테입블의 정보를 다음과 같이 조회되도록 쿼리를작성하세요
     reg_dt가 null일 경우 sysdate를 적용
     
     SELECT userid,usernm, reg_dt, NVL(reg_dt,SYSDATE) n_reg_dt
     FROM users
     WHERE userid IN('cony','sally','james','moon');
    
    - 조건 분기
    ★★★★★★★★★★★★★★★
    1. CASE절
        CASE expr1 비교식(참거짓을 판단 할 수 있는 수식) THEN 사용할 값 => if
        CASE expr2 비교식(참거짓을 판단 할 수 있는 수식) THEN 사용할 값 => else if
        CASE expr3 비교식(참거짓을 판단 할 수 있는 수식) THEN 사용할 값 => else if
        ELSE 사용할 값4                                             => else
        END
    2. DECODE 함수 => COALESCE 함수처럼 기반자 사용
        DECODE(expr1,search1,return1,search2,return2,search3,return3....[, default])
         DECODE(expr1,
         search1,return1,
         search2,return2,
         search3,return3
         ....[, default])
        if(expr1 == search1)
            System.out.println(return1)
        else if(expr1 == search2)
            System.out.println(return2)
    if
    else if
    else if 
    .
    .
    else
    
    직원들의 급여를 인상하려고 한다.
    job 이 salesman이면 현재 급여에서 5%인상
    job이 manager이면 현재급여에서 10%인상
    job이 president 이면 현재 급여에서 20%를 인상
    그외의 직업군은 현재 급여 유지
    
    SELECT ename, job , sal, 
    CASE 
        WHEN job = 'SALESMAN' THEN sal * 1.05
         WHEN job = 'MANAGER' THEN sal * 1.10
        WHEN job = 'PRESIDENT' THEN sal * 1.20
        ELSE sal * 1.0
        END sal_bonus
    FROM emp;
    ★★★★★★★★★★★
    SELECT ename, job , sal, 
    DECODE(job, 
    'SALESMAN',sal*1.05,
    'MANAGER',sal*1.10,
    'PRESIDENT',sal*1.20,
    sal * 1.0) sal_bonus_decode
    FROM emp;
    
    condition 실습 cond1
    emp테이블을 이용하여 deptno에 따라 부서명으로 변경해서 다음과 같이 조회되는 쿼리를 작성하세요
    
    SELECT empno,ename, DECODE(deptno,10,'ACCOUNTING',20,'RESEARCH',30,'SALES',40,'OPERATIONS','DDIT') Dname
    FROM emp;    
    
    
    --emp테이블을 이용하여 hiredate에따라 올해 건강보험 검진 대상자인지 조회하는 쿼리를 작성하세요
    SELECT MOD(1981,2)
    FROM dual;
    
    SELECT empno, ename, hiredate, 
        CASE
            WHEN
                MOD(TO_CHAR(hiredate,'yyyy'),2) =
                MOD(TO_CHAR(SYSDATE,'yyyy'),2) THEN '건강검진 대상자'
            ELSE '건강검진 비대상자'
            END
    FROM emp;            
    
    SELECT empno, ename, hiredate,DECODE( MOD(TO_CHAR(hiredate,'yyyy'),2),MOD(TO_CHAR(SYSDATE,'yyyy'),2),'건강검진대상자',
    '건강검진 비대상자')
    FROM emp;
    
    
    SELECT empno, ename, reg_dt, 
        CASE
            WHEN
                MOD(TO_CHAR(hiredate,'yyyy'),2) =
                MOD(TO_CHAR(SYSDATE,'yyyy'),2) THEN '건강검진 대상자'
            ELSE '건강검진 비대상자'
            END
    FROM emp;            
    
    SELECT userid,usernm,reg_dt, 
    CASE
        WHEN
            MOD(TO_CHAR(reg_dt,'YYYY'),2)
            =  MOD(TO_CHAR(SYSDATE,'YYYY'),2) THEN '건강검진 대상자'
            ELSE '건강검진 비대상자'
            END
    FROM users;
    
    GROUP FUNCTION :여러행을 그룹으로 하여 하나의 행으로 결과 값을 반환하는 함수
    
    -GROUP function
    --AVG : 평균
    --COUNT : 건수
    --MAX : 최대값
    --MIN : 최소값
    --SUM :합
    
    -- GROUP BY 절에 나온 컬럼이 SELECT절에 그룹함수가 적용되지 않은채로 기술되면 에러
    SELECT deptno, MAX(sal), MIN(sal), ROUND(AVG(sal),2),
                SUM(sal), 
                COUNT(sal) -- 그룹화된 행중에 sal 컬림의 값이 null이 아닌 행의 건수
                ,COUNT(mgr) -- 그룹화된 행중에 sal 컬림의 값이 null이 아닌 행의 건수
                ,COUNT(*) -- 그룹화된 행중에 sal 컬림의 값이 null이 아닌 행의 건수
    FROM emp
    GROUP BY deptno;
    
    --GROUP BY 를 사용하지 않을 경우 테이블의 모든 행을 하나의 행으로 그룹핑한다.
    SELECT COUNT(*), MAX(sal),MIN(sal)
    FROM emp;
    WHERE LOWER(ename)'smith'
    GRUP BY deptno
    HAVING COUNT(*) >= 4;
    
    - 그룹함수에서 null 컬럼은 계산에서 제외된다
    - GROUP BY 절에 작성된 컬림 이외의 컬럼이 SELECT절에 올 수 없다.
    -WHERE 절에 그룹함수 조건으로 사용할 수 없다
        - having 절 사용
            - WHERE sum(sal) > 3000(x)
            - HAVING sum(sal) > 3000(o)
    
    emp 테이블을 이용하여 다음을 구하시오
     - 직원중 가장 높은 급여
    - 직원중 가장 낮은 급여
    - 직원의 급여 평균
    - 직원의 급여 합
    - 직원중 급여가 있는 직원의 수
    -직원중 상급자가 있는 직원의 수
    - 전체 직원의 수
    
    SELECT MAX(sal), MIN(sal), ROUND(AVG(sal), 2), sum(sal), count(sal),count(mgr),count(*)
    FROM emp
    GROUP BY deptno;