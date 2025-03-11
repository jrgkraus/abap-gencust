class ZCX_GENCUST_INCONSISTENT definition
  public
  inheriting from ZCX_GENCUST_ERROR
  final
  create public .

public section.

  constants:
    begin of ZCX_GENCUST_INCONSISTENT,
      msgid type symsgid value 'ZM_GENCUST',
      msgno type symsgno value '001',
      attr1 type scx_attrname value 'PURPOSE',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of ZCX_GENCUST_INCONSISTENT .
  data PURPOSE type ZDE_GENCUST_PURPOSE .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !PURPOSE type ZDE_GENCUST_PURPOSE optional .
protected section.
private section.
ENDCLASS.



CLASS ZCX_GENCUST_INCONSISTENT IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->PURPOSE = PURPOSE .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = ZCX_GENCUST_INCONSISTENT .
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
