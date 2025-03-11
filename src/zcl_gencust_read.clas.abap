class zcl_gencust_read definition
  public
  create public .

  public section.

    interfaces zif_gencust_read .

    aliases read_all_values
      for zif_gencust_read~read_all_values .
    aliases read_multiple_values
      for zif_gencust_read~read_multiple_values .
    aliases read_single_value
      for zif_gencust_read~read_single_value .
    aliases read_structure
      for zif_gencust_read~read_structure .

    methods constructor
      importing
        !i_purpose type zde_gencust_purpose .
  protected section.
    data db_access type ref to zif_gencust_db_access .

    methods check_consistency
      importing
        one_value type line of zcl_gencust_types=>values
      raising
        zcx_gencust_inconsistent.
    methods instantiate_db_access.

  private section.


    data purpose type zde_gencust_purpose .
    data values type types=>values .
    data result_type type string .
    data org_level type zde_gencust_orglevel .
    data key_value type zde_gencust_key_value .
    data valid_from type d .
    data username type sy-uname .
    data values_for_date_to type zcl_gencust_types=>values_date_to .

    methods read_values
      raising
        zcx_gencust_inconsistent .
    methods get_result_type
      raising
        zcx_gencust_inconsistent .
    methods set_type_to_single
      raising
        zcx_gencust_inconsistent .
    methods set_type_to_multiple
      raising
        zcx_gencust_inconsistent .
    methods check_not_of_type
      importing
        !type type string
      raising
        zcx_gencust_wrong_call .
    methods filter_for_user
      returning
        value(result) type zcl_gencust_types=>values .
    methods filter_for_date
      importing
        !valid_from   type d
      returning
        value(result) type zcl_gencust_types=>values_date_to .

    methods search_low
      importing
        !username     type sy-uname
        !key_value    type clike
        !org_level    type clike
      returning
        value(result) type zcl_gencust_types=>values .
    methods raise_excep_para_inconsistent
      raising
        zcx_gencust_inconsistent .

    methods filter_values
      exporting
        flag_not_found type abap_bool
      returning
        value(result)  type zcl_gencust_types=>values .

    methods set_attributes
      importing
        org_level  type clike
        key_value  type clike
        valid_from type d
        username   type sy-uname .

    methods check_one_value_line
      importing
        value_line type zdb_gencustit
      raising
        zcx_gencust_inconsistent .
    methods extract_values
      importing
        filtered_for_user type zcl_gencust_types=>values
        first_value       type zdb_gencustit
      returning
        value(result)     type types=>values.

    methods extract_for_date_from
      importing
        valid_from    type d
      returning
        value(result) type types=>values_date_to.

    methods build_values_for_date_to.

    methods build_one_date_line
      importing
        val           type line of types=>values
        sorted_values type types=>values
      returning
        value(result) type types=>values_date_to.

    methods find_next_date_to
      importing
        val           type line of types=>values
        sorted_values type types=>values
      returning
        value(result) type d.


endclass.



