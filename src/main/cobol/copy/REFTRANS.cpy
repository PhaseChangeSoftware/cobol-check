      *
      * PCC (Phase Change Credit) Rejected Refund Transaction File - 209 bytes
      *
        01  REFTRAN-REFUND-RECORD.
            05  REFTRAN-REJECTION-RECORD.
                10  REFTRAN-ACC-NBR           PIC 9(16).
                10  REFTRAN-TRANS-ID          PIC 9(20).
                10  REFTRAN-DT-VAL            PIC 9(8).
                10  REFTRAN-TM-VAL            PIC 9(6).
                10  REFTRAN-CHG-AMT           PIC 9(8)V99.
                10  REFTRAN-TYPE              PIC X.
                   88 REFTRAN-DEBIT          VALUE 'D'.
                   88 REFTRAN-CREDIT         VALUE 'C'.
                10  REFTRAN-CUR-CD            PIC XXX.
                10  REFTRAN-RET-CD            PIC 9(6).
                10  REFTRAN-ATH-CD            PIC 9(6).
                10  REFTRAN-TYP-CD            PIC X.
                   88 REFTRAN-PAPER-ENTRY    VALUE 'P'.
                   88 REFTRAN-MANUAL-ENTER   VALUE 'M'.
                   88 REFTRAN-CARD-SWIPED    VALUE 'S'.
                   88 REFTRAN-CHIP-READ      VALUE 'C'.
                10  REFTRAN-ST-CD             PIC 9.
                   88 REFTRAN-OK                 VALUE 0.
                   88 REFTRAN-INVALID-ACCT       VALUE 1.
                   88 REFTRAN-INVALID-DATE       VALUE 2.
                   88 REFTRAN-INVALID-TIME       VALUE 3.
                   88 REFTRAN-INVALID-AMOUNT     VALUE 4.
                   88 REFTRAN-INVALID-TYPE       VALUE 5.
                   88 REFTRAN-INVALID-CURRENCY   VALUE 6.
                   88 REFTRAN-INVALID-RETAILER   VALUE 7.
                   88 REFTRAN-INVALID-AUTH-CODE  VALUE 8.
                   88 REFTRAN-INVALID-CODE       VALUE 9.
            05  REFTRAN-RETAILER-INFO.
                10 REFTRAN-RET-KEY.
                      15 REFTRAN-RET-KEY-BASE       PIC 9(20).
                      15 REFTRAN-RET-KEY-SEQ        PIC 9(2).
                10 REFTRAN-NAME           PIC X(20).
                10 REFTRAN-ADDR1          PIC X(30).
                10 REFTRAN-ADDR2          PIC X(30).
                10 REFTRAN-CITY           PIC X(20).
                10 REFTRAN-STATE          PIC X(2).
                10 REFTRAN-ZIP            PIC X(9).
                10 REFTRAN-PHONE          PIC X(20).
                10 REFTRAN-EMAIL          PIC X(20).
            05  REFTRAN-REMAINING-AMT     PIC 9(8)V99.
            05  REFTRAN-REFUNDED-AMT     PIC 9(8)V99.
