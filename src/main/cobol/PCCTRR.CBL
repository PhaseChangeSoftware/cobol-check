000010 IDENTIFICATION DIVISION.                                         00000010
000020 PROGRAM-ID. PCCTRR.                                              00000020
000050*-----------------------------------------------------------
      *
      * PCCTRR - Phase Change Credit Rejection and Refund Processing
      *
      * Program to apply retailer refunds to credit cart transaction
      * were rejected
      *-----------------------------------------------------------
000750******************************************************************00000750
000760 ENVIRONMENT DIVISION.                                            00000760
000770 CONFIGURATION SECTION.                                           00000770
000780 OBJECT-COMPUTER. IBM-4341.                                       00000780
000790 SOURCE-COMPUTER. IBM-4341.                                       00000790
000800 SPECIAL-NAMES.                                                   00000800
000810      C01 IS TOP-OF-PAGE.                                         00000810
000820     EJECT                                                        00000820
000830 INPUT-OUTPUT SECTION.                                            00000830
000840 FILE-CONTROL.                                                    00000840
000850                                                                  00000850
000860     SELECT PRINT-FILE                                            00000860
000870            ASSIGN PRINT.                                         00000870
000880                                                                  00000880
000890     SELECT REJECT-IN-FILE                                        00000890
000900            ASSIGN REJECT.                                        00000900
000910                                                                  00000910
000920     SELECT REFUND-OUT-FILE                                       00000920
000930            ASSIGN REFUND.                                        00000930
000940                                                                  00000940
000950     SELECT CHARGES-V-MASTER                                      00000950
000960            ASSIGN CHARGES                                        00000960
000970            ORGANIZATION INDEXED                                  00000970
000980            ACCESS DYNAMIC                                        00000980
000990            RECORD KEY IS CHG-KEY                                 00000990
001000            FILE STATUS IS WS-CHG-STATUS.                         00001000
001010                                                                  00001010
001160     SELECT RETAILER-REFS                                         00001160
001170            ASSIGN RETREF                                         00001170
001180            ORGANIZATION INDEXED                                  00001180
001190            ACCESS RANDOM                                         00001190
001200            RECORD KEY IS RETREFS-KEY                             00001200
001210            FILE STATUS IS WS-RETREF-STATUS.                      00001210
001220                                                                  00001220
001510     SELECT LATEST-REFS                                           00001510
001520            ASSIGN DAYREF                                         00001520
001530            ORGANIZATION INDEXED                                  00001530
001540            ACCESS RANDOM                                         00001540
001550            RECORD KEY IS LATEST-REF-KEY                          00001550
001560            FILE STATUS IS WS-LATEST-STATUS.                      00001560
001640                                                                  00001640
001650     SELECT SURCHARGE-PAIDS                                       00001650
001660            ASSIGN       TO SURCH                                 00001660
001670            ORGANIZATION IS INDEXED                               00001670
001680            ACCESS       IS RANDOM                                00001680
001690            RECORD KEY   IS SURCH-KEY                             00001690
001700            FILE STATUS  IS WS-SURCH-STATUS.                      00001700
001710                                                                  00001710
001720     EJECT                                                        00001720
001730 DATA DIVISION.                                                   00001730
001740 FILE SECTION.                                                    00001740
001750                                                                  00001750
001760 FD  PRINT-FILE                                                   00001760
001770     RECORDING MODE IS F                                          00001770
001780     LABEL RECORDS ARE OMITTED                                    00001780
001790     RECORD CONTAINS 133 CHARACTERS                               00001790
001800     DATA RECORD IS PRINT-REC                                     00001800
001810     BLOCK CONTAINS 0.                                            00001810
001820 01  PRINT-REC.                                                   00001820
001830     05  FILLER               PIC X(133).                         00001830
001840                                                                  00001840
001850                                                                  00001850
001860 FD  REJECT-IN-FILE                                               00001860
001870     BLOCK CONTAINS 0  RECORDS                                    00001870
WBC        RECORD CONTAINS 77 CHARACTERS                                00001880
001890     LABEL RECORDS ARE STANDARD.                                  00001890
001900 01  REJECT-IN-REC.                                               00001900
WBC        05  FILLER          PIC X(77).                               00001910
001920                                                                  00001920
001930                                                                  00001930
001940 FD  REFUND-OUT-FILE                                              00001940
001950     BLOCK CONTAINS 0  RECORDS                                    00001950
WBC        RECORD CONTAINS 260 CHARACTERS                               00001960
001970     LABEL RECORDS ARE STANDARD.                                  00001970
001980 01  REF-OUT-REC.                                                 00001980
WBC        05  FILLER          PIC X(260).                              00001990
002000                                                                  00002000
WBC****    ************************************************************ 00002010
WBC****    ****** CHANGE SALES FILE LAYOUT - KEY STRUCTURE CHANGE ***** 00002010
WBC****    ************************************************************ 00002010
002020 FD  CHARGES-V-MASTER                                             00002020
002030     LABEL RECORDS ARE STANDARD.                                  00002030

       01  CHG-REC.                                                     00002040
           05  CHG-KEY  PIC S9(20).                                     00002080
           05  CHG-ERR-IND   PIC X.
           05  CHG-COUNT  PIC S9(5).                                    00002080
           05  CHG-AMT  PIC S9(10).                                     00002080
           05  CHG-RETAILER-INFO.
               10 CHG-RET-ID        PIC 9(20).
               10 CHG-NAME           PIC X(20).
               10 CHG-ADDR1          PIC X(30).
               10 CHG-ADDR2          PIC X(30).
               10 CHG-CITY           PIC X(20).
               10 CHG-STATE          PIC X(2).
               10 CHG-ZIP            PIC X(9).
               10 CHG-PHONE          PIC X(20).
               10 CHG-EMAIL          PIC X(20).
