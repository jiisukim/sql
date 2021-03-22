SELECT lprod.lprod_gu,lprod.lprod_nm 
        ,prod.prod_name, prod.prod_id
FROM lprod,prod
WHERE lprod.lprod_gu = prod.prod_lgu;
 
 
  
        -- erd 다이어그램을 참고하여 buyer,prod 테이블을 조인하여 buyer별 담당하는 제품 정보를 다음과 같은 결과가 나오도록 쿼리를
        -- 작성해보시오.
SELECT buyer.buyer_id, buyer.buyer_name, prod.prod_id, prod.prod_name
FROM buyer,prod
WHERE prod.prod_buyer = buyer.buyer_id;

--erd다이어그램을 참고하여 member,cart,prod 테이블을 조인하여 회원별 장바구이네 담은 제품 정보를 다음과 같은 결과가 나오는 쿼리를 작성해보세요.

SELECT mem_id, mem_name, prod_id,prod_name, cart_qty
FROM member, cart, prod
WHERE member.mem_id = cart.cart_member
        AND cart.cart_prod = prod.prod_id;
        
SELECT mem_id, mem_name, prod_id,prod_name, cart_qty
FROM member JOIN cart ON(member.mem_id = cart.cart_member)
            JOIN prod ON(cart.cart_prod = prod.prod_id);
            
SELECT *
FROM  customer;

SELECT *
FROM  product;

SELECT *
FROM cycle;

데이터결합 (실습 join 4)
SELECT customer.cid, customer.cnm, pid, day, cnt
FROM customer, cycle
WHERE customer.cid = cycle.cid
    AND customer.cnm IN('brown','sally');

데이터결합 (실습 join 5)
SELECT customer.cid, customer.cnm, cycle.pid,pnm ,day, cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
    AND cycle.pid = product.pid
    AND customer.cnm IN('brown','sally');

데이터결합 (실습 join 6)
SELECT customer.cid, customer.cnm, cycle.pid, pnm , SUM(cycle.cnt)cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
    AND cycle.pid = product.pid
    GROUP BY  customer.cid, customer.cnm, cycle.pid,pnm;

데이터결합 (실습 join 7)
SELECT cycle.pid, product.pnm,sum(cycle.cnt) cnt
FROM cycle, product
WHERE cycle.pid = product.pid
GROUP BY  cycle.pid, product.pnm;

OUTER JOIN : 컬럼 연결이 실패해도 [기준]이 되는 테이블 쪽의 컬럼 정보는 나오도록 하는 조인.
LEFT OUTER JOIN
테이블 JOIN 테이블2
테이블 1 LEFT OUTER JOIN 테이블2 : 기준이 왼쪽에 기술한 테이블이 되는 OUTER JOIN
테이블 1 RIGHT OUTER JOIN 테이블2 : 기준이 오른쪽에 기술한 테이블이 되는 OUTER JOIN
FULL OUTER JOIN : LEFT OUTER + RIGHT OUTER - 중복데이터 제거(사용도 떨어짐)

직원의 이름, 직원의 상사이름 두개의 컬럼이 나오도록 JOIN query 작성
SELECT e.ename, m.ename,m.deptno
FROM emp e , emp m 
WHERE e.mgr = m.empno;

--ORACLE SQL OUTER JOIN 표기 :(+)
-- OUTER 조인으로 인해 데이터가 안나오는 쪽 컬럼에 (+)를 붙여준다
SELECT e.ename, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno)
WHERE m.deptno = 10;

SELECT e.ename, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno=10);

SELECT e.ename, m.ename, m.deptno
FROM emp e, emp m 
WHERE e.mgr = m.empno(+)
    AND m.deptno(+) = 10;
    
SELECT e.ename, m.ename, m.deptno
FROM emp e, emp m 
WHERE e.mgr = m.empno(+)
    AND m.deptno(+) = 10;
    
SELECT e.ename, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno);

SELECT e.ename, m.ename, m.deptno
FROM emp e RIGHT OUTER JOIN emp m ON(e.mgr = m.empno);

--FULL OUTER : LEFT OUTER + RIGHT OUTER - 중복데이터 1개만 남기고 제거(사용도 떨어짐)

SELECT e.ename, m.ename
FROM emp e FULL OUTER JOIN emp m ON(e.mgr = m.empno);

SELECT e.ename, m.ename
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno);  
-- FULL OUTER JOIN은 오라클 문법에 없음
;
SELECT e.ename, m.ename
FROM emp e, emp m
WHERE e.mgr(+) = m.empno;(+); 

SELECT *
FROM buyprod
WHERE buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD');

SELECT prod_name
FROM prod;

모든 제품을 다 보여주고 실제 구매가 있을 때는 구매수량을 조회, 없을 경우는 null로 표현
제품코드 : 수량

SELECT buy_date,buy_prod, prod_id, prod_name, buy_qty
FROM buyprod RIGHT OUTER JOIN prod ON(buyprod.buy_prod = prod.prod_id)
 AND buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD');

SELECT buy_date,buy_prod, prod_id, prod_name, buy_qty
FROM buyprod , prod 
WHERE buyprod.buy_prod(+) = prod.prod_id
 AND buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD');