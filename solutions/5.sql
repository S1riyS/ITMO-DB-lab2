-- Выведите таблицу со средними оценками студентов группы 4100 (Номер, ФИО, Ср_оценка), у которых средняя оценка не меньше максимальной оценк(е|и) в группе 1100.

WITH P4100_ЛЮДИ_ОЦЕНКИ AS
         (SELECT Н_ЛЮДИ.ИД, Н_ЛЮДИ.ФАМИЛИЯ, Н_ЛЮДИ.ИМЯ, Н_ЛЮДИ.ОТЧЕСТВО, Н_ВЕДОМОСТИ.ОЦЕНКА
          FROM Н_ВЕДОМОСТИ
                   JOIN Н_ЛЮДИ ON Н_ЛЮДИ.ИД = Н_ВЕДОМОСТИ.ЧЛВК_ИД
                   JOIN Н_УЧЕНИКИ ON Н_УЧЕНИКИ.ЧЛВК_ИД = Н_ЛЮДИ.ИД
          WHERE Н_УЧЕНИКИ.ГРУППА = '4100'
            AND Н_ВЕДОМОСТИ.ОЦЕНКА ~ '^\d$'),

     P1100_ОЦЕНКИ AS
         (SELECT Н_ВЕДОМОСТИ.ОЦЕНКА
          FROM Н_ВЕДОМОСТИ
                   JOIN Н_ЛЮДИ ON Н_ЛЮДИ.ИД = Н_ВЕДОМОСТИ.ЧЛВК_ИД
                   JOIN Н_УЧЕНИКИ ON Н_УЧЕНИКИ.ЧЛВК_ИД = Н_ЛЮДИ.ИД
          WHERE Н_УЧЕНИКИ.ГРУППА = '1100'
            AND Н_ВЕДОМОСТИ.ОЦЕНКА ~ '^\d$')

SELECT ИД, ФАМИЛИЯ, ИМЯ, ОТЧЕСТВО, AVG(ОЦЕНКА::int)
FROM P4100_ЛЮДИ_ОЦЕНКИ
GROUP BY ИД, ФАМИЛИЯ, ИМЯ, ОТЧЕСТВО
HAVING AVG(ОЦЕНКА::int) >= (SELECT MAX(ОЦЕНКА::int) FROM P1100_ОЦЕНКИ);