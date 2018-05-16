-- https://stackoverflow.com/a/44297560

ALTER TABLE sales_bestsellers_aggregated_yearly
ADD product_type_id TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL
AFTER product_id;


ALTER TABLE catalog_product_entity_group_price ADD is_percent SMALLINT( 5 ) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Is Percent';
