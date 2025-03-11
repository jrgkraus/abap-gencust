*&---------------------------------------------------------------------*
*& Report zp_gencust_demo_orglevel
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zp_gencust_demo_opt_key.

selection-screen comment /1(80) dsc.

parameters plant type werks_d.
parameters stloc type lgort_d.
parameters nocust as checkbox.

class app definition.
  public section.
    methods main
      importing
        plant          type werks_d
        storage_loc    type lgort_d
        no_customizing type abap_bool.

  private section.
    constants parameter_purpose type zde_gencust_purpose value 'TEST_OPTIONAL_KEY'.
    data settings_reader type ref to zif_gencust.
    methods instantiate_reader
      importing
        input type abap_bool.
endclass.

class app implementation.

  method main.
    instantiate_reader( no_customizing ).

    try.
        data(settings_value) =
          settings_reader->single(
            org_level = plant
            key = storage_loc ).
        if settings_value->is_ok( ).
          cl_demo_output=>display( |Level { plant }, key { storage_loc }, value found: { settings_value->get_value( ) }| ).
        else.
          cl_demo_output=>display( |Level { plant }, key { storage_loc }, { settings_value->get_error( ) }| ).
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
  dsc = 'Demo: Read single value with org level and optional key value'.

start-of-selection.
  new app( )->main( plant = plant
                    storage_loc = stloc
                    no_customizing = nocust ).
