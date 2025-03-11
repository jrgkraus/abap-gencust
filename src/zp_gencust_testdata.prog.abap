*&---------------------------------------------------------------------*
*& Report zp_gencust_testdata
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zp_gencust_testdata.

define _header.
  insert value #(
     purpose  = &1
     sap_module  = &2
     reference_object  = &3
     description  = &4
     orglevel_descr  = &5 ) into table headers.
end-of-definition.

define _item.
  insert value #(
     purpose  = &1
     org_level  = &2
     key_value  = &3
     valid_from  = &4
     username  = &5
     counter  = &6
     value  = &7
     inactive  = &8
     description  = &9 ) into table items..
end-of-definition.

selection-screen comment /1(80) dsc.

parameters create radiobutton group 1.
parameters delete radiobutton group 1.
parameters nocust as checkbox.

data headers type standard table of zdb_gencusthd with empty key.
data items type standard table of zdb_gencustit with empty key.

initialization.
  dsc = 'This report will create or delete some test data'.

start-of-selection.
  _header:
    'TEST_ORGLEVEL' 'BC' 'ZCL_GENCUST_TEST' 'Test with orglevel' 'Plant',
    'TEST_OPTIONAL_KEY' 'BC' 'ZCL_GENCUST_TEST' 'Test with optional key' 'Plant, key: storage location',
    'TEST_MULTIPLE_VALUE' 'BC' 'ZCL_GENCUST_TEST' 'Test for multiple values' 'Plant',
    'TEST_STRUCTURED' 'BC' 'ZCL_GENCUST_TEST' 'Test for structured value' 'Plant'.

  _item:
    'TEST_ORGLEVEL' '0001' '' '' '' '' 'VALUE1' '' '',
    'TEST_ORGLEVEL' '0002' '' '' '' '' 'VALUE2' '' '',
    'TEST_OPTIONAL_KEY' '0001' '0010' '' '' '' 'VALUE1_10' '' '',
    'TEST_OPTIONAL_KEY' '0001' '0020' '' '' '' 'VALUE1_20' '' '',
    'TEST_MULTIPLE_VALUE' '0001' '' '' '' '0001' 'VALUE1(1)' '' '',
    'TEST_MULTIPLE_VALUE' '0001' '' '' '' '0002' 'VALUE1(2)' '' '',
    'TEST_STRUCTURED' '0001' 'firstComponent' '' '' '' 'VALUE1_first' '' '',
    'TEST_STRUCTURED' '0001' 'secondComponent' '' '' '' 'VALUE1_second' '' '',
    'TEST_STRUCTURED' '0002' 'firstComponent' '' '' '' 'VALUE2_first' '' '',
    'TEST_STRUCTURED' '0002' 'secondComponent' '' '' '' 'VALUE2_second' '' ''.

try.
  if create = abap_true.
    if nocust = abap_true.
      insert zdb_gencusthd2 from table @headers.
      insert zdb_gencustit2 from table @items.
      write 'Created test values for non-customizing case'.
    else.
      insert zdb_gencusthd from table @headers.
      insert zdb_gencustit from table @items.
      write 'Created test values for customizing case'.
    endif.
  else.
    if nocust = abap_true.
      delete zdb_gencusthd2 from table @headers.
      write: sy-dbcnt, 'deleted from non-customizing header table'.
      delete zdb_gencustit2 from table @items.
      write: sy-dbcnt, 'deleted from non-customizing item table'.
    else.
      delete zdb_gencusthd from table @headers.
      write: sy-dbcnt, 'deleted from customizing header table'.
      delete zdb_gencustit from table @items.
      write: sy-dbcnt, 'deleted from customizing item table'.
    endif.

  endif.

  catch CX_SY_OPEN_SQL_DB into data(cx).
    message cx type 'I'.
endtry.
