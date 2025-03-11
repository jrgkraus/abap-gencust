class zcl_gencust_injector definition
  public
  abstract
  final
  create public
  for testing .

  public section.

    class-methods inject_db_access
      importing
        !object type ref to zif_gencust_db_access .
    class-methods inject_read
      importing
        !line type zcl_gencust_factory=>read_object .
    class-methods inject_main
      importing
        !line type zcl_gencust_factory=>main_object .
  protected section.
  private section.
endclass.



class zcl_gencust_injector implementation.


  method inject_db_access.
    zcl_gencust_factory=>db_access = object.
  endmethod.


  method inject_main.
    insert line into table zcl_gencust_factory=>main_objects.
  endmethod.


  method inject_read.
    insert line into table zcl_gencust_factory=>read_objects.
  endmethod.
endclass.
