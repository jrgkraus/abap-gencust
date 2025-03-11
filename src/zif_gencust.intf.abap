interface zif_gencust
  public .


  methods single
    importing
      !org_level    type clike
      !key          type clike optional
      !valid_from   type d default sy-datum
      !username     type sy-uname default sy-uname
    returning
      value(result) type ref to zcl_gencust_single_result
    raising
      zcx_gencust_error.

  methods multi
    importing
      !org_level    type clike
      !key          type clike optional
      !valid_from   type d default sy-datum
      !username     type sy-uname default sy-uname
    returning
      value(result) type ref to zcl_gencust_multi_result
    raising
      zcx_gencust_error.

  methods all
    returning
      value(result) type ref to zcl_gencust_values_result .

  methods to_struct
    importing
      !org_level     type clike
      !structure_ref type ref to data
    returning
      value(result)  type ref to zcl_gencust_tostruct_result
    raising
      zcx_gencust_error.
endinterface.
