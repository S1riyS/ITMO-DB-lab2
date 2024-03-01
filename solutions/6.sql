-- Получить список студентов, отчисленных после первого сентября 2012 года с очной формы обучения.
-- В результат включить:
-- номер группы;
-- номер, фамилию, имя и отчество студента;
-- номер пункта приказа;
-- Для реализации использовать подзапрос с EXISTS.

SELECT ПОТЕНЦИАЛЬНЫЕ_УЧЕНИКИ.ИД,
       ПОТЕНЦИАЛЬНЫЕ_УЧЕНИКИ.ГРУППА,
       Н_ЛЮДИ.ФАМИЛИЯ,
       Н_ЛЮДИ.ИМЯ,
       Н_ЛЮДИ.ОТЧЕСТВО,
       ПОТЕНЦИАЛЬНЫЕ_УЧЕНИКИ.П_ПРКОК_ИД
FROM Н_УЧЕНИКИ ПОТЕНЦИАЛЬНЫЕ_УЧЕНИКИ
         JOIN Н_ЛЮДИ ON Н_ЛЮДИ.ИД = ПОТЕНЦИАЛЬНЫЕ_УЧЕНИКИ.ЧЛВК_ИД
         JOIN Н_ПЛАНЫ ON ПОТЕНЦИАЛЬНЫЕ_УЧЕНИКИ.ПЛАН_ИД = Н_ПЛАНЫ.ИД
         JOIN Н_ФОРМЫ_ОБУЧЕНИЯ ON Н_ПЛАНЫ.ФО_ИД = Н_ФОРМЫ_ОБУЧЕНИЯ.ИД AND (Н_ФОРМЫ_ОБУЧЕНИЯ.НАИМЕНОВАНИЕ = 'Очная')

WHERE EXISTS
          (SELECT *
           FROM Н_УЧЕНИКИ ОТЧИСЛЕННЫЕ_УЧЕНИКИ
           WHERE ОТЧИСЛЕННЫЕ_УЧЕНИКИ.ПРИЗНАК = 'отчисл'
             AND ОТЧИСЛЕННЫЕ_УЧЕНИКИ.СОСТОЯНИЕ = 'утвержден'
             AND ОТЧИСЛЕННЫЕ_УЧЕНИКИ.ИД = ПОТЕНЦИАЛЬНЫЕ_УЧЕНИКИ.ИД
             AND DATE(ОТЧИСЛЕННЫЕ_УЧЕНИКИ.КОНЕЦ) > '2012-09-01');