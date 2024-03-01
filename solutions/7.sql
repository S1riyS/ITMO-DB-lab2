-- Вывести список студентов, имеющих одинаковые фамилии, но не совпадающие даты рождения.

SELECT ИД, ИМЯ, ФАМИЛИЯ, ДАТА_РОЖДЕНИЯ
FROM Н_ЛЮДИ
WHERE ФАМИЛИЯ IN
      (SELECT ФАМИЛИЯ
       FROM Н_ЛЮДИ
       GROUP BY ФАМИЛИЯ
       HAVING COUNT(DISTINCT ДАТА_РОЖДЕНИЯ) > 1)
ORDER BY ФАМИЛИЯ;