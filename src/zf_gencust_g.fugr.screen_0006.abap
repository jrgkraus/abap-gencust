PROCESS BEFORE OUTPUT.
 MODULE detail_init.
*
PROCESS AFTER INPUT.
 MODULE DETAIL_EXIT_COMMAND AT EXIT-COMMAND.
 MODULE DETAIL_SET_PFSTATUS.
 CHAIN.
    FIELD ZDB_GENCUSTHD2-PURPOSE .
    FIELD ZDB_GENCUSTHD2-SAP_MODULE .
    FIELD ZDB_GENCUSTHD2-REFERENCE_OBJECT .
    FIELD ZDB_GENCUSTHD2-DESCRIPTION .
    FIELD ZDB_GENCUSTHD2-ORGLEVEL_DESCR .
  MODULE SET_UPDATE_FLAG ON CHAIN-REQUEST.
 endchain.
 chain.
    FIELD ZDB_GENCUSTHD2-PURPOSE .
  module detail_pai.
 endchain.
