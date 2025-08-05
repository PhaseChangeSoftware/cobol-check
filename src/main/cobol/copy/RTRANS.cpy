      *
      * PCC (Phase Change Credit) Rejected Transaction File - 209 bytes
      *
       01  REJECTED-TRANSACTION-RECORD.
               05  RTRAN-ACC-NBR           PIC 9(16).
               05  RTRAN-TRANS-ID          PIC 9(20).
               05  RTRAN-DT-VAL            PIC 9(8).
               05  RTRAN-TM-VAL            PIC 9(6).
               05  RTRAN-CHG-AMT           PIC 9(8)V99.
               05  RTRAN-TYPE              PIC X.
                   88 RTRAN-DEBIT          VALUE 'D'.
                   88 RTRAN-CREDIT         VALUE 'C'.
               05  RTRAN-CUR-CD            PIC XXX.
               05  RTRAN-RET-CD            PIC 9(6).
               05  RTRAN-ATH-CD            PIC 9(6).
               05  RTRAN-TYP-CD            PIC X.
                   88 RTRAN-PAPER-ENTRY    VALUE 'P'.
                   88 RTRAN-MANUAL-ENTER   VALUE 'M'.
                   88 RTRAN-CARD-SWIPED    VALUE 'S'.
                   88 RTRAN-CHIP-READ      VALUE 'C'.
               05  RTRAN-ST-CD             PIC 9.
                   88 RTRAN-OK                 VALUE 0.
                   88 RTRAN-INVALID-ACCT       VALUE 1.
                   88 RTRAN-INVALID-DATE       VALUE 2.
                   88 RTRAN-INVALID-TIME       VALUE 3.
                   88 RTRAN-INVALID-AMOUNT     VALUE 4.
                   88 RTRAN-INVALID-TYPE       VALUE 5.
                   88 RTRAN-INVALID-CURRENCY   VALUE 6.
                   88 RTRAN-INVALID-RETAILER   VALUE 7.
                   88 RTRAN-INVALID-AUTH-CODE  VALUE 8.
                   88 RTRAN-INVALID-CODE       VALUE 9.
