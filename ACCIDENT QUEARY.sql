--First I create schema(database). "Vehical_acci"
--Next,I Import csv files to this database as tables.
--Now, Solving some Questions with SQL Queary.


--How Many accident have occured in urban areas versus rural areas?
select 
([Area]),  
count([Accidentindex])as'Total Accident' 
from 
[dbo].[accident]
group by 
[Area]



--Which day of the week has the highest number of accidents?
select [Day],
count([AccidentIndex]) as 'Total Accident'  from [dbo].[accident]
group by [Day]
order by 'Total Accident' desc



--What is the average age of vehicals involved in accidents based on their type?
select [VehicleType],
count([AccidentIndex]) as 'Total Accident',
avg([AgeVehicle]) as 'Average Year' 
from [dbo].[vehicalinf]
where [AgeVehicle] is not null
group by  [VehicleType]
order by 'Total Accident' desc


--Can we identify any trends in accidents based on age of vehicals involevd?
select AgeGroup,
count([AccidentIndex]) as 'Total Accident',
avg([AgeVehicle]) as 'Average Year'
from (select [AccidentIndex], [AgeVehicle],
      CASE 
	    WHEN [AgeVehicle] BETWEEN 0 AND 5 THEN 'NEW'
		WHEN [AgeVehicle] BETWEEN 6 AND 10 THEN 'REGULAR'
		ELSE 'OLD'
		end as 'AgeGroup'
FROM [dbo].[vehicalinf]
)As Subquery
group by AgeGroup


-- Are there any specific weather condition that cotribute to severe accidents?
select 
   [WeatherConditions],
   count([Severity]) as 'Total Accident'
   from [dbo].[accident]
   where [Severity] = 'Slight'
   group by [WeatherConditions]
   order by 'Total Accident' desc


 --Do accidents often involve impacts on the left hand side of vehicals?
 select [LeftHand],
 count([AccidentIndex]) as 'Total Accident'
 from [dbo].[vehicalinf]
 group by [LeftHand]
 having [LeftHand] is not null


--Are there any relationships between journey purposes and the severity of accidents?
select 
  V.[JourneyPurpose],
  COUNT(A.[Severity]) as 'Total Accident',
  CASE
    WHEN COUNT(A.[Severity]) BETWEEN 0 AND 1000 THEN 'LOW'
	WHEN COUNT(A.[Severity]) BETWEEN 1001 AND 3000 THEN 'MODERATE'
	ELSE'HIGH'
	END AS'LEVEL'
from [dbo].[accident]A
JOIN [dbo].[vehicalinf] V 
     ON V.[AccidentIndex] = A.[AccidentIndex]
GROUP BY V.[JourneyPurpose]
ORDER BY 'Total Accident' desc



--Calculate the average age of vehicales involved in accidents, considering day lights and point of impact:
select
    A.[LightConditions],
	V.[PointImpact],
	AVG(V.[AgeVehicle]) AS 'Average Year'
from
  [dbo].[accident]A
JOIN [dbo].[vehicalinf]V
   ON V.[AccidentIndex] = A.[AccidentIndex]
group by  A.[LightConditions],
          V.[PointImpact]
Having 
     [PointImpact]= 'Front'

