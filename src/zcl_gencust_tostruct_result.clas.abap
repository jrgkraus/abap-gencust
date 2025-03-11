class zcl_gencust_tostruct_result definition
  public
  create public .

  public section.

    types self type ref to zcl_gencust_tostruct_result .

    class-methods ok
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
        !error_msg type string optional .
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
    data failure type abap_bool.
    data error_msg type string.
endclass.



class zcl_gencust_tostruct_result implementation.


  method constructor.
    me->failure = failure.
    me->error_msg = error_msg.
  endmethod.


  method fail.
    result = new #( failure = abap_true
                    error_msg = |{ in }| ).
  endmethod.


  method get_error.
    result = error_msg.
  endmethod.


  method is_failure.
    result = xsdbool( not is_ok( ) ).
  endmethod.


  method is_ok.
    result = xsdbool( failure = abap_false ).
  endmethod.


  method ok.
    result = new #( ).
  endmethod.
endclass.