002150                                                                  00002150
002260     EJECT                                                        00002260
002600                                                                  00002600
002610 FD  RETAILER-REFS                                                00002610
002620     LABEL RECORDS ARE STANDARD.                                  00002620
002630 01  RETREFS-REC.                                                 00002630
002650     05  RETREFS-KEY .                                            00002650
002660         10  RETREFS-ID              PIC 9(20).                   00002660
002660         10  RETREFS-SEQ              PIC 9(5).                   00002660
002670     05  RETREFS-AMT              PIC S9(9)V99   COMP-3.          00002670
002680                                                                  00002680
002790     EJECT                                                        00002790
003100                                                                  00003100
003110 FD  LATEST-REFS                                                  00003110
003120     LABEL RECORDS ARE STANDARD.                                  00003120
003130 01  LATEST-REF-REC.                                              00003130
003150     05  LATEST-REF-KEY             PIC S9(20).                   00003150
003170     05  LATEST-REF-AMT             PIC S9(9)V99   COMP-3.        00003170
003180                                                                  00003180
003190                                                                  00003190
003200 FD  SURCHARGE-PAIDS                                              00003200
003210     LABEL RECORDS ARE STANDARD.                                  00003210
003220 01  SURCH-RECORD.                                                00003220
003240     03 SURCH-KEY     PIC S9(20).                                 00003240
003250     03 FILLER            PIC X(70).                              00003250
003260                                                                  00003260
003270                                                                  00003270
003280     EJECT                                                        00003280
003290 WORKING-STORAGE SECTION.                                         00003290
003300******************************************************************00003300
003310******************************************************************00003310
003330 77  WS-CHG-STATUS          PIC 99     VALUE ZEROES.              00003330
003360 77  WS-RETREF-STATUS          PIC 99     VALUE ZEROES.           00003360
003380 77  WS-LATEST-STATUS           PIC 99     VALUE ZEROES.          00003380
003420 77  WS-SURCH-STATUS          PIC 99     VALUE ZEROES.            00003420
003430 77  WS-ERR-IND              PIC X      VALUE SPACES.             00003430
003470 77  WS-REFUND-SOFAR             PIC S9(9)V99 COMP-3 VALUE ZEROES.00003470
003480 77  WS-REMAINING              PIC S9(9)V99 COMP-3 VALUE ZEROES.  00003480
003490 77  WS-RETREF-CNT             PIC S9(11)   COMP-3 VALUE ZEROES.  00003490
003520 77  PAGENO                  PIC 9(4)   VALUE ZERO.               00003520
003530 77  LINE-COUNT              PIC 9(5)   VALUE ZERO.               00003530
003540 77  REF-IN-CNT             PIC 9(9)   VALUE ZERO.                00003540
003550 77  REC-NO-CHG       PIC 9(9)   VALUE ZERO.                      00003550
003560 77  REC-SURCH          PIC 9(9)   VALUE ZERO.                    00003560
003590 77  TOT-OUT-CNT             PIC 9(9)   VALUE ZERO.               00003590
003600 77  REC-OUT-GOOD            PIC 9(9)   VALUE ZERO.               00003600
003610 77  REC-OUT-MANUAL-REV      PIC 9(9)   VALUE ZERO.               00003610
003620 77  REF-IN-AMT             PIC 9(11)V99 VALUE ZERO.              00003620
003630 77  AMT-NO-CHG       PIC 9(11)V99  VALUE ZERO.                   00003630
003640 77  AMT-SURCH          PIC 9(11)V99  VALUE ZERO.                 00003640
003650 77  AMT-SAME-MO-PAID        PIC 9(11)V99  VALUE ZERO.            00003650
003670 77  TOT-OUT-AMT             PIC 9(11)V99  VALUE ZERO.            00003670
003680 77  AMT-OUT-GOOD            PIC 9(11)V99  VALUE ZERO.            00003680
003700 77  WS-READ-IND             PIC X              VALUE '1'.        00003700
003720 77  WS-REFUND-FIND-CNT        PIC S9(3)    COMP-3  VALUE ZERO.   00003720
003730 77  WS-REFUND-FOUND-CNT       PIC S9(3)    COMP-3  VALUE ZERO.   00003730
003740 77  WS-STILL-AVAIL-CNT    PIC 9(9)     VALUE ZERO.               00003740
003750 77  WS-STILL-AVAIL-AMT    PIC 9(11)V99 VALUE ZERO.               00003750
003780 77  WS-FILE-IND             PIC X(6)   VALUE SPACES.             00003780
003790     EJECT                                                        00003790
003800 01  TIT-1.                                                       00003800
003810     05  FILLER              PIC X(9)    VALUE '  PCCTRR '.       00003810
003820     05  FILLER              PIC X(31)   VALUE SPACES.            00003820
003830     05  FILLER              PIC X(50)   VALUE                    00003830
003840     'REFUND CHARGES EDIT CONTROL REPORT # 3            '.        00003840
003850     05  FILLER              PIC X(14)   VALUE SPACES.            00003850
003860     05  FILLER              PIC X(6)    VALUE 'DATE: '.          00003860
003870     05  PRT-DATE            PIC X(8)    VALUE SPACES.            00003870
003880     05  FILLER              PIC XX      VALUE SPACES.            00003880
003890     05  FILLER              PIC X(5)    VALUE 'PAGE '.           00003890
003900     05  PRT-PG              PIC Z,ZZ9.                           00003900
003910     05  FILLER              PIC XXX     VALUE SPACES.            00003910
003920 01  TIT-2.                                                       00003920
003930     05  FILLER              PIC X(12)   VALUE SPACES.            00003930
003940     05  FILLER              PIC X(12)   VALUE 'REJECTED CHG'.    00003940
003950     05  FILLER              PIC X(5)    VALUE SPACES.            00003950
003960     05  FILLER              PIC X(17)  VALUE 'ERROR DESCRIPTION'.00003960
003970     05  FILLER              PIC X(10)   VALUE SPACES.            00003970
003980     05  FILLER              PIC X(6)    VALUE 'STATUS'.          00003980
003990     05  FILLER              PIC X(10)   VALUE SPACES.            00003990
004000     05  FILLER              PIC X(10)   VALUE 'INPUT DATE'.      00004000
004010     05  FILLER              PIC X(4)    VALUE SPACES.            00004010
004020     05  FILLER              PIC X(14)   VALUE 'GROUP'.           00004020
004030     05  FILLER              PIC X(33)   VALUE SPACES.            00004030
004040 01  TRAILER-1.                                                   00004040
004050     05  FILLER              PIC XX      VALUE SPACES.            00004050
004060     05  MSG-1               PIC X(35)   VALUE SPACES.            00004060
004070     05  MSG-CNT             PIC ZZZ,ZZZ,ZZ9.                     00004070
004080     05  FILLER              PIC XX      VALUE SPACES.            00004080
004090     05  MSG-2               PIC X(15)   VALUE SPACES.            00004090
004100     05  MSG-AMT             PIC ZZ,ZZZ,ZZZ,ZZZ.99.               00004100
004110     05  FILLER              PIC X(51)   VALUE SPACES.            00004110
004120     EJECT                                                        00004120
004130 01  DET-1.                                                       00004130
004140     05  FILLER              PIC X(12)   VALUE SPACES.            00004140
004150     05  DET-TRAN              PIC 99B999999999.                  00004150
004160     05  FILLER              PIC X(5)    VALUE SPACES.            00004160
004170     05  DET-ERR-DES         PIC X(20)   VALUE SPACES.            00004170
004180     05  FILLER              PIC X(7)    VALUE SPACES.            00004180
004190     05  DET-STATUS          PIC X(13)   VALUE SPACES.            00004190
004200     05  FILLER              PIC X(4)    VALUE SPACES.            00004200
004210     05  DET-INP-DATE        PIC 99B99B99.                        00004210
004220     05  FILLER              PIC X(7)    VALUE SPACES.            00004220
004230     05  DET-DEPT            PIC XX.                              00004230
004240     05  FILLER              PIC X       VALUE '/'.               00004240
004250     05  DET-OPID            PIC 999.                             00004250
004260     05  FILLER              PIC X       VALUE '/'.               00004260
004270     05  DET-OPIN            PIC XX.                              00004270
004280     05  FILLER              PIC X(3)    VALUE SPACES.            00004280
004290     05  DET-MULTI-IND       PIC X       VALUE SPACES.            00004290
004300     05  FILLER              PIC X(32)   VALUE SPACES.            00004300
004310                                                                  00004310
004320                                                                  00004320
004330     EJECT                                                        00004330
004340     COPY RTRANS.                                                 00004340
004350                                                                  00004350
004360                                                                  00004360
004370     EJECT                                                        00004370
004380     COPY REFTRANS.                                               00004380
004390                                                                  00004390
004400                                                                  00004400
004410     EJECT                                                        00004410
004420 01  WS-WORK-AREA.                                                00004420
004450     05  WS-ID-IND              PIC X               VALUE SPACES. 00004450
004570     05  WS-ID                  PIC 9(9).                         00004570
004670     EJECT                                                        00004670
004680******************************************************************00004680
004690 01  XNVT-YYMMDD.                                                 00004690
004700     02  XNVT-YYMMDD-YY               PIC 99.                     00004700
004710     02  XNVT-YYMMDD-MM               PIC 99.                     00004710
004720     02  XNVT-YYMMDD-DD               PIC 99.                     00004720
004730 01  XNVT-CURRENT-DATE.                                           00004730
004740     02  XNVT-CURRENT-MM              PIC XX.                     00004740
004750     02  FILLER PIC X VALUE '/'.                                  00004750
004760     02  XNVT-CURRENT-DD              PIC XX.                     00004760
004770     02  FILLER PIC X VALUE '/'.                                  00004770
004780     02  XNVT-CURRENT-YY              PIC XX.                     00004780
004890                                                                  00004890
004990 PROCEDURE DIVISION.                                              00004990
005080     OPEN INPUT LATEST-REFS.                                      00005080
005090     IF WS-LATEST-STATUS IS NOT EQUAL TO ZERO                     00005090
005100        DISPLAY 'ERROR: LATEST STATUS = ' WS-LATEST-STATUS        00005100
005120        CALL 'ABEND'.                                             00005120
005130                                                                  00005130
005210     OPEN INPUT RETAILER-REFS.                                    00005210
005220     IF WS-RETREF-STATUS IS NOT EQUAL TO ZERO                     00005220
005230        DISPLAY 'ERROR: OPEN -- RETREF STATUS = ' WS-RETREF-STATUS00005230
005250        CLOSE LATEST-REFS   WITH LOCK                             00005250
005590        CALL 'ABEND'.                                             00005590
005600                                                                  00005600
005610     OPEN INPUT CHARGES-V-MASTER.                                 00005610
005620     IF WS-CHG-STATUS IS NOT EQUAL TO ZERO                        00005620
005630        DISPLAY 'ERROR ON OPEN -- CHARGE = ' WS-CHG-STATUS        00005630
005650        CLOSE LATEST-REFS   WITH LOCK                             00005650
005670        CLOSE RETAILER-REFS  WITH LOCK                            00005670
006160        CALL 'ABEND'.                                             00006160
006170                                                                  00006170
006180     OPEN INPUT SURCHARGE-PAIDS.                                  00006180
006190     IF WS-SURCH-STATUS IS NOT EQUAL TO ZERO                      00006190
006200        DISPLAY 'ERROR ON OPEN -- SURCHARGE-PAIDS, STATUS = '     00006200
006210                 WS-SURCH-STATUS                                  00006210
006230        CLOSE LATEST-REFS    WITH LOCK                            00006230
006250        CLOSE RETAILER-REFS   WITH LOCK                           00006250
006290        CLOSE CHARGES-V-MASTER WITH LOCK                          00006290
006330        CALL 'ABEND'.                                             00006330
006340                                                                  00006340
006350     OPEN INPUT REJECT-IN-FILE.                                   00006350
006360     OPEN OUTPUT REFUND-OUT-FILE PRINT-FILE.                      00006360
006370                                                                  00006370
006380     EJECT                                                        00006380
006390 200-READ-INPUT.                                                  00006390
006400                                                                  00006400
006410     MOVE SPACE TO WS-ERR-IND.                                    00006410
006420     PERFORM 2200-READ-IN THRU 2200-EXIT.                         00006420
006430     IF WS-FILE-IND IS EQUAL TO 'COMPLETE'                        00006430
006440        GO TO 9100-FINISH.                                        00006440
006450                                                                  00006450
006460     PERFORM 2300-CHECK-CHG THRU 2300-EXIT.                       00006460
006470                                                                  00006470
006480     IF WS-ERR-IND IS EQUAL TO '0'                                00006480
006490        GO TO 200-CONT.                                           00006490
006500                                                                  00006500
006550     GO TO 200-WRITE.                                             00006550
006850                                                                  00006850
006860 200-CONT.                                                        00006860
006870     PERFORM 2400-CHECK-REFUNDS THRU 2400-EXIT.                   00006870
006880                                                                  00006880
006890 200-CONT-1.                                                      00006890
006900     IF WS-ERR-IND IS EQUAL TO '0'                                00006900
006910        ADD 1 TO REC-OUT-GOOD                                     00006910
006920        ADD REFTRAN-CHG-AMT TO AMT-OUT-GOOD.                      00006920
006930                                                                  00006930
006940 200-WRITE.                                                       00006940
006950     ADD 1 TO TOT-OUT-CNT.                                        00006950
006960     ADD REFTRAN-CHG-AMT TO TOT-OUT-AMT.                          00006960
006970     WRITE REF-OUT-REC FROM REFTRAN-REFUND-RECORD.                00006970
006980     GO TO 200-READ-INPUT.                                        00006980
006990                                                                  00006990
007000 2200-READ-IN.                                                    00007000
007010     READ REJECT-IN-FILE INTO REJECTED-TRANSACTION-RECORD         00007010
007020*                    AT END MOVE 'COMPLETE' TO WS-FILE-IND        00007020
007030*                           CLOSE REJECT-IN-FILE                  00007030
007040*                           CLOSE REFUND-OUT-FILE                 00007040
007050*                           GO TO 2200-EXIT.                      00007050
007060     ADD 1 TO REF-IN-CNT.                                         00007060
007070     ADD REFTRAN-CHG-AMT TO REF-IN-AMT.                           00007070
007080     MOVE SPACES TO WS-ERR-IND.                                   00007080
007090                                                                  00007090
007100 2200-EXIT. EXIT.                                                 00007100
007110     EJECT                                                        00007110
007120 2300-CHECK-CHG.                                                  00007120
007130                                                                  00007130
007140     MOVE ZERO TO REFTRAN-REFUNDED-AMT.                           00007150
007200                                                                  00007200
007490     EJECT                                                        00007490
007500 2300-CONT.                                                       00007500
007520     MOVE RTRAN-TRANS-ID TO CHG-KEY.                              00007520
007560     READ CHARGES-V-MASTER.                                       00007560
001000     IF WS-CHG-STATUS = '00'                                      00001000
007810         GO TO 2300-FOUND                                         00007810
007580     ELSE                                                         00007580
001000         IF WS-CHG-STATUS = '23'                                  00001000
007710             MOVE 'X' TO WS-ERR-IND                               00007710
007720             ADD 1 TO REC-NO-CHG                                  00007720
007730             ADD REFTRAN-CHG-AMT TO AMT-NO-CHG                    00007730
007740             GO TO 2300-EXIT                                      00007740
               ELSE
