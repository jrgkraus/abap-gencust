class zcl_gencust_types definition
  public
  abstract
  create public .

  public section.

    types:
      values type standard table of zdb_gencustit with empty key .
    types:
      result_values type standard table of zde_gencust_value with empty key .
    types:
      begin of value_date_to.
        include type zdb_gencustit.
        types:  date_to type d,
      end of value_date_to .
    types:
      values_date_to type standard table of value_date_to
               with empty key .
endclass.



class zcl_gencust_types implementation.
endclass.
