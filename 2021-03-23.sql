SELECT TO_DATE
FROM buyprod,prod
WHERE buyprod.buy_prod(+) = prod.prod_id
 AND buy_date(+) ;
 
 SELECT *
 FROM product;
 
 SELECT *
 FROM cycle;
 
 SELECT product.*, cycle.cid, NVL(cycle.day,0) day, NVL(cycle.cnt,0) cnt
 FROM product LEFT OUTER JOIN cycle ON(product.pid = cycle.pid AND cid = 1);
 
 
 SELECT product.*, cycle.cid, NVL(cycle.day,0) day, NVL(cycle.cnt,0) cnt
 FROM product , cycle
 WHERE product.pid = cycle.pid(+)
  AND cid(+) = : cid;
  
  JOIN 
  카테고리
  :ANSI / ORACLE
  논리적형태
  : SELF JOIN, NON-EQUI-JOIN <==> EQUI-JOIN
 연결조건 성공 실패에 따라 조회여부 결정
  : OUTERJOIN <==> INNER JOIN : 연결이 성공적으로 이루어지는 행에 대해서만 조회가 되는 조인
 
SELECT *
FROM dept  INNER JOIN emp on(dept.deptno = emp.deptno);

CROSS JOIN 
 . 별도의 연결조건이 없는 조인
 . 묻지마 조인
 . 두 테이블의 행간 연결 가능한 모든 경우의 수로 연결
   ==> CROSS JOIN의 결과는 두 테이블의 행의 수를 곱한 값과 같은 행이 반환된다.
 [. 데이터 복제를 위해 사용  ]

SELECT *
FROM emp CROSS JOIN dept;

CROSS JOIN1]
SELECT*
FROM customer CROSS JOIN product;
 
-- 대전 중구의 버거지수
도시발전지수 : (kfc + 맥도날드 + 버거킹)/롯데리아

SELECT SIDO, STORENAME, STORECATEGORY,
    CASE 
    WHEN STORECATEGORY = 'BURGER KING' THEN NVL(DEVELOPMENT,0) + 1
    WHEN STORECATEGORY = 'MACDONALD' THEN NVL(DEVELOPMENT,0) + 1
    WHEN STORECATEGORY = 'KFC' THEN NVL(DEVELOPMENT,0) + 1
    ELSE NVL(DEVELOPMENT,0)
    END 도시발전지수
    count(development)
FROM BURGERSTORE
WHERE SIDO = '대전'
    AND SIGUNGU ='중구';
    
 SELECT sido,sigungu, storecategory, COUNT(storecategory)
 FROM BURGERSTORE
 GROUP BY storecategory,sido,sigungu ;
 
 SELECT *
 FROM BURGERSTORE;
 
 SELECT SIDO, SIGUNGU,;
 
 
 -- 행을 컬럼으로 변경(PIVOT)
SELECT sido, sigungu,
        ROUND((SUM(DECODE(storecategory, 'BURGER KING',1,0)) +
        SUM(DECODE(storecategory, 'KFC',1,0)) +
        SUM(DECODE(storecategory, 'MACDONALD',1,0)) ) /
        DECODE(SUM(DECODE(storecategory, 'LOTTERIA',1,0)),0,1 ,SUM(DECODE(storecategory, 'LOTTERIA',1,0))),2) idx
FROM burgerstore
GROUP BY sido, sigungu
ORDER BY idx DESC;





SELECT *
FROM BURGERSTORE;




