create table product_type (
    id int generated always as identity primary key,
    name varchar(100) not null,
    CONSTRAINT uq_product_type_name
        UNIQUE (name)
);

create table feature (
    id int generated always as identity primary key,
    name varchar(100),
    CONSTRAINT uq_feature_name
        UNIQUE (name)
);

create table product (
    id int generated always as identity primary key,
    product_type_id int,
    name varchar(100),
    price money,
    CONSTRAINT fk_product_type
      FOREIGN KEY(product_type_id) 
	    REFERENCES product_type(id),
    CONSTRAINT uq_product_name
        UNIQUE (name)
);

create table product_feature (
    id int generated always as identity primary key,
    product_id int,
    feature_id int,
    CONSTRAINT fk_product
      FOREIGN KEY(product_id) 
	    REFERENCES product(id),
    CONSTRAINT fk_feature
      FOREIGN KEY(feature_id) 
	    REFERENCES feature(id),
    CONSTRAINT uq_product_feature
        UNIQUE (product_id, feature_id)
);

create table accolade (
    id int generated always as identity primary key,
    product_id int,
    name varchar(100),
    source varchar(255),
    CONSTRAINT fk_product_accolade
      FOREIGN KEY(product_id) 
	    REFERENCES product(id)
);

CREATE OR REPLACE PROCEDURE add_product (c_product_type varchar(100), c_product_name varchar(100), c_price money)  

LANGUAGE plpgsql  

AS  

$$  

BEGIN  

    INSERT INTO product (product_type_id, name, price)
    VALUES ((SELECT id FROM product_type WHERE name = c_product_type), c_product_name, c_price);
   
END  

$$;

CREATE OR REPLACE PROCEDURE add_feature (c_product_name varchar(100), c_feature varchar(100))  

LANGUAGE plpgsql  

AS  

$$  

BEGIN  

    INSERT INTO feature (name)
    VALUES (c_feature)
    ON CONFLICT DO NOTHING;

    INSERT INTO product_feature (product_id, feature_id)
    VALUES ((SELECT id FROM product WHERE name = c_product_name), (SELECT id FROM feature WHERE name = c_feature));
   
END  

$$;

CREATE OR REPLACE PROCEDURE add_accolade (c_product_name varchar(100), c_accolade varchar(100), c_source varchar(255))  

LANGUAGE plpgsql  

AS  

$$  

BEGIN  

    INSERT INTO accolade (name, product_id, source)
    VALUES (c_accolade, (SELECT id FROM product WHERE name = c_product_name), c_source);
   
END  

$$;

insert into product_type (name)
values ('Baby Monitor');

-- call add_product('Baby Monitor'::character varying, 'Nanit Pro Camera'::character varying, 300::money);

-- call add_feature('Nanit Pro Camera'::character varying, 'Two-Way Audio'::character varying);
-- call add_feature('Nanit Pro Camera'::character varying, 'Built-in Night Light'::character varying);
-- call add_feature('Nanit Pro Camera'::character varying, 'White-Noise'::character varying);
-- call add_feature('Nanit Pro Camera'::character varying, 'Push Notifications'::character varying);
-- call add_feature('Nanit Pro Camera'::character varying, 'Temperature and Humidity Monitoring'::character varying);
-- call add_feature('Nanit Pro Camera'::character varying, 'Video Storage'::character varying);
-- call add_feature('Nanit Pro Camera'::character varying, 'Subscription - Sleep Tracking'::character varying);
-- call add_feature('Nanit Pro Camera'::character varying, 'Subscription - Detailed Sleep Report'::character varying);
-- call add_feature('Nanit Pro Camera'::character varying, 'Add-On - Breathing Wear (heart-rate)'::character varying);
-- call add_feature('Nanit Pro Camera'::character varying, 'Easy to Setup'::character varying);
-- call add_feature('Nanit Pro Camera'::character varying, 'Best Audio and Video Quality'::character varying);
-- call add_feature('Nanit Pro Camera'::character varying, 'Wi-Fi'::character varying);

-- call add_accolade('Nanit Pro Camera'::character varying, 'CNET - Best Overall Wi-Fi Monitor'::character varying, 'https://www.cnet.com/health/parenting/best-baby-monitor/'::character varying);
-- call add_accolade('Nanit Pro Camera'::character varying, 'Forbes - Other Baby Monitors We Liked'::character varying, 'https://www.forbes.com/sites/forbes-personal-shopper/article/best-baby-monitors/?sh=312846339e3a'::character varying);
-- call add_accolade('Nanit Pro Camera'::character varying, 'Babylist - Best WiFi Baby Monitor'::character varying, 'https://www.babylist.com/hello-baby/best-baby-monitor'::character varying);
