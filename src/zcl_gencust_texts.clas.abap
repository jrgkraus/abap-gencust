class zcl_gencust_texts definition
  public
  abstract
  create public .

  public section.

    class-data:
      begin of fail,
        not_found type text132,
      end of fail .

    class-methods class_constructor .
  protected section.
  private section.
endclass.



class zcl_gencust_texts implementation.


  method class_constructor.
    fail =
      value #(
        not_found = 'No value has been found'(001) ).
  endmethod.
endclass.
