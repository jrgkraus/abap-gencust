class zcl_gencust_constants definition
    public
    abstract
    create public.
  public section.
    constants: begin of result_type,
                 undefined type string value ``,
                 single    type string value `single`,
                 multiple  type string value `multiple`,
                 all       type string value `all`,
               end of result_type.

    constants _1 type zde_gencust_counter value 1.

    constants initial_date type d value '00000000'.
endclass.



class zcl_gencust_constants implementation.
endclass.
