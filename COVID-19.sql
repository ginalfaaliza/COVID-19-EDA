#CHALLENGE

## Details of Tables
--limitation data
select distinct(substr(format_date("%Y",Date), 0,4)) Years 
from `digitaltalent_project_1.covid_19` 
order by 1 asc;

-- view of region
select 
  distinct(Location_ISO_Code) Location_Iso_Code,
  Location
from `digitaltalent_project_1.covid_19`
where Location != "Indonesia"
order by 2 asc;

-- view of location level
select distinct(Location_Level) Location_level 
from `digitaltalent_project_1.covid_19`
order by 1 asc;

#Problem Question

-- Q1. Find the highest active case covid-19 by province
select 
  Location, 
  sum(New_Active_Cases) Sum_active_cases
from `digitaltalent_project_1.covid_19`
where Location != 'Indonesia'
group by 1
order by 2 desc
limit 5;

-- Q2.Find the lowest death cases by location iso code
select Location_Iso_Code, sum(New_Deaths) total_Deaths 
from `digitaltalent_project_1.covid_19`
where Location != 'Indonesia'
group by 1
order by 2 asc
limit 2;

-- Q3. Find Date with highest case recovered rate in Indonesia
select 
  Date,
  max(round(Case_Recovered_Rate*100,2)) max_case_recovered_rate
from `digitaltalent_project_1.covid_19`
where Location ='Indonesia'
group by 1
order by 2 desc,1;

-- Q4.Total case fatality rate and case recovered rate by location iso code, sort by ascending

select 
  Location_ISO_Code,
  Location,
  round(sum(New_Deaths)/sum(New_Cases)*100,2) fatality_rate,  
  round(sum(New_Recovered)/sum(New_Cases)*100,2) recovered_rate
from `digitaltalent_project_1.covid_19` 
where Location != 'Indonesia'
group by 1,2
order by 3,4;

-- Q5. When condition total case going to reach 30000
with t1 as(
  select Date, Total_Cases
  from `digitaltalent_project_1.covid_19`
  where Location = 'Indonesia' and Total_Cases >= 25000

)
select * from t1
order by 2 asc,1 desc
limit 10;

-- Q6.Total cases more than 30000 
with t1 as (
  select Date, sum(New_Cases) total_cases_sum
  from `digitaltalent_project_1.covid_19`
  where Location != 'Indonesia'
  group by 1
)
select count(*) count_highest_case
from t1
where total_cases_sum >= 30000;

