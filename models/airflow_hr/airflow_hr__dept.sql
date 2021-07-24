with dept as (
    select * from {{ source('airflow_hr', 'dept') }}
),
final as (
    select * from dept
)
select * from final
