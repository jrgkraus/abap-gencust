class zcl_gencust_db_access definition
  public
  final
  create private

  global friends zcl_gencust_factory .

  public section.

    interfaces zif_gencust_db_access .
  protected section.
  private section.
endclass.



class zcl_gencust_db_access implementation.


  method zif_gencust_db_access~read.
    select from zdb_gencustit
      fields *
      where purpose = @purpose
      into table @result.
  endmethod.
endclass.