007540             MOVE 'X' TO WS-ERR-IND                               00007540
007550             GO TO 2300-EXIT.                                     00007550
007610                                                                  00007610
007650                                                                  00007650
007750     EJECT                                                        00007750
007760 2300-COMP-BEG.                                                   00007760
007960                                                                  00007960
007970                                                                  00007970
007980     EJECT                                                        00007980
007990 2300-FOUND.                                                      00007990
008060     IF CHG-ERR-IND IS EQUAL TO 'E'                               00008060
008070        MOVE 'X' TO WS-ERR-IND                                    00008070
008080        ADD 1                    TO REC-NO-CHG                    00008080
008090        ADD REFTRAN-CHG-AMT TO AMT-NO-CHG                         00008090
008100        GO TO 2300-EXIT.                                          00008100
008110                                                                  00008110
008170     PERFORM 1000-CHECK-SURCH THRU 1000-EXIT.                     00008170
008180     IF WS-ERR-IND IS EQUAL TO 'X'                                00008180
008190        ADD 1                    TO REC-SURCH                     00008190
008200        ADD REFTRAN-CHG-AMT TO AMT-SURCH                          00008200
008210        GO TO 2300-EXIT.                                          00008210
008220                                                                  00008220
008230     MOVE '0' TO WS-ERR-IND.                                      00008230
008240     MOVE CHG-NAME TO REFTRAN-NAME.                               00008240
008250     MOVE CHG-ADDR1 TO REFTRAN-ADDR1.                             00008250
008260     MOVE CHG-ADDR2 TO REFTRAN-ADDR2.                             00008260
008270     MOVE CHG-CITY     TO REFTRAN-CITY.                           00008270
008310     MOVE CHG-STATE   TO REFTRAN-STATE.                           00008310
008310     MOVE CHG-ZIP   TO REFTRAN-ZIP.                               00008310
008310     MOVE CHG-PHONE   TO REFTRAN-PHONE.                           00008310
008310     MOVE CHG-EMAIL   TO REFTRAN-EMAIL.                           00008310
           MOVE REJECTED-TRANSACTION-RECORD TO
                REFTRAN-REJECTION-RECORD.
