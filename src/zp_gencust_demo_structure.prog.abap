*&---------------------------------------------------------------------*
*& Report zp_gencust_demo_orglevel
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zp_gencust_demo_structure.

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
    constants parameter_purpose type zde_gencust_purpose value 'TEST_STRUCTURED'.
    data settings_reader type ref to zif_gencust.
    METHODS instantiate_reader
      IMPORTING
        input TYPE abap_bool.
endclass.

class app implementation.

  method main.
    instantiate_reader( no_customizing ).

    " for capturing the customizing data, a structure is used
    " the component name is stored in the key value of zdb_gencustit
    " you can use camelCase in customizing, it will be converted to snake_case
    " for instance:
    " org_level  key_value                 value
    " 0001       firstComponent            VALUE1_first
    " 0001       secondComponent           VALUE1_second
    data:
      begin of structure,
         first_component type string,
         second_component type string,
      end of structure.

    try.
        data(read_result) = settings_reader->to_struct(
          org_level = plant
          structure_ref = ref #( structure ) ).
        if read_result->is_ok( ).
          cl_demo_output=>display(
            structure  ).
        else.
          cl_demo_output=>display( read_result->get_error( ) ).
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
  dsc = 'Demo: Read multiple values into structured data'.

start-of-selection.
  new app( )->main( plant = plant
                    no_customizing = nocust ).
