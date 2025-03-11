class zcl_gencust definition
  public
  create private

  global friends zcl_gencust_factory .

  public section.

    interfaces zif_gencust .

    methods constructor
      importing
        !purpose        type zde_gencust_purpose
        !no_customizing type abap_bool .
  protected section.
  private section.
    data base type ref to zif_gencust_read.
endclass.



class zcl_gencust implementation.


  method constructor.
    base =
      cond #(
        when no_customizing = abap_true
          then cast #( new zcl_gencust_read_nocust( purpose ) )
          else cast #( new zcl_gencust_read( purpose ) ) ).
  endmethod.


  method zif_gencust~all.
    try.
        result = zcl_gencust_values_result=>ok( base->read_all_values( ) ).
      catch zcx_gencust_inconsistent into data(e).
        result = zcl_gencust_values_result=>fail( e->get_text( ) ).
    endtry.
  endmethod.


  method zif_gencust~multi.
    try.
        data(value) =
          base->read_multiple_values(
            org_level = org_level
            key_value = key
            valid_from = valid_from
            username = username ).

        result =
          cond #(
            when value is initial
              then zcl_gencust_multi_result=>fail( texts=>fail-not_found )
              else zcl_gencust_multi_result=>ok( value ) ).
      catch zcx_gencust_error into data(e).
        result = zcl_gencust_multi_result=>fail( e->get_text( ) ).
    endtry.

  endmethod.


  method zif_gencust~single.
    data flag_not_found type abap_bool.
    try.
        data(value) =
          base->read_single_value(
            exporting
              org_level = org_level
              key_value = key
              valid_from = valid_from
              username = username
            importing
              flag_not_found = flag_not_found ).

        result =
          cond #(
            when flag_not_found = abap_true
              then zcl_gencust_single_result=>fail( texts=>fail-not_found )
            else zcl_gencust_single_result=>ok( value ) ).
      catch zcx_gencust_error into data(e).
        result = zcl_gencust_single_result=>fail( e->get_text( ) ).
    endtry.

  endmethod.


  method zif_gencust~to_struct.
    data flag_not_found type abap_bool.
    try.
        base->read_structure(
          exporting
            org_level = org_level
            structure_ref = structure_ref
          importing
            flag_not_found = flag_not_found ).

        result =
          cond #(
            when flag_not_found = abap_true
              then zcl_gencust_tostruct_result=>fail( texts=>fail-not_found )
            else zcl_gencust_tostruct_result=>ok( ) ).
      catch zcx_gencust_inconsistent into data(e).
        result = zcl_gencust_tostruct_result=>fail( e->get_text( ) ).
    endtry.
  endmethod.
endclass.
