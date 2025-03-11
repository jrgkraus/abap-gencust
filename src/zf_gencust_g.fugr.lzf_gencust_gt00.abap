*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZDB_GENCUSTHD...................................*
DATA:  BEGIN OF STATUS_ZDB_GENCUSTHD                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZDB_GENCUSTHD                 .
CONTROLS: TCTRL_ZDB_GENCUSTHD
            TYPE TABLEVIEW USING SCREEN '0001'.
*...processing: ZDB_GENCUSTHD2..................................*
DATA:  BEGIN OF STATUS_ZDB_GENCUSTHD2                .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZDB_GENCUSTHD2                .
CONTROLS: TCTRL_ZDB_GENCUSTHD2
            TYPE TABLEVIEW USING SCREEN '0005'.
*...processing: ZVI_GENCUSTIT...................................*
TABLES: ZVI_GENCUSTIT, *ZVI_GENCUSTIT. "view work areas
CONTROLS: TCTRL_ZVI_GENCUSTIT
TYPE TABLEVIEW USING SCREEN '0003'.
DATA: BEGIN OF STATUS_ZVI_GENCUSTIT. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZVI_GENCUSTIT.
* Table for entries selected to show on screen
DATA: BEGIN OF ZVI_GENCUSTIT_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZVI_GENCUSTIT.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVI_GENCUSTIT_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZVI_GENCUSTIT_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZVI_GENCUSTIT.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVI_GENCUSTIT_TOTAL.

*...processing: ZVI_GENCUSTIT2..................................*
TABLES: ZVI_GENCUSTIT2, *ZVI_GENCUSTIT2. "view work areas
CONTROLS: TCTRL_ZVI_GENCUSTIT2
TYPE TABLEVIEW USING SCREEN '0004'.
DATA: BEGIN OF STATUS_ZVI_GENCUSTIT2. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZVI_GENCUSTIT2.
* Table for entries selected to show on screen
DATA: BEGIN OF ZVI_GENCUSTIT2_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZVI_GENCUSTIT2.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVI_GENCUSTIT2_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZVI_GENCUSTIT2_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZVI_GENCUSTIT2.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVI_GENCUSTIT2_TOTAL.

*.........table declarations:.................................*
TABLES: *ZDB_GENCUSTHD                 .
TABLES: *ZDB_GENCUSTHD2                .
TABLES: ZDB_GENCUSTHD                  .
TABLES: ZDB_GENCUSTHD2                 .
TABLES: ZDB_GENCUSTIT                  .
TABLES: ZDB_GENCUSTIT2                 .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
