-----SUBQUERY
-----subquery classica � mais lenta

-----subquery correlacionada � mais r�pida, pois usa o boleano (verdadeiro ou falso).

---EXISTS OU NOT EXISTS 

SELECT
	*
	FROM TB_DEPARTAMENTO AS DEP
	WHERE EXISTS 
	(
		SELECT * FROM TB_EMPREGADO AS EMP
		WHERE DEP.COD_DEPTO = EMP.COD_DEPTO
	)



SELECT *
INTO TB_EMP_COPIA
FROM TB_EMPREGADO

UPDATE TB_EMP_COPIA
	SET EMP.SALARIO = EMP.SALARIO * 1.20
	DEPTO =	'TECNOLOGIA'

FROM TB_EMP_COPIA   AS EMP
JOIN TB_DEPARTAMENTO AS DEP 
	ON EMP.COD_DEPTO = DEP.COD_DEPTO

WHERE DEP.DEPTO = 'PESSOAL'


------- GROUP BY + AGREGA��O --------
-------------------------------------

------- 5 TIPOS DE FUN��O DE AGREGA��O ------
COUNT
SUM
AVG
MAX
MIN

SELECT COUNT (*) FROM TB_EMPREGADO
SELECT COUNT (SALARIO) FROM TB_EMPREGADO
SELECT MAX (DATA_NASCIMENTO) FROM TB_EMPREGADO ---SELECIONA A MAIOR DATA DE NASCIMENTO, POR EXEMPLO
SELECT MIN (NOME) FROM TB_EMPREGADO
SELECT AVG (SALARIO) FROM TB_EMPREGADO 

--- DICA: COLUNAS QUE N�O TEM A FUN��O DE AGREGAR, JOGA DIRETO PARA O GROUPY BY

SELECT
	ISNULL(CLI.ESTADO, 'DESCONHECIDO') AS ESTADOS,
	YEAR(PED.DATA_EMISSAO)	AS ANO_PEDIDO,
	COUNT(*)				AS QTD_PEDIDOS,
	SUM(PED.VLR_TOTAL)		AS VLR_TOTAL

FROM TB_PEDIDO AS PED
JOIN TB_CLIENTE AS CLI
ON PED.CODCLI = CLI.CODCLI

WHERE CLI.ESTADO <> 'RJ'
AND EXISTS
(
	SELECT * FROM TB_ITENSPEDIDO AS TI
	JOIN TB_COR AS COR
ON TI.CODCOR = COR.CODCOR
	WHERE COR = 'VERMELHO'
	AND PED.NUM_PEDIDO = TI.NUM_PEDIDO
)

GROUP BY
CLI.ESTADO,
	YEAR(PED.DATA_EMISSAO)

HAVING COUNT(*) > 100

ORDER BY ESTADO DESC, ANO_PEDIDO

