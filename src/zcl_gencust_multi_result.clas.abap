class zcl_gencust_multi_result definition
  public
  create public .

  public section.

    types self type ref to zcl_gencust_multi_result .

    class-methods ok
      importing
        !in           type zcl_gencust_types=>result_values
      returning
        value(result) type self .
    class-methods fail
      importing
        !in           type clike optional
      returning
        value(result) type self .
    methods constructor
      importing
        !failure   type abap_bool optional
        !error_msg type clike optional
        !value     type zcl_gencust_types=>result_values optional
          preferred parameter value .
    methods get_value
      returning
        value(result) type zcl_gencust_types=>result_values .
    methods get_error
      returning
        value(result) type string .
    methods is_ok
      returning
        value(result) type abap_bool .
    methods is_failure
      returning
        value(result) type abap_bool .
  private section.
    data value type zcl_gencust_types=>result_values.
    data failure type abap_bool.
    data error_msg type string.
endclass.



class zcl_gencust_multi_result implementation.


  method constructor.
    me->value = value.
    me->failure = failure.
    me->error_msg = error_msg.
  endmethod.


  method fail.
    result = new #( failure = abap_true
                    error_msg = in ).
  endmethod.


  method get_error.
    result = error_msg.
  endmethod.


  method get_value.
    result = value.
  endmethod.


  method is_failure.
    result = xsdbool( not is_ok( ) ).
  endmethod.


  method is_ok.
    result = xsdbool( failure = abap_false ).
  endmethod.


  method ok.
    result = new #( value = in ).
  endmethod.
endclass.
