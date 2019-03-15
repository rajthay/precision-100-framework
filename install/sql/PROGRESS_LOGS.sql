DROP TABLE PROGRESS_LOGS
/
CREATE TABLE PROGRESS_LOGS (
   LOG_TIME DATE DEFAULT SYSDATE,
   LOG_SOURCE VARCHAR2(255),
   LOG_EVENT VARCHAR2(255),
   LOG_TEXT VARCHAR2(255),
   ADDITIONAL_INFO1 VARCHAR2(255),
   ADDITIONAL_INFO2 VARCHAR2(255),
   ADDITIONAL_INFO3 VARCHAR2(255),
   ADDITIONAL_INFO4 VARCHAR2(255),
   ADDITIONAL_INFO5 VARCHAR2(255)
)
/
CREATE OR REPLACE PACKAGE PROGRESS_LOGS_PKG AS
   PROCEDURE LOG(
      LOG_SOURCE VARCHAR2,
      LOG_EVENT VARCHAR2,
      LOG_TEXT VARCHAR2
   );

END PROGRESS_LOGS_PKG;
/
CREATE OR REPLACE PACKAGE BODY PROGRESS_LOGS_PKG AS

   PROCEDURE INTERNAL_LOG(
      P_LOG_SOURCE VARCHAR2,
      P_LOG_EVENT VARCHAR2,
      P_LOG_TEXT VARCHAR2,
      P_ADDITIONAL_INFO1 VARCHAR2,
      P_ADDITIONAL_INFO2 VARCHAR2,
      P_ADDITIONAL_INFO3 VARCHAR2,
      P_ADDITIONAL_INFO4 VARCHAR2,
      P_ADDITIONAL_INFO5 VARCHAR2
   ) IS 
   BEGIN

      INSERT INTO PROGRESS_LOGS (
         LOG_SOURCE,
         LOG_EVENT,
         LOG_TEXT,
         ADDITIONAL_INFO1,
         ADDITIONAL_INFO2,
         ADDITIONAL_INFO3,
         ADDITIONAL_INFO4,
         ADDITIONAL_INFO5
      ) VALUES (
         P_LOG_SOURCE,
         P_LOG_EVENT,
         P_LOG_TEXT,
         P_ADDITIONAL_INFO1,
         P_ADDITIONAL_INFO2,
         P_ADDITIONAL_INFO3,
         P_ADDITIONAL_INFO4,
         P_ADDITIONAL_INFO5
      );
   END INTERNAL_LOG;

   PROCEDURE LOG(
      LOG_SOURCE VARCHAR2,
      LOG_EVENT VARCHAR2,
      LOG_TEXT VARCHAR2
   ) IS 
   BEGIN
      INTERNAL_LOG(
	 LOG_SOURCE,
	 LOG_EVENT,
	 LOG_TEXT,
	 NULL,
	 NULL,
	 NULL,
	 NULL,
	 NULL
      );

   END;

END PROGRESS_LOGS_PKG;
/
