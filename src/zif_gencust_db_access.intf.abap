interface zif_gencust_db_access
  public .


  methods read
    importing
      !purpose      type zde_gencust_purpose
    returning
      value(result) type zcl_gencust_types=>values .
endinterface.
