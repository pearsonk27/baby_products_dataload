
select json_agg(json_build_object(
    'name', p.name,
    'type', pt.name,
    'price', p.price::numeric::int,
    'features', apf.features,
    'accolades', a.accolades))
from product p
join product_type pt on p.product_type_id = pt.id
join (
    select pf.product_id,
        to_jsonb(array_agg(f.name)) as features
    from feature f
    join product_feature pf on pf.feature_id = f.id
    group by product_id
) apf on apf.product_id = p.id
left join (
    select product_id,
        json_agg(json_build_object('accolade', name, 'source', source)) as accolades
    from accolade
    group by product_id
) a on p.id = a.product_id;