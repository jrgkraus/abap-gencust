*&---------------------------------------------------------------------*
*& Report zp_gencust_demo_orglevel
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zp_gencust_demo_orglevel.

selection-screen comment /1(80) dsc.

parameters plant type werks_d.
parameters nocust as checkbox.

class app definition.
  public section.
    methods main
      importing
        plant          type werks_d
        no_customizing type abap_bool.

  private section.
    constants parameter_purpose type zde_gencust_purpose value 'TEST_ORGLEVEL'.
    data settings_reader type ref to zif_gencust.
    METHODS instantiate_reader
      IMPORTING
        input TYPE abap_bool.
endclass.

class app implementation.

  method main.
    instantiate_reader( no_customizing ).

    try.
        data(settings_value) = settings_reader->single( plant ).
        if settings_value->is_ok( ).
          cl_demo_output=>display( |Value found: { settings_value->get_value( ) }| ).
        else.
          cl_demo_output=>display( settings_value->get_error( ) ).
        endif.
      catch zcx_gencust_error into data(e).
        message e type 'I' display like 'E'.
    endtry.
  endmethod.

  method instantiate_reader.

    settings_reader =
      cond #(
        when input = abap_true
          then zcl_gencust_factory=>get_main_nocust( parameter_purpose )
          else zcl_gencust_factory=>get_main( parameter_purpose ) ).

  endmethod.



endclass.

initialization.
  dsc = 'Demo: Read single value with org level criterion'.

start-of-selection.
  new app( )->main( plant = plant
                    no_customizing = nocust ).
