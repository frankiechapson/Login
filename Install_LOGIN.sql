


Prompt ***************************************************
Prompt **       I N S T A L L I N G   L O G I N         **
Prompt ***************************************************



/*============================================================================================*/

create sequence SEQ_LOGIN_LOG_ID
    increment by          1
    minvalue              1
    maxvalue   999999999999
    start with            1
    cycle
    nocache;

/*============================================================================================*/

create table LOGIN_LOG  (

    ID                      number
        constraint LOGIN_LOG_NN01                   not null,      
        constraint LOGIN_LOG_PK                     primary key ( ID ) using index ( create unique index LOGIN_LOG_PK on LOGIN_LOG ( ID ) ),

    LOGIN_TIME              timestamp   
        constraint LOGIN_LOG_NN02                   not null,      

    ORACLE_USER             VARCHAR2 (   400 )
        constraint LOGIN_LOG_NN03                   not null,      

    OS_USER                 VARCHAR2 (   400 )
        constraint LOGIN_LOG_NN04                   not null,      

    IP_ADDRESS              VARCHAR2 (   400 )
        constraint LOGIN_LOG_NN05                   not null,      

    PROGRAM                 VARCHAR2 (   400 )
        constraint LOGIN_LOG_NN06                   not null    

    );

comment on table  LOGIN_LOG                 is 'Log of logins #Ver:1.0#';
comment on column LOGIN_LOG.ID              is 'Internal PK from the SEQ_LOGIN_LOG_ID sequence';
comment on column LOGIN_LOG.LOGIN_TIME      is 'In UTC';
comment on column LOGIN_LOG.ORACLE_USER     is 'SYS_CONTEXT SESSION_USER';
comment on column LOGIN_LOG.OS_USER         is 'SYS_CONTEXT OS_USER';
comment on column LOGIN_LOG.IP_ADDRESS      is 'SYS_CONTEXT IP_ADDRESS';
comment on column LOGIN_LOG.PROGRAM         is 'SYS_CONTEXT MODULE';

/*============================================================================================*/

create or replace trigger TRG_LOGIN_LOG_BIR
before insert on LOGIN_LOG for each row
begin
    :new.ID          := nvl( :new.ID, SEQ_LOGIN_LOG_ID.nextval );
    :new.LOGIN_TIME  := sys_extract_utc( systimestamp );
    :new.ORACLE_USER := sys_context( 'USERENV', 'SESSION_USER' );
    :new.OS_USER     := sys_context( 'USERENV', 'OS_USER'      );
    :new.IP_ADDRESS  := sys_context( 'USERENV', 'IP_ADDRESS'   );
    :new.PROGRAM     := sys_context( 'USERENV', 'MODULE'       );
end;
/

/*============================================================================================*/

create table LOGIN_SCRIPTS (

    CODE                          varchar2 (    20 )
        constraint LOGIN_SCRIPTS_NN01                   not null,      
        constraint LOGIN_SCRIPTS_PK                     primary key ( CODE ) using index ( create unique index LOGIN_SCRIPTS_PK on LOGIN_SCRIPTS ( CODE ) ),

    NAME                          varchar2 (   200 )
        constraint LOGIN_SCRIPTS_NN02                   not null,      
        constraint LOGIN_SCRIPTS_UK01                   unique ( NAME ) using index ( create unique index LOGIN_SCRIPTS_UK01 on LOGIN_SCRIPTS ( NAME ) ),

    REMARK                        VARCHAR2 (  4000 )

  );

comment on table  LOGIN_SCRIPTS                 is 'Login script definitions #Ver:1.0#';

/*============================================================================================*/

insert into LOGIN_SCRIPTS ( CODE, NAME, REMARK ) values ( 'BASEUSA', 'Basic USA'       , 'Default American Login Script'       );

insert into LOGIN_SCRIPTS ( CODE, NAME, REMARK ) values ( 'BASEHUN', 'Basic Hungarian' , 'Alapértelmezett Magyar Login Script' );

/*============================================================================================*/

create table LOGIN_SCRIPT_LINES (

    LOGIN_SCRIPT_CODE       varchar2 (    20 )
        constraint LOGIN_SCRIPT_LINES_NN01              not null,      
        constraint LOGIN_SCRIPT_LINES_FK01              foreign key ( LOGIN_SCRIPT_CODE ) references LOGIN_SCRIPTS ( CODE ),

    LINE_NO                 number   (     5 )
        constraint LOGIN_SCRIPT_LINES_NN02              not null,      
        constraint LOGIN_SCRIPT_LINES_PK                primary key ( LOGIN_SCRIPT_CODE, LINE_NO ) using index ( create unique index LOGIN_SCRIPT_LINES_PK on LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO ) ),

    LINE                    VARCHAR2 (  4000 )

);

comment on table  LOGIN_SCRIPT_LINES                 is 'Login script lines #Ver:1.0#';

/*============================================================================================*/

insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEUSA',  1, 'alter session set NLS_COMP                =''BINARY''                       ' );
insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEUSA',  2, 'alter session set NLS_SORT                =''AMERICAN''                     ' );
insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEUSA',  3, 'alter session set NLS_CALENDAR            =''GREGORIAN''                    ' );
insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEUSA',  4, 'alter session set NLS_LANGUAGE            =''AMERICAN''                     ' );
insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEUSA',  5, 'alter session set NLS_TERRITORY           =''AMERICA''                      ' );
insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEUSA',  6, 'alter session set NLS_DATE_FORMAT         =''DD-MON-RR''                    ' );
insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEUSA',  7, 'alter session set NLS_TIME_FORMAT         =''HH.MI.SSXFF AM''               ' );
insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEUSA',  8, 'alter session set NLS_TIMESTAMP_FORMAT    =''DD-MON-RR HH.MI.SSXFF AM''     ' );
insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEUSA',  9, 'alter session set NLS_TIMESTAMP_TZ_FORMAT =''DD-MON-RR HH.MI.SSXFF AM TZR'' ' );
insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEUSA', 10, 'alter session set NLS_DATE_LANGUAGE       =''AMERICAN''                     ' );
insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEUSA', 11, 'alter session set NLS_CURRENCY            =''$''                            ' );
insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEUSA', 12, 'alter session set NLS_ISO_CURRENCY        =''AMERICA''                      ' );
insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEUSA', 13, 'alter session set NLS_DUAL_CURRENCY       =''$''                            ' );
insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEUSA', 14, 'alter session set NLS_NUMERIC_CHARACTERS  =''.,''                           ' );
insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEUSA', 15, 'begin PKG_MYENV.P_INIT; end;' );
insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEUSA', 16, 'begin PKG_MYENV.P_SET_MYENV( ''DB_DATA_LANG'', ''ENG'' ); end;' );


insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEHUN',  1, 'alter session set NLS_COMP                =''BINARY''                       ' );
insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEHUN',  2, 'alter session set NLS_SORT                =''HUNGARIAN''                    ' );
insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEHUN',  3, 'alter session set NLS_CALENDAR            =''GREGORIAN''                    ' );
insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEHUN',  4, 'alter session set NLS_LANGUAGE            =''HUNGARIAN''                    ' );
insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEHUN',  5, 'alter session set NLS_TERRITORY           =''HUNGARY''                      ' );
insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEHUN',  6, 'alter session set NLS_DATE_FORMAT         =''YYYY.MM.DD''                   ' );
insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEHUN',  7, 'alter session set NLS_TIME_FORMAT         =''HH24:MI:SSXFF''                ' );
insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEHUN',  8, 'alter session set NLS_TIMESTAMP_FORMAT    =''YYYY.MM.DD HH24:MI:SSXFF''     ' );
insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEHUN',  9, 'alter session set NLS_TIMESTAMP_TZ_FORMAT =''YYYY.MM.DD HH24:MI:SSXFF TZR'' ' );
insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEHUN', 10, 'alter session set NLS_DATE_LANGUAGE       =''HUNGARIAN''                    ' );
insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEHUN', 11, 'alter session set NLS_CURRENCY            =''Ft''                           ' );
insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEHUN', 12, 'alter session set NLS_ISO_CURRENCY        =''HUNGARY''                      ' );
insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEHUN', 13, 'alter session set NLS_DUAL_CURRENCY       =''Ft''                           ' );
insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEHUN', 14, 'alter session set NLS_NUMERIC_CHARACTERS  =''. ''                           ' );
insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEHUN', 15, 'begin PKG_MYENV.P_INIT; end;' );
insert into LOGIN_SCRIPT_LINES ( LOGIN_SCRIPT_CODE, LINE_NO, LINE ) values ( 'BASEHUN', 16, 'begin PKG_MYENV.P_SET_MYENV( ''DB_DATA_LANG'', ''ENG'' ); end;' );

/*============================================================================================*/

create or replace procedure P_LOGIN ( I_LOGIN_SCRIPT_CODE in varchar2 ) is
    pragma autonomous_transaction;
/* #Ver:1.0# */
begin               

    PKG_MYENV.P_SET_MYENV( 'PROGRAM NAME' , 'P_LOGIN'          , 'PROGRAM TRACE' );
    PKG_MYENV.P_SET_MYENV( 'PARAMETER#01' , I_LOGIN_SCRIPT_CODE, 'PROGRAM TRACE' );

    PKG_MYENV.P_SET_MYENV( 'POS' , 'Before LOG' , 'PROGRAM TRACE' );
    insert into LOGIN_LOG ( ID ) values ( null );
    commit;

    -- run the login script:
    for l_r in ( select LINE from LOGIN_SCRIPT_LINES where LOGIN_SCRIPT_CODE = I_LOGIN_SCRIPT_CODE order by LINE_NO asc )
    loop
        PKG_MYENV.P_SET_MYENV( 'POS'  , 'Before execute scrip line' , 'PROGRAM TRACE' );
        PKG_MYENV.P_SET_MYENV( 'INFO' , L_R.LINE                    , 'PROGRAM TRACE' );
        execute immediate L_R.LINE;
    end loop;
exception when others then
    PKG_MYENV.P_SET_MYENV( 'ERROR CODE'   , SQLCODE, 'PROGRAM TRACE' );
    PKG_MYENV.P_SET_MYENV( 'ERROR MESSAGE', SQLERRM, 'PROGRAM TRACE' );
    raise;
end;
/

/*============================================================================================*/

/*
Read the TRACE:

select 'PROGRAM NAME' as NAME, PKG_MYENV.F_GET_MYENV( 'PROGRAM NAME' , 'PROGRAM TRACE' ) as VALUE from dual union all
select 'PARAMETER#01'        , PKG_MYENV.F_GET_MYENV( 'PARAMETER#01' , 'PROGRAM TRACE' )          from dual union all
select 'POS'                 , PKG_MYENV.F_GET_MYENV( 'POS'          , 'PROGRAM TRACE' )          from dual union all
select 'INFO'                , PKG_MYENV.F_GET_MYENV( 'INFO'         , 'PROGRAM TRACE' )          from dual union all
select 'ERROR CODE'          , PKG_MYENV.F_GET_MYENV( 'ERROR CODE'   , 'PROGRAM TRACE' )          from dual union all
select 'ERROR MESSAGE'       , PKG_MYENV.F_GET_MYENV( 'ERROR MESSAGE', 'PROGRAM TRACE' )          from dual;

*/
