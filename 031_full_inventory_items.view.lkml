view: full_inventory_items {
   derived_table: {
    sql: SELECT inventory_items.id as "id",cost,created_at,product_id,sold_at
    FROM inventory_items
    LEFT OUTER JOIN order_items on inventory_items.id = order_items.inventory_item_id
    UNION
    SELECT inventory_items.id as "id",cost,created_at,product_id,sold_at
    FROM inventory_items
    RIGHT OUTER JOIN order_items on inventory_items.id = order_items.inventory_item_id
    ;;

    indexes: ["id"]
    sql_trigger_value: SELECT CURDATE();;
    }

  dimension: id {
  type: number
  primary_key: yes
  sql:  ${TABLE}.id ;;
  }

  dimension: cost {
    type: number
    value_format_name: usd
    sql: ${TABLE}.cost ;;
  }

  dimension_group: created {
    type: time
    timeframes: [time, date, week, month, raw]
    sql: ${TABLE}.created_at ;;
  }

  dimension: product_id {
    type: number
#    hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension_group: sold {
    type: time
    timeframes: [time, date, week, month, raw]
    sql: ${TABLE}.sold_at ;;
  }

    measure: count {
      type: count
    }

  measure: some_sum {
    type: sum
    sql: ${id} ;;
  }

}