008330     EJECT                                                        00008330
009030 2300-EXIT. EXIT.                                                 00009030
009040     EJECT                                                        00009040
009050 2400-CHECK-REFUNDS.                                              00009050
009060                                                                  00009060
009070     MOVE '0' TO WS-ERR-IND.                                      00009070
009080     MOVE ZERO TO WS-REFUND-SOFAR WS-REMAINING.                   00009080
009090     MOVE ZERO TO WS-REFUND-FOUND-CNT.                            00009090
009100     MOVE 0 TO WS-RETREF-CNT.                                     00009100
009250     PERFORM 2800-RETAIL THRU 2800-EXIT.                          00009260
009260                                                                  00009270
009270     MOVE CHG-KEY TO LATEST-REF-KEY.                              00009280
009280     READ LATEST-REFS.                                            00009290
009290     IF WS-LATEST-STATUS IS EQUAL TO ZERO                         00009300
009300        GO TO 200-REFUND-TODAY.                                   00009310
009310                                                                  00009320
009320     IF WS-LATEST-STATUS IS EQUAL TO 23                           00009330
009330        GO TO 200-NO-REFUND-TODAY.                                00009340
009340                                                                  00009350
009350     DISPLAY '*** PROBLEM READING LATEST  STATUS = '              00009360
009360         WS-LATEST-STATUS.                                        00009370
009370     PERFORM 9100-CLOSE THRU 9100-EXIT.                           00009380
009380     CALL 'ABEND'.                                                00009390
009390     EJECT                                                        00009400
009400 200-REFUND-TODAY.                                                00009410
009410                                                                  00009420
009420     MOVE SPACES TO WS-ID-IND.                                    00009430
009430     MOVE LATEST-REF-KEY TO WS-ID.                                00009440
009440     PERFORM 2850-CHECK-ID THRU 2850-EXIT.                        00009450
009450     IF WS-ID-IND IS EQUAL TO SPACE                               00009460
009460        GO TO 200-NO-REFUND-TODAY.                                00009470
009490     MOVE 'X' TO WS-ERR-IND.                                      00009500
009500     EJECT                                                        00009510
009510 200-NO-REFUND-TODAY.                                             00009520
009520                                                                  00009530
009530     IF WS-ERR-IND IS EQUAL TO 'X'                                00009540
009560        GO TO 2400-EXIT.                                          00009570
009570                                                                  00009580
009580     COMPUTE WS-REMAINING = (CHG-AMT - WS-REFUND-SOFAR).          00009590
009590     IF WS-REMAINING IS NEGATIVE                                  00009600
009600        MOVE ZERO TO WS-REMAINING.                                00009610
009610     MOVE WS-REMAINING TO REFTRAN-REMAINING-AMT.                  00009620
009620     IF (WS-REMAINING IS LESS THAN 5.00)                          00009630
009630        OR                                                        00009640
009640        (CHG-AMT IS EQUAL TO ZERO)                                00009650
009660           MOVE 0 TO REFTRAN-REMAINING-AMT
                 MOVE CHG-AMT to REFTRAN-REFUNDED-AMT
