class zcl_gencust_factory definition
  public
  create private

  global friends zcl_gencust_injector .

  public section.

    class-methods get_db_access
      returning
        value(result) type ref to zif_gencust_db_access .
    class-methods get_db_access2
      returning
        value(result) type ref to zif_gencust_db_access .
    class-methods get_read
      importing
        !purpose      type zde_gencust_purpose
      returning
        value(result) type ref to zif_gencust_read .
    class-methods get_main
      importing
        !purpose        type zde_gencust_purpose
        !no_customizing type abap_bool optional
      returning
        value(result)   type ref to zif_gencust .
    class-methods get_main_nocust
      importing
        !purpose      type zde_gencust_purpose
      returning
        value(result) type ref to zif_gencust .
  private section.
    types: begin of read_object,
             purpose type zde_gencust_purpose,
             object  type ref to zif_gencust_read,
           end of read_object.
    class-data db_access type ref to zif_gencust_db_access.
    class-data db_access2 type ref to zif_gencust_db_access.
    class-data read_objects type standard table of read_object with empty key.
    types: begin of main_object,
             purpose type zde_gencust_purpose,
             object  type ref to zif_gencust,
           end of main_object.
    class-data main_objects type standard table of main_object with empty key.

    class-methods get_read_object
      importing
        purpose       type zde_gencust_purpose
        buffered      type zcl_gencust_factory=>read_object
      returning
        value(result) type ref to zif_gencust_read.

    class-methods get_buffered_read
      importing
        purpose       type zde_gencust_purpose
      returning
        value(result) type zcl_gencust_factory=>read_object.

    class-methods buffer_read_object
      importing
        purpose  type zde_gencust_purpose
        i_result type ref to zif_gencust_read.

    class-methods get_main_object
      importing
        purpose        type zde_gencust_purpose
        no_customizing type abap_bool
        buffered       type zcl_gencust_factory=>main_object
      returning
        value(result)  type ref to zif_gencust.

    class-methods get_buffered_main
      importing
        purpose       type zde_gencust_purpose
      returning
        value(result) type zcl_gencust_factory=>main_object.

    class-methods buffer_main_object
      importing
        purpose  type zde_gencust_purpose
        i_result type ref to zif_gencust.


endclass.



class zcl_gencust_factory implementation.


  method buffer_main_object.

    if get_buffered_main( purpose ) is initial.
      insert value #( purpose = purpose
                      object = i_result ) into table main_objects.
    endif.

  endmethod.


  method buffer_read_object.

    if get_buffered_read( purpose ) is initial.
      insert value #( purpose = purpose
                      object = i_result ) into table read_objects.
    endif.

  endmethod.


  method get_buffered_main.
    result = value #( main_objects[ purpose = purpose ] optional ).
  endmethod.


  method get_buffered_read.
    result = value #( read_objects[ purpose = purpose ] optional ).
  endmethod.


  method get_db_access.
    result = cond #(
               when db_access is bound
                then db_access
               else new zcl_gencust_db_access( ) ).
  endmethod.


  method get_db_access2.
    result = cond #(
               when db_access2 is bound
                then db_access2
               else new zcl_gencust_db_access2( ) ).
  endmethod.


  method get_main.
    result = get_main_object(
      purpose  = purpose
      no_customizing = no_customizing
      buffered = get_buffered_main( purpose ) ).
    buffer_main_object(
      purpose = purpose
      i_result  = result ).
  endmethod.


  method get_main_nocust.
    result =
      get_main(
        purpose = purpose
        no_customizing = abap_true ).
  endmethod.


  method get_main_object.
    result =
      cond #(
        when buffered is not initial
          then buffered-object
        else
          cast #(
            new zcl_gencust(
                  purpose = purpose
                  no_customizing = no_customizing ) ) ).
  endmethod.


  method get_read.
    result = get_read_object(
      purpose  = purpose
      buffered = get_buffered_read( purpose ) ).
    buffer_read_object(
      purpose = purpose
      i_result  = result ).
  endmethod.


  method get_read_object.
    result = cond #(  when buffered is not initial
                          then buffered-object
                          else cast #( new zcl_gencust_read( purpose ) ) ).
  endmethod.
endclass.
