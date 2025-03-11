interface zif_gencust_read
  public .
  methods read_single_value
    importing
      org_level      type clike
      key_value      type clike optional
      valid_from     type d default sy-datum
      username       type sy-uname default sy-uname
    exporting
      flag_not_found type abap_bool
    returning
      value(result)  type zde_gencust_value
    raising
      zcx_gencust_error.
  methods read_multiple_values
    importing
      org_level     type clike
      key_value     type clike optional
      valid_from    type d default sy-datum
      username      type sy-uname default sy-uname
    returning
      value(result) type zcl_gencust_types=>result_values
    raising
      zcx_gencust_error.
  methods read_all_values
    returning
      value(result) type zcl_gencust_types=>values
    raising
      zcx_gencust_inconsistent.
  methods read_structure
    importing
      org_level      type clike
      structure_ref  type ref to data
    exporting
      flag_not_found type abap_bool
    raising
      zcx_gencust_inconsistent.

endinterface.