009720            GO TO 2400-EXIT.                                      00009730
                                                                        00009670
            MOVE WS-REFUND-SOFAR to REFTRAN-REFUNDED-AMT.
010000 2400-EXIT. EXIT.                                                 00010010
011800     EJECT                                                        00011810
011810 2800-RETAIL.                                                     00011820
011820                                                                  00011830
011830     MOVE WS-RETREF-CNT TO RETREFS-SEQ.                           00011840
011830     MOVE CHG-KEY TO RETREFS-ID.                                  00011840
011840     READ RETAILER-REFS.                                          00011850
011850     IF WS-RETREF-STATUS IS EQUAL TO ZERO                         00011860
011860        GO TO 2800-FOUND.                                         00011870
011870                                                                  00011880
011880     IF WS-RETREF-STATUS IS EQUAL TO 23                           00011890
011890        GO TO 2800-NOT-FOUND.                                     00011900
011900                                                                  00011910
011910     DISPLAY '*** PROBLEM READING RETREF STATUS = '               00011920
011920             WS-RETREF-STATUS.                                    00011930
011930     PERFORM 9100-CLOSE THRU 9100-EXIT.                           00011940
011940     CALL 'ABEND'.                                                00011950
011950     EJECT                                                        00011960
011960 2800-FOUND.                                                      00011970
011970                                                                  00011980
011980     IF WS-RETREF-CNT IS NOT EQUAL TO CHG-COUNT                   00011990
011990        ADD RETREFS-AMT TO WS-REFUND-SOFAR                        00012000
012000        ADD 1 TO WS-REFUND-FOUND-CNT                              00012010
012010        GO TO 2800-NOT-FOUND.                                     00012020
012020                                                                  00012030
012030      MOVE SPACES TO WS-ID-IND.                                   00012040
012040      MOVE RETREFS-ID TO WS-ID.                                   00012050
012050      PERFORM 2850-CHECK-ID THRU 2850-EXIT.                       00012060
012060      IF WS-ID-IND IS EQUAL TO SPACE                              00012070
012070        GO TO 2800-NOT-FOUND.                                     00012080
012100      MOVE 'X' TO WS-ERR-IND.                                     00012110
012110      GO TO 2800-EXIT.                                            00012120
012120     EJECT                                                        00012130
012130 2800-NOT-FOUND.                                                  00012140
012140                                                                  00012150
012150     ADD 1 TO WS-RETREF-CNT.                                      00012160
012160     IF WS-RETREF-CNT IS GREATER THAN OR EQUAL CHG-COUNT          00012170
012170        GO TO 2800-EXIT                                           00012180
012180     ELSE                                                         00012190
012190        GO TO 2800-RETAIL.                                        00012200
012200                                                                  00012210
012210 2800-EXIT. EXIT.                                                 00012220
012220     EJECT                                                        00012230
012230 2850-CHECK-ID.                                                   00012240
012240                                                                  00012250
012290     IF (WS-ID IS EQUAL TO ZERO OR 12345678 )                     00012310
012310        MOVE 'X' TO WS-ID-IND.                                    00012330
012330                                                                  00012340
012340 2850-EXIT. EXIT.                                                 00012350
012350     EJECT                                                        00012360
012770* ************************************************************    00012780
012780 1000-CHECK-SURCH.                                                00012790
012790                                                                  00012800
012800     MOVE RTRAN-TRANS-ID TO SURCH-KEY.                            00012810
012810     READ SURCHARGE-PAIDS.                                        00012830
012830                                                                  00012840
012840     IF WS-SURCH-STATUS = ZERO                                    00012850
              IF CHG-STATE IS NOT =  'CA' OR 'NY'
