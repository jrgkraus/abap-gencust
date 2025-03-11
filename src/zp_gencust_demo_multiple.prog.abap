*&---------------------------------------------------------------------*
*& Report zp_gencust_demo_orglevel
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zp_gencust_demo_multiple.

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
    constants parameter_purpose type zde_gencust_purpose value 'TEST_MULTIPLE_VALUE'.
    data settings_reader type ref to zif_gencust.
    METHODS instantiate_reader
      IMPORTING
        input TYPE abap_bool.
endclass.

class app implementation.

  method main.
    instantiate_reader( no_customizing ).

    try.
        data(settings_values) = settings_reader->multi( plant ).
        if settings_values->is_ok( ).
          cl_demo_output=>display(
            |Values found: {
              reduce string( init s = ``
              for line in settings_values->get_value( )
              next s = cond #(
                when s is initial then conv #( line )
                else s && `, ` && line ) ) }|  ).
        else.
          cl_demo_output=>display( settings_values->get_error( ) ).
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
  dsc = 'Demo: Read multiple values with org level criterion'.

start-of-selection.
  new app( )->main( plant = plant
                    no_customizing = nocust ).
