class zcl_gencust_db_access2 definition
  public
  final
  create private

  global friends zcl_gencust_factory .

  public section.

    interfaces zif_gencust_db_access .
  protected section.
  private section.
endclass.



class zcl_gencust_db_access2 implementation.


  method zif_gencust_db_access~read.
    select from zdb_gencustit2
      fields *
      where purpose = @purpose
      into table @result.
  endmethod.
endclass.
