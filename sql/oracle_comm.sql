--强制主机并行
select /*+ monitor parallel(16)*/ count(*),sum(charges) from OUTP_BILL_ITEMS; 


CREATE OR REPLACE FUNCTION PARSE_FEE_CHINESE(N_FEE IN NUMBER) 
RETURN VARCHAR2 AS
  V_CHINESE_NUMBER VARCHAR2(30)  := '零壹贰叁肆伍陆柒捌玖';
  V_CHINESE_POINT  VARCHAR2(30)  := '分角元拾佰仟万亿';
  V_RESULT         VARCHAR2(100) := '';
  V_TEMP           VARCHAR2(100);
  V_FLAG           VARCHAR2(10);
  V_MAIN           VARCHAR2(40);
  V_SUB            VARCHAR2(20);
  N_TEMPFEE        NUMBER(30, 2);
  C_CH1            CHAR(1);
  C_CH2            VARCHAR2(10);
  N_LENGTH         NUMBER(10) := 0;
  I                NUMBER(10) := 0;
  J                NUMBER(10) := 0;
  T                NUMBER(10) := 0;
BEGIN
  IF N_FEE     < 0 THEN
    V_FLAG    := '负';
    N_TEMPFEE := -1 * N_FEE;
  ELSE
    N_TEMPFEE := N_FEE;
    V_FLAG    := '';
  END IF;
  SELECT
    TRIM(TO_CHAR(ROUND(N_TEMPFEE, 2), '9999999999999999999.99'))
  INTO
    V_TEMP
  FROM
    DUAL;
  IF N_FEE    = 0 THEN
    V_RESULT := '零元整';
  ELSE
    --先处理整数，再处理小数
    V_MAIN     := SUBSTR(V_TEMP, 1, INSTR(V_TEMP, '.') - 1);
    V_SUB      := SUBSTR(V_TEMP, INSTR(V_TEMP, '.')    + 1);
    N_LENGTH   := LENGTH(V_MAIN);
    I          := N_LENGTH;
    T          := 0;
    IF V_MAIN  IS NULL OR '0' = V_MAIN THEN
      V_RESULT := '零' || V_RESULT;
    END IF;
    WHILE I > 0
    LOOP
      I            := I                - 1;
      T            := T                + 1;
      C_CH1        := SUBSTR(V_MAIN, I + 1);
      V_MAIN       := SUBSTR(V_MAIN, 1, I);
      J            := TO_NUMBER(C_CH1);
      IF T          = 5 OR t= 13 THEN
        V_RESULT   := '万' || V_RESULT;
      ELSIF T       = 9 THEN
        IF '万'      = SUBSTR(V_RESULT, 1, 1) THEN
          V_RESULT := '亿' || SUBSTR(V_RESULT, 2);
        ELSE
          V_RESULT := '亿' || V_RESULT;
        END IF;
      END IF;
      IF '0'          = C_CH1 THEN
        IF I         <> N_LENGTH AND '零' <> C_CH2 THEN
          IF T       <> 5 AND T <> 9 AND T <> 13 THEN
            V_RESULT := '零' || V_RESULT;
          ELSIF T     = 5 OR T = 9 OR t=13 THEN
            V_RESULT := SUBSTR(V_RESULT, 1, 1) || '零' ||
            SUBSTR(V_RESULT, 2);
          END IF;
          C_CH2 := SUBSTR(V_CHINESE_NUMBER, J, 1);
        END IF;
      ELSE
        J       := MOD(T, 4);
        IF T    <> 5 AND T <> 9 AND T <> 13 THEN
          IF J  <> 1 THEN
            IF J = 0 THEN
              J := J + 4;
            END IF;
            J        := J + 2;
            V_RESULT := SUBSTR(V_CHINESE_POINT, J, 1) || V_RESULT;
          END IF;
        END IF;
        J        := TO_NUMBER(C_CH1) + 1;
        C_CH2    := SUBSTR(V_CHINESE_NUMBER, J, 1);
        V_RESULT := C_CH2 || V_RESULT;
      END IF;
    END LOOP;
    V_RESULT   := V_RESULT || '元';
    IF V_SUB   IS NULL OR LENGTH(TRIM(V_SUB)) <= 0 OR TO_NUMBER(V_SUB) = 0 THEN
      V_RESULT := V_RESULT || '整';
    ELSE
      C_CH1      := SUBSTR(V_SUB, 1, 1);
      J          := TO_NUMBER(C_CH1) + 1;
      C_CH2      := SUBSTR(V_CHINESE_NUMBER, J, 1);
      IF '0'      = C_CH1 THEN
        V_RESULT := V_RESULT || C_CH2 ;
      ELSE
        V_RESULT := V_RESULT || C_CH2 || '角';
      END IF;
      C_CH1      := SUBSTR(V_SUB, 2, 1);
      IF '0'     <> C_CH1 THEN
        J        := TO_NUMBER(C_CH1) + 1;
        C_CH2    := SUBSTR(V_CHINESE_NUMBER, J, 1);
        V_RESULT := V_RESULT || C_CH2 || '分';
      END IF;
    END IF;
  END IF;
  V_RESULT := V_FLAG || V_RESULT;
  RETURN V_RESULT;
END;