12860           MOVE 'X' TO WS-ERR-IND                                  00012870
012870        ELSE                                                      00012880
012880           NEXT SENTENCE                                          00012890
012890     ELSE                                                         00012900
012900        IF WS-SURCH-STATUS = 23                                   00012910
012910           NEXT SENTENCE                                          00012920
012920        ELSE                                                      00012930
012930           DISPLAY '*** PROBLEM READING SURCHARGE-PAIDS FILE ***' 00012940
012940           DISPLAY '*** VSAM RETURN CODE = '                      00012950
012950                   WS-SURCH-STATUS ', CALL ABEND***'              00012960
012960           PERFORM 9100-CLOSE THRU 9100-EXIT                      00012970
012970           CALL 'ABEND'.                                          00012980
012980                                                                  00012990
012990 1000-EXIT.                                                       00013000
013000     EXIT.                                                        00013010
013010                                                                  00013020
013020                                                                  00013030
013030     EJECT                                                        00013040
013040 9100-CLOSE.                                                      00013050
013050                                                                  00013060
013060     CLOSE LATEST-REFS         WITH LOCK.                         00013070
013080     CLOSE RETAILER-REFS        WITH LOCK.                        00013090
013120     CLOSE CHARGES-V-MASTER      WITH LOCK.                       00013130
013160     CLOSE SURCHARGE-PAIDS      WITH LOCK.                        00013170
013170                                                                  00013180
013180 9100-EXIT.                                                       00013190
013190     EXIT.                                                        00013200
013200     EJECT                                                        00013210
013210 9100-FINISH.                                                     00013220
013220                                                                  00013230
013230     ADD 1             TO PAGENO.                                 00013240
013240     MOVE PAGENO       TO PRT-PG.                                 00013250
013250     ACCEPT XNVT-YYMMDD FROM DATE                                 00013260
013260     MOVE XNVT-YYMMDD-MM TO XNVT-CURRENT-MM                       00013270
013270     MOVE XNVT-YYMMDD-DD TO XNVT-CURRENT-DD                       00013280
013280     MOVE XNVT-YYMMDD-YY TO XNVT-CURRENT-YY                       00013290
013290     MOVE XNVT-CURRENT-DATE TO PRT-DATE.                          00013300
013300     WRITE PRINT-REC FROM TIT-1 AFTER ADVANCING TOP-OF-PAGE.      00013310
013310     MOVE SPACES TO PRINT-REC.                                    00013320
013320     WRITE PRINT-REC AFTER ADVANCING 3 LINES.                     00013330
013330                                                                  00013340
013340     MOVE 'RECORDS READ IN FROM REJECTED =======' TO MSG-1.       00013350
013350     MOVE REF-IN-CNT       TO MSG-CNT.                            00013360
013360     MOVE 'AMOUNT IN =====' TO MSG-2.                             00013370
013370     MOVE REF-IN-AMT       TO MSG-AMT.                            00013380
013380     WRITE PRINT-REC FROM TRAILER-1 AFTER ADVANCING 2 LINES.      00013390
013390                                                                  00013400
013450                                                                  00013460
013580     MOVE 'RECORDS WITH NO CHARGE ===' TO MSG-1.                  00013590
013590     MOVE REC-NO-CHG TO MSG-CNT.                                  00013600
013600     MOVE 'AMOUNT ========' TO MSG-2.                             00013610
013610     MOVE AMT-NO-CHG TO MSG-AMT.                                  00013620
013620     WRITE PRINT-REC FROM TRAILER-1 AFTER ADVANCING 1 LINES.      00013630
013630                                                                  00013640
013640     MOVE 'RECORDS WITH SURCHARGE ==' TO MSG-1.                   00013650
013650     MOVE REC-SURCH                        TO MSG-CNT.            00013660
013660     MOVE 'AMOUNT ========'                     TO MSG-2.         00013670
013670     MOVE AMT-SURCH                        TO MSG-AMT.            00013680
013680     WRITE PRINT-REC FROM TRAILER-1 AFTER ADVANCING 1 LINES.      00013690
013690                                                                  00013700
013690                                                                  00013700
013700     MOVE 'RECORDS GOOD ======================' TO MSG-1.         00013710
013710     MOVE REC-OUT-GOOD      TO MSG-CNT.                           00013720
013720     MOVE 'AMOUNT GOOD ===' TO MSG-2.                             00013730
013730     MOVE AMT-OUT-GOOD      TO MSG-AMT.                           00013740
013740     WRITE PRINT-REC FROM TRAILER-1 AFTER ADVANCING 1 LINES.      00013750
013750                                                                  00013760
013760     MOVE 'RECORDS WRITTEN =========' TO MSG-1.                   00013770
013770     MOVE TOT-OUT-CNT       TO MSG-CNT.                           00013780
013780     MOVE 'AMOUNT OUT ====' TO MSG-2.                             00013790
013790     MOVE TOT-OUT-AMT       TO MSG-AMT.                           00013800
013800     WRITE PRINT-REC FROM TRAILER-1 AFTER ADVANCING 2 LINES.      00013810
013810                                                                  00013820
013820     CLOSE PRINT-FILE.                                            00013830
013830     PERFORM 9100-CLOSE  THRU 9100-EXIT.                          00013840
013840                                                                  00013850
013850     STOP RUN.                                                    00013860
013860******************************************************************00013870
013870*END END END END END END END END END END END END END END END END  00013880
013880******************************************************************00013890
