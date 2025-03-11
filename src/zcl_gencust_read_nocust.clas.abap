class zcl_gencust_read_nocust definition
  public
  inheriting from zcl_gencust_read
  final
  create public .

  public section.

    methods constructor
      importing
        !i_purpose type zde_gencust_purpose .
  protected section.
    methods instantiate_db_access redefinition.
  private section.
endclass.



class zcl_gencust_read_nocust implementation.


  method constructor.

    super->constructor( i_purpose = i_purpose ).
    instantiate_db_access( ).
  endmethod.


  method instantiate_db_access.
    db_access = zcl_gencust_factory=>get_db_access2( ).
  endmethod.
endclass.