class zcl_gencust_read implementation.


  method build_one_date_line.
    append corresponding #( val ) to result
      assigning field-symbol(<res>).
    <res>-date_to = find_next_date_to(
                      val           = val
                      sorted_values = sorted_values ).
  endmethod.


  method build_values_for_date_to.
    data(sorted_values) = values.
    sort sorted_values by valid_from ascending.

    values_for_date_to =
      value #( for val in sorted_values
             ( lines of build_one_date_line(
                          val           = val
                          sorted_values = sorted_values ) ) ).
  endmethod.


  method check_consistency.
    if one_value-counter > 1 and not
        line_exists( values[ org_level = one_value-org_level
                             key_value = one_value-key_value
                             username = one_value-username
                             valid_from = one_value-valid_from
                             counter = constants=>_1 ] ).
      raise_excep_para_inconsistent( ).
    endif.
  endmethod.


  method check_not_of_type.
    if result_type = type.
      raise exception type zcx_gencust_wrong_call
        exporting
          purpose = purpose.
    endif.
  endmethod.


  method check_one_value_line.
    if value_line-counter = 0.
      set_type_to_single( ).
    else.
      check_consistency( value_line ).
      set_type_to_multiple( ).
    endif.
  endmethod.


  method constructor.
    purpose = i_purpose.
    instantiate_db_access( ).
  endmethod.


  method extract_for_date_from.
    loop at values_for_date_to into data(val)
           where key_value = me->key_value and
                 org_level = me->org_level and
                 valid_from <= valid_from and
                 date_to > valid_from.
      append val to result.
      if result_type = constants=>result_type-single.
        exit.
      endif.
    endloop.
  endmethod.


  method extract_values.
    if result_type = constants=>result_type-single.
      append first_value to result.
    else.
      result =
        value #(
          for line in filtered_for_user
            where ( org_level = first_value-org_level and
                    key_value = first_value-key_value and
                    username = first_value-username )
            ( line ) ).
    endif.
  endmethod.


  method filter_for_date.
    result = extract_for_date_from( valid_from ).
  endmethod.


  method filter_for_user.
    result = search_low(
                username  = username
                key_value = key_value
                org_level = org_level ).
    if result is initial.
      result = search_low(
                  username  = space
                  key_value = key_value
                  org_level = org_level ).
    endif.
  endmethod.


  method filter_values.
    build_values_for_date_to( ).
    values_for_date_to = filter_for_date( valid_from ).
    data(filtered_for_user) = filter_for_user( ).
    flag_not_found = xsdbool( filtered_for_user is initial ).
    data(first_value) = value #( filtered_for_user[ 1 ] optional ).
    result = extract_values(
                filtered_for_user = filtered_for_user
                first_value        = first_value ).
    sort result by counter ascending.
  endmethod.


  method find_next_date_to.
    loop at sorted_values into data(val_date)
        where valid_from > val-valid_from.
      result = val_date-valid_from.
      exit.
    endloop.
    if sy-subrc is not initial.
      result = '99991231'.
    endif.
  endmethod.


  method get_result_type.
    result_type = constants=>result_type-undefined.
    loop at values into data(value).
      check_one_value_line( value ).
    endloop.
  endmethod.


  method instantiate_db_access.
    db_access = zcl_gencust_factory=>get_db_access( ).
  endmethod.


  method raise_excep_para_inconsistent.
    raise exception type zcx_gencust_inconsistent
      exporting
        purpose = purpose.
  endmethod.


  method read_values.
    if values is initial.
      values =
        db_access->read( purpose ).
      get_result_type( ).
      delete values where inactive = abap_true.
    endif.
  endmethod.


  method search_low.
    loop at values_for_date_to into data(val)
         where org_level = org_level
           and key_value = key_value
           and username = username.
      append val to result.
    endloop.
  endmethod.


  method set_attributes.
    me->org_level = org_level.
    me->key_value = key_value.
    me->valid_from = valid_from.
    me->username = username.
  endmethod.


  method set_type_to_multiple.
    if result_type = constants=>result_type-single.
      raise_excep_para_inconsistent( ).
    endif.
    result_type = constants=>result_type-multiple.
  endmethod.


  method set_type_to_single.
    if result_type = constants=>result_type-multiple.
      raise_excep_para_inconsistent( ).
    endif.
    result_type = constants=>result_type-single.
  endmethod.


  method zif_gencust_read~read_all_values.
    read_values( ).
    result = values.
  endmethod.


  method zif_gencust_read~read_multiple_values.
    set_attributes(
      org_level  = org_level
      key_value  = key_value
      valid_from = valid_from
      username   = username ).
    read_values( ).
    check_not_of_type( constants=>result_type-single ).
    result =
      value #(
        for val in filter_values( )
                      ( val-value ) ).
  endmethod.


  method zif_gencust_read~read_single_value.
    set_attributes(
      org_level  = org_level
      key_value  = key_value
      valid_from = valid_from
      username   = username ).
    read_values( ).
    check_not_of_type( constants=>result_type-multiple ).
    data(filtered_values) =
      filter_values(
        importing flag_not_found = flag_not_found ).
    try.
        result = filtered_values[ 1 ]-value.
      catch cx_sy_itab_line_not_found.
        flag_not_found = abap_true.
    endtry.
  endmethod.


  method zif_gencust_read~read_structure.
    read_values( ).
    field-symbols <structure> type any.
    field-symbols <value> type any.
    assign structure_ref->* to <structure>.
    loop at values into data(line) where org_level = org_level.
      data(abap_name) = from_mixed( val = line-key_value sep = '_' ).
      assign component abap_name of structure <structure> to <value>.
      if sy-subrc = 0.
        <value> = line-value.
      endif.
    endloop.
    if sy-subrc <> 0.
      flag_not_found = abap_true.
    endif.
  endmethod.
endclass.
