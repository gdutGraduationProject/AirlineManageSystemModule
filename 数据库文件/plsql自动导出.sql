prompt PL/SQL Developer import file
prompt Created on 2017年5月14日 by ChenGeng
set feedback off
set define off
prompt Creating AIRPORT...
create table AIRPORT
(
  id           VARCHAR2(36) not null,
  create_date  DATE,
  delete_date  DATE,
  is_delete    CHAR(1),
  update_date  DATE,
  version      NUMBER(10) not null,
  airport_name VARCHAR2(255),
  city         VARCHAR2(255),
  is_disable   CHAR(1),
  province     VARCHAR2(255),
  short_eng    VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIRPORT
  add primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating PLANE...
create table PLANE
(
  id          VARCHAR2(36) not null,
  create_date DATE,
  delete_date DATE,
  is_delete   CHAR(1),
  update_date DATE,
  version     NUMBER(10) not null,
  company     VARCHAR2(255),
  is_disable  CHAR(1),
  max_mileage NUMBER(10) not null,
  model_name  VARCHAR2(255),
  seat_count  NUMBER(10) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PLANE
  add primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating AIRLINE...
create table AIRLINE
(
  id                     VARCHAR2(36) not null,
  create_date            DATE,
  delete_date            DATE,
  is_delete              CHAR(1),
  update_date            DATE,
  version                NUMBER(10) not null,
  airline_num            VARCHAR2(255),
  airport_construction   FLOAT not null,
  arrive_time            DATE,
  friday                 CHAR(1) not null,
  fuel_tex               FLOAT not null,
  is_disable             CHAR(1) not null,
  mileage                NUMBER(10) not null,
  monday                 CHAR(1) not null,
  saturday               CHAR(1) not null,
  start_time             DATE,
  sunday                 CHAR(1) not null,
  thursday               CHAR(1) not null,
  tuesday                CHAR(1) not null,
  wednesday              CHAR(1) not null,
  departure_airport_id   VARCHAR2(36),
  destination_airport_id VARCHAR2(36),
  plane_id               VARCHAR2(36),
  status                 NUMBER(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIRLINE
  add primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIRLINE
  add constraint FK7U9Y7LVV5IMBWPJDJPN52W9QX foreign key (DEPARTURE_AIRPORT_ID)
  references AIRPORT (ID);
alter table AIRLINE
  add constraint FKP8EM34PS4FC8TQMHU2A927C1S foreign key (PLANE_ID)
  references PLANE (ID);
alter table AIRLINE
  add constraint FKSJ5UMBORTVW6PIRFL6KEGLHUM foreign key (DESTINATION_AIRPORT_ID)
  references AIRPORT (ID);

prompt Creating PLANE_CLASS...
create table PLANE_CLASS
(
  id          VARCHAR2(36) not null,
  left_count  NUMBER(10) not null,
  name        VARCHAR2(255),
  simple_name VARCHAR2(255),
  total_count NUMBER(10) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PLANE_CLASS
  add primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating AIRLINE_CLASS...
create table AIRLINE_CLASS
(
  id                VARCHAR2(36) not null,
  create_date       DATE,
  delete_date       DATE,
  is_delete         CHAR(1),
  update_date       DATE,
  version           NUMBER(10) not null,
  after_change_fee  FLOAT not null,
  after_refund_fee  FLOAT not null,
  before_change_fee FLOAT not null,
  before_refund_fee FLOAT not null,
  default_discount  FLOAT not null,
  full_price        FLOAT not null,
  name              VARCHAR2(255),
  simple_name       VARCHAR2(255),
  split_time        NUMBER(10) not null,
  total_count       NUMBER(10) not null,
  plane_class_id    VARCHAR2(36)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIRLINE_CLASS
  add primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIRLINE_CLASS
  add constraint FKP03QWM8PPK8LNXXGSO355148 foreign key (PLANE_CLASS_ID)
  references PLANE_CLASS (ID);

prompt Creating AIRLINE_LINKS_AIRLINE_CLASS...
create table AIRLINE_LINKS_AIRLINE_CLASS
(
  airline_id       VARCHAR2(36) not null,
  airline_class_id VARCHAR2(36) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIRLINE_LINKS_AIRLINE_CLASS
  add constraint FK4FSWASS89JGVJWW4MK183V9FY foreign key (AIRLINE_CLASS_ID)
  references AIRLINE_CLASS (ID);
alter table AIRLINE_LINKS_AIRLINE_CLASS
  add constraint FKNTOT2DPJP03B6VQQNFC215342 foreign key (AIRLINE_ID)
  references AIRLINE (ID);

prompt Creating CUSTOMER...
create table CUSTOMER
(
  id                   VARCHAR2(36) not null,
  create_date          DATE,
  delete_date          DATE,
  is_delete            CHAR(1),
  update_date          DATE,
  version              NUMBER(10) not null,
  checked_email        VARCHAR2(255),
  checked_phone_number VARCHAR2(255),
  id_number            VARCHAR2(255),
  new_email            VARCHAR2(255),
  new_phone_number     VARCHAR2(255),
  password             VARCHAR2(255),
  password_answer      VARCHAR2(255),
  password_question    VARCHAR2(255),
  phone_check_number   VARCHAR2(255),
  phone_send_time      DATE,
  real_name            VARCHAR2(255),
  remained_distance    NUMBER(19),
  salt                 VARCHAR2(255),
  send_mail_time       DATE,
  url_code             VARCHAR2(255),
  username             VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CUSTOMER
  add primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating COMMON_PASSAGER...
create table COMMON_PASSAGER
(
  id           VARCHAR2(36) not null,
  create_date  DATE,
  delete_date  DATE,
  is_delete    CHAR(1),
  update_date  DATE,
  version      NUMBER(10) not null,
  id_number    VARCHAR2(255),
  id_type      VARCHAR2(255),
  name         VARCHAR2(255),
  phone_number VARCHAR2(255),
  sex          VARCHAR2(255),
  customer_id  VARCHAR2(36)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table COMMON_PASSAGER
  add primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table COMMON_PASSAGER
  add constraint FK18MA7XVOLGW87UCP50AJAD0MF foreign key (CUSTOMER_ID)
  references CUSTOMER (ID);

prompt Creating LEFT_TICKET...
create table LEFT_TICKET
(
  id                VARCHAR2(36) not null,
  create_date       DATE,
  delete_date       DATE,
  is_delete         CHAR(1),
  update_date       DATE,
  version           NUMBER(10) not null,
  departure_date    VARCHAR2(100),
  left_ticket_count NUMBER(10) not null,
  min_price         FLOAT not null,
  sale_ticket_count NUMBER(10) not null,
  airline_id        VARCHAR2(36)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table LEFT_TICKET
  add primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table LEFT_TICKET
  add constraint FK9AJCJQPLHQIAFHDU3JMCXAOWH foreign key (AIRLINE_ID)
  references AIRLINE (ID);

prompt Creating LEFT_TICKET_CLASS...
create table LEFT_TICKET_CLASS
(
  id               VARCHAR2(36) not null,
  create_date      DATE,
  delete_date      DATE,
  is_delete        CHAR(1),
  update_date      DATE,
  version          NUMBER(10) not null,
  cur_price        FLOAT not null,
  discount         FLOAT not null,
  full_price       FLOAT not null,
  left_count       NUMBER(10) not null,
  sale_count       NUMBER(10) not null,
  total_count      NUMBER(10) not null,
  airline_class_id VARCHAR2(36)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table LEFT_TICKET_CLASS
  add primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table LEFT_TICKET_CLASS
  add constraint FKCIXWWRFA5FJ2K4NAHS0CROM0D foreign key (AIRLINE_CLASS_ID)
  references AIRLINE_CLASS (ID);

prompt Creating LEFTTICKET_LINKS_CLASS...
create table LEFTTICKET_LINKS_CLASS
(
  leftticket_id       VARCHAR2(36) not null,
  leftticket_class_id VARCHAR2(36) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table LEFTTICKET_LINKS_CLASS
  add constraint FKC9LGFEC99A1DMD8T245CXUKVP foreign key (LEFTTICKET_CLASS_ID)
  references LEFT_TICKET_CLASS (ID);
alter table LEFTTICKET_LINKS_CLASS
  add constraint FKHT5DCSK46X0OVBY6JXD0B6K5Q foreign key (LEFTTICKET_ID)
  references LEFT_TICKET (ID);

prompt Creating PAYMENT...
create table PAYMENT
(
  id            VARCHAR2(36) not null,
  create_date   DATE,
  delete_date   DATE,
  is_delete     CHAR(1),
  update_date   DATE,
  version       NUMBER(10) not null,
  ip_address    VARCHAR2(255),
  payment_money FLOAT not null,
  payment_num   VARCHAR2(255),
  payment_time  DATE,
  payment_type  NUMBER(10) not null,
  remark        VARCHAR2(255),
  customer_id   VARCHAR2(36)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PAYMENT
  add primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PAYMENT
  add constraint FKBY2SKJF3OV608YB6NM16B49LG foreign key (CUSTOMER_ID)
  references CUSTOMER (ID);

prompt Creating PLANE_LINKS_PLANE_CLASS...
create table PLANE_LINKS_PLANE_CLASS
(
  plane_id       VARCHAR2(36) not null,
  plane_class_id VARCHAR2(36) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PLANE_LINKS_PLANE_CLASS
  add constraint FK2PV2J1F9FKIM30XY5MW5UUKWN foreign key (PLANE_ID)
  references PLANE (ID);
alter table PLANE_LINKS_PLANE_CLASS
  add constraint FKR411YCA7QBX5X551YHWABAJPC foreign key (PLANE_CLASS_ID)
  references PLANE_CLASS (ID);

prompt Creating STAFF...
create table STAFF
(
  id            VARCHAR2(36) not null,
  create_date   DATE,
  delete_date   DATE,
  is_delete     CHAR(1),
  update_date   DATE,
  version       NUMBER(10) not null,
  checked_email VARCHAR2(255),
  is_disable    CHAR(1),
  password      VARCHAR2(255),
  posts         VARCHAR2(255),
  real_name     VARCHAR2(255),
  salt          VARCHAR2(255),
  username      VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table STAFF
  add primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating STAFF_PERMS...
create table STAFF_PERMS
(
  id          VARCHAR2(36) not null,
  create_date DATE,
  delete_date DATE,
  is_delete   CHAR(1),
  update_date DATE,
  version     NUMBER(10) not null,
  jump_url    VARCHAR2(255),
  menu_text   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table STAFF_PERMS
  add primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating STAFF_LINKS_STAFF_PERMS...
create table STAFF_LINKS_STAFF_PERMS
(
  staff_id       VARCHAR2(36) not null,
  staff_perms_id VARCHAR2(36) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table STAFF_LINKS_STAFF_PERMS
  add constraint FK39PAVQVSL5S6S0LAHPPR5EMIU foreign key (STAFF_ID)
  references STAFF (ID);
alter table STAFF_LINKS_STAFF_PERMS
  add constraint FKBVAWFLF68I2RIMUU6B68OJ14Y foreign key (STAFF_PERMS_ID)
  references STAFF_PERMS (ID);

prompt Creating TICKET_ORDER...
create table TICKET_ORDER
(
  id                   VARCHAR2(36) not null,
  create_date          DATE,
  delete_date          DATE,
  is_delete            CHAR(1),
  update_date          DATE,
  version              NUMBER(10) not null,
  delete_by_customer   CHAR(1) not null,
  flight_day           VARCHAR2(255),
  order_date           DATE,
  order_num            VARCHAR2(255),
  order_status         NUMBER(10) not null,
  order_time           DATE,
  order_type           NUMBER(10) not null,
  pay_fee              FLOAT not null,
  airline_id           VARCHAR2(36),
  customer_id          VARCHAR2(36),
  left_ticket_class_id VARCHAR2(36),
  main_order_id        VARCHAR2(36),
  payment_id           VARCHAR2(36),
  left_ticket_id       VARCHAR2(36)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TICKET_ORDER
  add primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TICKET_ORDER
  add constraint FK2139BYR77Q72TTBYRIIOBQSWH foreign key (AIRLINE_ID)
  references AIRLINE (ID);
alter table TICKET_ORDER
  add constraint FK66ASOB1PEKPA97B7B0CLGPDMI foreign key (CUSTOMER_ID)
  references CUSTOMER (ID);
alter table TICKET_ORDER
  add constraint FK9YXK99ALV34YOUV5CQAJ27LVU foreign key (LEFT_TICKET_CLASS_ID)
  references LEFT_TICKET_CLASS (ID);
alter table TICKET_ORDER
  add constraint FKMXN58OGEAUU27HBAL96OTVWCD foreign key (MAIN_ORDER_ID)
  references TICKET_ORDER (ID);
alter table TICKET_ORDER
  add constraint FKOS908KM3VXJWT4BS6NIF68PSB foreign key (LEFT_TICKET_ID)
  references LEFT_TICKET (ID);
alter table TICKET_ORDER
  add constraint FKR216WU66LBNMHE6YWUB1SEMF3 foreign key (PAYMENT_ID)
  references PAYMENT (ID);

prompt Creating SUB_ORDER...
create table SUB_ORDER
(
  id                    VARCHAR2(36) not null,
  pay_fee               FLOAT not null,
  status                NUMBER(10) not null,
  alter_ticket_order_id VARCHAR2(36),
  common_passager_id    VARCHAR2(36),
  refund_payment_id     VARCHAR2(36)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SUB_ORDER
  add primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SUB_ORDER
  add constraint FKI2DS8DGV4QJWAV6VJQNMPSQT foreign key (ALTER_TICKET_ORDER_ID)
  references TICKET_ORDER (ID);
alter table SUB_ORDER
  add constraint FKPKGKPU4OECH7N89R5YCWUOVW0 foreign key (REFUND_PAYMENT_ID)
  references PAYMENT (ID);
alter table SUB_ORDER
  add constraint FKSA68Y3LBE8X3P7AU9UHSG6EX7 foreign key (COMMON_PASSAGER_ID)
  references COMMON_PASSAGER (ID);

prompt Creating TICKET_ORDER_SUB_ORDER_LIST...
create table TICKET_ORDER_SUB_ORDER_LIST
(
  ticket_order_id   VARCHAR2(36) not null,
  sub_order_list_id VARCHAR2(36) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TICKET_ORDER_SUB_ORDER_LIST
  add constraint UK_RS4D7KMB972X6NFJ43P79P4PY unique (SUB_ORDER_LIST_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TICKET_ORDER_SUB_ORDER_LIST
  add constraint FK3C9MC3MVD1FXGBH0S3XML569K foreign key (TICKET_ORDER_ID)
  references TICKET_ORDER (ID);
alter table TICKET_ORDER_SUB_ORDER_LIST
  add constraint FK8SQMHB6LMWX06W8C40Y7R5UGR foreign key (SUB_ORDER_LIST_ID)
  references SUB_ORDER (ID);

prompt Disabling triggers for AIRPORT...
alter table AIRPORT disable all triggers;
prompt Disabling triggers for PLANE...
alter table PLANE disable all triggers;
prompt Disabling triggers for AIRLINE...
alter table AIRLINE disable all triggers;
prompt Disabling triggers for PLANE_CLASS...
alter table PLANE_CLASS disable all triggers;
prompt Disabling triggers for AIRLINE_CLASS...
alter table AIRLINE_CLASS disable all triggers;
prompt Disabling triggers for AIRLINE_LINKS_AIRLINE_CLASS...
alter table AIRLINE_LINKS_AIRLINE_CLASS disable all triggers;
prompt Disabling triggers for CUSTOMER...
alter table CUSTOMER disable all triggers;
prompt Disabling triggers for COMMON_PASSAGER...
alter table COMMON_PASSAGER disable all triggers;
prompt Disabling triggers for LEFT_TICKET...
alter table LEFT_TICKET disable all triggers;
prompt Disabling triggers for LEFT_TICKET_CLASS...
alter table LEFT_TICKET_CLASS disable all triggers;
prompt Disabling triggers for LEFTTICKET_LINKS_CLASS...
alter table LEFTTICKET_LINKS_CLASS disable all triggers;
prompt Disabling triggers for PAYMENT...
alter table PAYMENT disable all triggers;
prompt Disabling triggers for PLANE_LINKS_PLANE_CLASS...
alter table PLANE_LINKS_PLANE_CLASS disable all triggers;
prompt Disabling triggers for STAFF...
alter table STAFF disable all triggers;
prompt Disabling triggers for STAFF_PERMS...
alter table STAFF_PERMS disable all triggers;
prompt Disabling triggers for STAFF_LINKS_STAFF_PERMS...
alter table STAFF_LINKS_STAFF_PERMS disable all triggers;
prompt Disabling triggers for TICKET_ORDER...
alter table TICKET_ORDER disable all triggers;
prompt Disabling triggers for SUB_ORDER...
alter table SUB_ORDER disable all triggers;
prompt Disabling triggers for TICKET_ORDER_SUB_ORDER_LIST...
alter table TICKET_ORDER_SUB_ORDER_LIST disable all triggers;
prompt Disabling foreign key constraints for AIRLINE...
alter table AIRLINE disable constraint FK7U9Y7LVV5IMBWPJDJPN52W9QX;
alter table AIRLINE disable constraint FKP8EM34PS4FC8TQMHU2A927C1S;
alter table AIRLINE disable constraint FKSJ5UMBORTVW6PIRFL6KEGLHUM;
prompt Disabling foreign key constraints for AIRLINE_CLASS...
alter table AIRLINE_CLASS disable constraint FKP03QWM8PPK8LNXXGSO355148;
prompt Disabling foreign key constraints for AIRLINE_LINKS_AIRLINE_CLASS...
alter table AIRLINE_LINKS_AIRLINE_CLASS disable constraint FK4FSWASS89JGVJWW4MK183V9FY;
alter table AIRLINE_LINKS_AIRLINE_CLASS disable constraint FKNTOT2DPJP03B6VQQNFC215342;
prompt Disabling foreign key constraints for COMMON_PASSAGER...
alter table COMMON_PASSAGER disable constraint FK18MA7XVOLGW87UCP50AJAD0MF;
prompt Disabling foreign key constraints for LEFT_TICKET...
alter table LEFT_TICKET disable constraint FK9AJCJQPLHQIAFHDU3JMCXAOWH;
prompt Disabling foreign key constraints for LEFT_TICKET_CLASS...
alter table LEFT_TICKET_CLASS disable constraint FKCIXWWRFA5FJ2K4NAHS0CROM0D;
prompt Disabling foreign key constraints for LEFTTICKET_LINKS_CLASS...
alter table LEFTTICKET_LINKS_CLASS disable constraint FKC9LGFEC99A1DMD8T245CXUKVP;
alter table LEFTTICKET_LINKS_CLASS disable constraint FKHT5DCSK46X0OVBY6JXD0B6K5Q;
prompt Disabling foreign key constraints for PAYMENT...
alter table PAYMENT disable constraint FKBY2SKJF3OV608YB6NM16B49LG;
prompt Disabling foreign key constraints for PLANE_LINKS_PLANE_CLASS...
alter table PLANE_LINKS_PLANE_CLASS disable constraint FK2PV2J1F9FKIM30XY5MW5UUKWN;
alter table PLANE_LINKS_PLANE_CLASS disable constraint FKR411YCA7QBX5X551YHWABAJPC;
prompt Disabling foreign key constraints for STAFF_LINKS_STAFF_PERMS...
alter table STAFF_LINKS_STAFF_PERMS disable constraint FK39PAVQVSL5S6S0LAHPPR5EMIU;
alter table STAFF_LINKS_STAFF_PERMS disable constraint FKBVAWFLF68I2RIMUU6B68OJ14Y;
prompt Disabling foreign key constraints for TICKET_ORDER...
alter table TICKET_ORDER disable constraint FK2139BYR77Q72TTBYRIIOBQSWH;
alter table TICKET_ORDER disable constraint FK66ASOB1PEKPA97B7B0CLGPDMI;
alter table TICKET_ORDER disable constraint FK9YXK99ALV34YOUV5CQAJ27LVU;
alter table TICKET_ORDER disable constraint FKMXN58OGEAUU27HBAL96OTVWCD;
alter table TICKET_ORDER disable constraint FKOS908KM3VXJWT4BS6NIF68PSB;
alter table TICKET_ORDER disable constraint FKR216WU66LBNMHE6YWUB1SEMF3;
prompt Disabling foreign key constraints for SUB_ORDER...
alter table SUB_ORDER disable constraint FKI2DS8DGV4QJWAV6VJQNMPSQT;
alter table SUB_ORDER disable constraint FKPKGKPU4OECH7N89R5YCWUOVW0;
alter table SUB_ORDER disable constraint FKSA68Y3LBE8X3P7AU9UHSG6EX7;
prompt Disabling foreign key constraints for TICKET_ORDER_SUB_ORDER_LIST...
alter table TICKET_ORDER_SUB_ORDER_LIST disable constraint FK3C9MC3MVD1FXGBH0S3XML569K;
alter table TICKET_ORDER_SUB_ORDER_LIST disable constraint FK8SQMHB6LMWX06W8C40Y7R5UGR;
prompt Deleting TICKET_ORDER_SUB_ORDER_LIST...
delete from TICKET_ORDER_SUB_ORDER_LIST;
commit;
prompt Deleting SUB_ORDER...
delete from SUB_ORDER;
commit;
prompt Deleting TICKET_ORDER...
delete from TICKET_ORDER;
commit;
prompt Deleting STAFF_LINKS_STAFF_PERMS...
delete from STAFF_LINKS_STAFF_PERMS;
commit;
prompt Deleting STAFF_PERMS...
delete from STAFF_PERMS;
commit;
prompt Deleting STAFF...
delete from STAFF;
commit;
prompt Deleting PLANE_LINKS_PLANE_CLASS...
delete from PLANE_LINKS_PLANE_CLASS;
commit;
prompt Deleting PAYMENT...
delete from PAYMENT;
commit;
prompt Deleting LEFTTICKET_LINKS_CLASS...
delete from LEFTTICKET_LINKS_CLASS;
commit;
prompt Deleting LEFT_TICKET_CLASS...
delete from LEFT_TICKET_CLASS;
commit;
prompt Deleting LEFT_TICKET...
delete from LEFT_TICKET;
commit;
prompt Deleting COMMON_PASSAGER...
delete from COMMON_PASSAGER;
commit;
prompt Deleting CUSTOMER...
delete from CUSTOMER;
commit;
prompt Deleting AIRLINE_LINKS_AIRLINE_CLASS...
delete from AIRLINE_LINKS_AIRLINE_CLASS;
commit;
prompt Deleting AIRLINE_CLASS...
delete from AIRLINE_CLASS;
commit;
prompt Deleting PLANE_CLASS...
delete from PLANE_CLASS;
commit;
prompt Deleting AIRLINE...
delete from AIRLINE;
commit;
prompt Deleting PLANE...
delete from PLANE;
commit;
prompt Deleting AIRPORT...
delete from AIRPORT;
commit;
prompt Loading AIRPORT...
insert into AIRPORT (id, create_date, delete_date, is_delete, update_date, version, airport_name, city, is_disable, province, short_eng)
values ('c88bf676-68a8-461e-88c8-ef1a418b3ad9', to_date('27-03-2017 00:18:42', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '宝安国际机场', '深圳', 'N', '广东', 'SZ');
insert into AIRPORT (id, create_date, delete_date, is_delete, update_date, version, airport_name, city, is_disable, province, short_eng)
values ('dc4edc25-124e-454a-9c8d-8c90a85eeb0f', to_date('27-03-2017 00:04:43', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('27-03-2017 00:12:19', 'dd-mm-yyyy hh24:mi:ss'), 10, '白云国际机场', '广州', 'N', '广东', 'GZ');
insert into AIRPORT (id, create_date, delete_date, is_delete, update_date, version, airport_name, city, is_disable, province, short_eng)
values ('93fc20c2-9ea1-4a21-86b8-946c559cd249', to_date('02-05-2017 15:24:07', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '虹桥国际机场', '上海', null, '上海', 'SH');
insert into AIRPORT (id, create_date, delete_date, is_delete, update_date, version, airport_name, city, is_disable, province, short_eng)
values ('e93fad37-776b-4550-92ca-fd2da26ffb2a', to_date('02-05-2017 15:24:26', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '北京国际机场', '北京', null, '北京', 'BJ');
insert into AIRPORT (id, create_date, delete_date, is_delete, update_date, version, airport_name, city, is_disable, province, short_eng)
values ('59338fae-d708-4456-a3ea-cb355e6ae114', to_date('02-05-2017 15:24:45', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '长水国际机场', '昆明', null, '云南', 'KM');
insert into AIRPORT (id, create_date, delete_date, is_delete, update_date, version, airport_name, city, is_disable, province, short_eng)
values ('27f2213f-a5d4-4acf-9d24-248a469d1c17', to_date('02-05-2017 15:25:13', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '烤炉国际机场', '成都', null, '四川', 'CD');
insert into AIRPORT (id, create_date, delete_date, is_delete, update_date, version, airport_name, city, is_disable, province, short_eng)
values ('757e7023-eb09-4b98-8172-6b7a95de1bab', to_date('02-05-2017 15:25:33', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '咸阳国际机场', '西安', null, '陕西', 'XA');
insert into AIRPORT (id, create_date, delete_date, is_delete, update_date, version, airport_name, city, is_disable, province, short_eng)
values ('d38f28be-7a4e-4506-8188-d0e63b0ce347', to_date('13-04-2017 15:55:35', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '揭阳潮汕机场', '揭阳', null, '广东', 'JY');
commit;
prompt 8 records loaded
prompt Loading PLANE...
insert into PLANE (id, create_date, delete_date, is_delete, update_date, version, company, is_disable, max_mileage, model_name, seat_count)
values ('b8da2c21-cb77-45d2-a504-5e2789cf7e95', to_date('08-04-2017 12:13:43', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('08-04-2017 12:14:53', 'dd-mm-yyyy hh24:mi:ss'), 2, '测试用飞机', 'N', 998, 'test', 200);
insert into PLANE (id, create_date, delete_date, is_delete, update_date, version, company, is_disable, max_mileage, model_name, seat_count)
values ('30a3b7d0-6873-48ee-b27c-940c8c0062d1', to_date('06-04-2017 22:06:49', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('07-04-2017 14:37:54', 'dd-mm-yyyy hh24:mi:ss'), 8, '波音', 'N', 1500, 'A320', 30);
insert into PLANE (id, create_date, delete_date, is_delete, update_date, version, company, is_disable, max_mileage, model_name, seat_count)
values ('a403c36f-fb79-4b1d-8b36-0f4982dd5126', to_date('30-03-2017 19:05:42', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '空客', 'N', 5000, 'A320', 460);
insert into PLANE (id, create_date, delete_date, is_delete, update_date, version, company, is_disable, max_mileage, model_name, seat_count)
values ('cac87d7e-0680-4c73-b137-8dd3f053b246', to_date('29-03-2017 22:36:48', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('30-03-2017 12:29:00', 'dd-mm-yyyy hh24:mi:ss'), 3, '波音', 'N', 1000, '777', 250);
insert into PLANE (id, create_date, delete_date, is_delete, update_date, version, company, is_disable, max_mileage, model_name, seat_count)
values ('68ed9526-5568-4707-8e2e-d655edd5b239', to_date('13-04-2017 16:02:11', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '波音', null, 999, '747-combie', 210);
insert into PLANE (id, create_date, delete_date, is_delete, update_date, version, company, is_disable, max_mileage, model_name, seat_count)
values ('a8d32f97-6989-44a7-978b-d3db0848b3fc', to_date('07-04-2017 15:15:40', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('07-04-2017 15:16:08', 'dd-mm-yyyy hh24:mi:ss'), 3, '波音', 'N', 900, '747', 180);
insert into PLANE (id, create_date, delete_date, is_delete, update_date, version, company, is_disable, max_mileage, model_name, seat_count)
values ('1876a56f-0716-478e-a103-4dc5e28046e1', to_date('03-05-2017 22:27:21', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '测试', null, 998, 'test1', 50);
commit;
prompt 7 records loaded
prompt Loading AIRLINE...
insert into AIRLINE (id, create_date, delete_date, is_delete, update_date, version, airline_num, airport_construction, arrive_time, friday, fuel_tex, is_disable, mileage, monday, saturday, start_time, sunday, thursday, tuesday, wednesday, departure_airport_id, destination_airport_id, plane_id, status)
values ('f77c02c6-339b-4e2b-a018-4e3cd12a905f', to_date('18-04-2017 14:28:17', 'dd-mm-yyyy hh24:mi:ss'), null, 'Y', to_date('18-04-2017 17:14:52', 'dd-mm-yyyy hh24:mi:ss'), 8, 'CZ9898', 50, to_date('01-01-1970 02:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'Y', 30, 'N', 600, 'Y', 'Y', to_date('01-01-1970 01:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'Y', 'Y', 'Y', 'Y', 'd38f28be-7a4e-4506-8188-d0e63b0ce347', 'dc4edc25-124e-454a-9c8d-8c90a85eeb0f', 'cac87d7e-0680-4c73-b137-8dd3f053b246', 3);
insert into AIRLINE (id, create_date, delete_date, is_delete, update_date, version, airline_num, airport_construction, arrive_time, friday, fuel_tex, is_disable, mileage, monday, saturday, start_time, sunday, thursday, tuesday, wednesday, departure_airport_id, destination_airport_id, plane_id, status)
values ('206f1507-e802-48eb-a78c-17297a545f3d', to_date('18-04-2017 15:27:51', 'dd-mm-yyyy hh24:mi:ss'), null, 'Y', to_date('03-05-2017 22:27:45', 'dd-mm-yyyy hh24:mi:ss'), 2, 'CZ9898', 50, to_date('01-01-1970 05:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'N', 30, 'N', 600, 'N', 'N', to_date('01-01-1970 02:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'N', 'N', 'N', 'N', 'd38f28be-7a4e-4506-8188-d0e63b0ce347', 'dc4edc25-124e-454a-9c8d-8c90a85eeb0f', null, 1);
insert into AIRLINE (id, create_date, delete_date, is_delete, update_date, version, airline_num, airport_construction, arrive_time, friday, fuel_tex, is_disable, mileage, monday, saturday, start_time, sunday, thursday, tuesday, wednesday, departure_airport_id, destination_airport_id, plane_id, status)
values ('5b7c8e64-0ed2-4f69-a0ba-b079373c12b8', to_date('18-04-2017 15:30:14', 'dd-mm-yyyy hh24:mi:ss'), null, 'Y', to_date('03-05-2017 22:27:30', 'dd-mm-yyyy hh24:mi:ss'), 4, 'CZ9898', 50, to_date('01-01-1970', 'dd-mm-yyyy'), 'N', 30, 'N', 600, 'N', 'N', to_date('01-01-1970', 'dd-mm-yyyy'), 'N', 'N', 'N', 'N', 'dc4edc25-124e-454a-9c8d-8c90a85eeb0f', 'dc4edc25-124e-454a-9c8d-8c90a85eeb0f', 'cac87d7e-0680-4c73-b137-8dd3f053b246', 3);
insert into AIRLINE (id, create_date, delete_date, is_delete, update_date, version, airline_num, airport_construction, arrive_time, friday, fuel_tex, is_disable, mileage, monday, saturday, start_time, sunday, thursday, tuesday, wednesday, departure_airport_id, destination_airport_id, plane_id, status)
values ('e778e59f-a899-42d0-a684-1bb2f7fc0c2d', to_date('18-04-2017 15:32:59', 'dd-mm-yyyy hh24:mi:ss'), null, 'Y', to_date('03-05-2017 22:27:49', 'dd-mm-yyyy hh24:mi:ss'), 2, 'CZ9898', 50, to_date('01-01-1970 02:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'Y', 50, 'N', 600, 'Y', 'Y', to_date('01-01-1970 01:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'Y', 'Y', 'Y', 'Y', 'd38f28be-7a4e-4506-8188-d0e63b0ce347', 'dc4edc25-124e-454a-9c8d-8c90a85eeb0f', 'cac87d7e-0680-4c73-b137-8dd3f053b246', 1);
insert into AIRLINE (id, create_date, delete_date, is_delete, update_date, version, airline_num, airport_construction, arrive_time, friday, fuel_tex, is_disable, mileage, monday, saturday, start_time, sunday, thursday, tuesday, wednesday, departure_airport_id, destination_airport_id, plane_id, status)
values ('7f76fa13-8923-4d46-a50a-bc247f56cfe1', to_date('03-05-2017 22:33:04', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('03-05-2017 23:01:53', 'dd-mm-yyyy hh24:mi:ss'), 2, 'test01', 50, to_date('01-01-1970 03:10:00', 'dd-mm-yyyy hh24:mi:ss'), 'Y', 30, 'N', 998, 'Y', 'Y', to_date('01-01-1970 01:05:00', 'dd-mm-yyyy hh24:mi:ss'), 'Y', 'Y', 'Y', 'Y', 'e93fad37-776b-4550-92ca-fd2da26ffb2a', 'dc4edc25-124e-454a-9c8d-8c90a85eeb0f', '1876a56f-0716-478e-a103-4dc5e28046e1', 2);
insert into AIRLINE (id, create_date, delete_date, is_delete, update_date, version, airline_num, airport_construction, arrive_time, friday, fuel_tex, is_disable, mileage, monday, saturday, start_time, sunday, thursday, tuesday, wednesday, departure_airport_id, destination_airport_id, plane_id, status)
values ('4f514a11-a316-426e-8362-bddb2c8d8100', to_date('03-05-2017 22:35:29', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('03-05-2017 23:01:57', 'dd-mm-yyyy hh24:mi:ss'), 2, 'test02', 50, to_date('01-01-1970 05:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'Y', 50, 'N', 1600, 'Y', 'Y', to_date('01-01-1970 03:30:00', 'dd-mm-yyyy hh24:mi:ss'), 'Y', 'Y', 'Y', 'Y', 'd38f28be-7a4e-4506-8188-d0e63b0ce347', 'e93fad37-776b-4550-92ca-fd2da26ffb2a', '1876a56f-0716-478e-a103-4dc5e28046e1', 2);
insert into AIRLINE (id, create_date, delete_date, is_delete, update_date, version, airline_num, airport_construction, arrive_time, friday, fuel_tex, is_disable, mileage, monday, saturday, start_time, sunday, thursday, tuesday, wednesday, departure_airport_id, destination_airport_id, plane_id, status)
values ('1d10cf37-60ad-40ec-bd76-9dc34a875861', to_date('03-05-2017 22:42:17', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('03-05-2017 23:01:59', 'dd-mm-yyyy hh24:mi:ss'), 2, 'test03', 50, to_date('01-01-1970 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'N', 30, 'N', 4500, 'N', 'Y', to_date('01-01-1970 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'Y', 'Y', 'Y', 'N', 'e93fad37-776b-4550-92ca-fd2da26ffb2a', 'dc4edc25-124e-454a-9c8d-8c90a85eeb0f', '1876a56f-0716-478e-a103-4dc5e28046e1', 2);
insert into AIRLINE (id, create_date, delete_date, is_delete, update_date, version, airline_num, airport_construction, arrive_time, friday, fuel_tex, is_disable, mileage, monday, saturday, start_time, sunday, thursday, tuesday, wednesday, departure_airport_id, destination_airport_id, plane_id, status)
values ('75e4e421-b791-4aba-a018-fda347fe62e4', to_date('03-05-2017 22:47:30', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('03-05-2017 23:02:00', 'dd-mm-yyyy hh24:mi:ss'), 2, 'test04', 50, to_date('01-01-1970', 'dd-mm-yyyy'), 'Y', 30, 'N', 1600, 'Y', 'Y', to_date('01-01-1970', 'dd-mm-yyyy'), 'Y', 'N', 'N', 'Y', 'e93fad37-776b-4550-92ca-fd2da26ffb2a', 'dc4edc25-124e-454a-9c8d-8c90a85eeb0f', '1876a56f-0716-478e-a103-4dc5e28046e1', 2);
insert into AIRLINE (id, create_date, delete_date, is_delete, update_date, version, airline_num, airport_construction, arrive_time, friday, fuel_tex, is_disable, mileage, monday, saturday, start_time, sunday, thursday, tuesday, wednesday, departure_airport_id, destination_airport_id, plane_id, status)
values ('3c7e82d6-c3dd-4289-8fa8-9b9aa276b915', to_date('03-05-2017 22:49:14', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('03-05-2017 23:02:02', 'dd-mm-yyyy hh24:mi:ss'), 2, 'test05', 50, to_date('01-01-1970', 'dd-mm-yyyy'), 'N', 30, 'N', 1600, 'N', 'N', to_date('01-01-1970', 'dd-mm-yyyy'), 'N', 'Y', 'Y', 'N', 'e93fad37-776b-4550-92ca-fd2da26ffb2a', 'dc4edc25-124e-454a-9c8d-8c90a85eeb0f', '1876a56f-0716-478e-a103-4dc5e28046e1', 2);
insert into AIRLINE (id, create_date, delete_date, is_delete, update_date, version, airline_num, airport_construction, arrive_time, friday, fuel_tex, is_disable, mileage, monday, saturday, start_time, sunday, thursday, tuesday, wednesday, departure_airport_id, destination_airport_id, plane_id, status)
values ('d3a36299-bea0-46de-b425-aed43ebe309c', to_date('03-05-2017 22:58:29', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('03-05-2017 23:02:03', 'dd-mm-yyyy hh24:mi:ss'), 2, 'test06', 50, to_date('01-01-1970 08:10:00', 'dd-mm-yyyy hh24:mi:ss'), 'Y', 30, 'N', 1500, 'Y', 'Y', to_date('01-01-1970 03:03:00', 'dd-mm-yyyy hh24:mi:ss'), 'N', 'Y', 'N', 'N', 'e93fad37-776b-4550-92ca-fd2da26ffb2a', 'd38f28be-7a4e-4506-8188-d0e63b0ce347', '1876a56f-0716-478e-a103-4dc5e28046e1', 2);
insert into AIRLINE (id, create_date, delete_date, is_delete, update_date, version, airline_num, airport_construction, arrive_time, friday, fuel_tex, is_disable, mileage, monday, saturday, start_time, sunday, thursday, tuesday, wednesday, departure_airport_id, destination_airport_id, plane_id, status)
values ('beff8708-5c24-42c3-806f-37a96fc645e5', to_date('03-05-2017 22:59:33', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('03-05-2017 23:02:06', 'dd-mm-yyyy hh24:mi:ss'), 2, 'test07', 50, to_date('01-01-1970 12:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'Y', 30, 'N', 1600, 'Y', 'Y', to_date('01-01-1970 10:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'Y', 'N', 'Y', 'Y', 'e93fad37-776b-4550-92ca-fd2da26ffb2a', 'dc4edc25-124e-454a-9c8d-8c90a85eeb0f', '1876a56f-0716-478e-a103-4dc5e28046e1', 2);
insert into AIRLINE (id, create_date, delete_date, is_delete, update_date, version, airline_num, airport_construction, arrive_time, friday, fuel_tex, is_disable, mileage, monday, saturday, start_time, sunday, thursday, tuesday, wednesday, departure_airport_id, destination_airport_id, plane_id, status)
values ('70f312ee-b4f0-47b7-92de-e9f622349697', to_date('03-05-2017 23:00:51', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('03-05-2017 23:01:55', 'dd-mm-yyyy hh24:mi:ss'), 2, 'test08', 50, to_date('01-01-1970 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'Y', 30, 'N', 1600, 'Y', 'Y', to_date('01-01-1970 12:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'Y', 'Y', 'Y', 'Y', 'e93fad37-776b-4550-92ca-fd2da26ffb2a', 'dc4edc25-124e-454a-9c8d-8c90a85eeb0f', '1876a56f-0716-478e-a103-4dc5e28046e1', 2);
insert into AIRLINE (id, create_date, delete_date, is_delete, update_date, version, airline_num, airport_construction, arrive_time, friday, fuel_tex, is_disable, mileage, monday, saturday, start_time, sunday, thursday, tuesday, wednesday, departure_airport_id, destination_airport_id, plane_id, status)
values ('732a0b9b-7c8b-4196-9539-37045d437584', to_date('11-05-2017 23:26:47', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('11-05-2017 23:26:54', 'dd-mm-yyyy hh24:mi:ss'), 2, 'test10', 50, to_date('01-01-1970 12:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'Y', 25, 'N', 1800, 'Y', 'Y', to_date('01-01-1970 10:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'Y', 'Y', 'Y', 'Y', 'e93fad37-776b-4550-92ca-fd2da26ffb2a', '59338fae-d708-4456-a3ea-cb355e6ae114', '30a3b7d0-6873-48ee-b27c-940c8c0062d1', 2);
commit;
prompt 13 records loaded
prompt Loading PLANE_CLASS...
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('9eee149c-5836-4b59-bf61-9b50f04f08fe', 0, '新的舱位A', 'newA', 50);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('f7cc6157-b6f9-4b78-8efb-b383512208c2', 0, '新的舱位B', 'newB', 50);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('0381a850-98d4-4fd3-adae-4bf54db38176', 0, '新的舱位C', 'newC', 50);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('0a46726b-6e01-40b0-8020-6583e9623790', 0, '新的舱位D', 'newD', 50);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('0650eed1-940c-4c21-a4e4-8c1114c2a6a5', 0, '头等舱', 'A', 10);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('d71c3a3e-b668-4a74-805f-e54137c6fc76', 0, '商务舱', 'B', 20);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('598d3000-d97d-4ca8-8878-4742a6e6b146', 0, '经济舱', 'D', 250);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('569781fd-5d66-459f-8f3d-66cd85d21d19', 0, '高端经济舱', 'C', 150);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('a939057d-cb6f-4d6a-a2b9-9b00e45756ee', 0, '商务舱', 'B', 50);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('0eeadeb7-8c2d-48f7-8d7b-9fc7216ae34d', 0, '头等舱', 'A', 10);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('29a66ca7-675c-44cc-9c4d-aca90cddf887', 0, '经济舱', 'Y', 250);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('b72c420a-d4a6-4dda-8775-eeab50ddb2e3', 0, '头等舱', 'A', 10);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('ec84ea3b-c52b-4228-8855-d011c997b5a7', 0, '商务舱', 'B', 20);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('a9180fb1-ad04-4df7-94f7-60933d20c492', 0, '头等舱', 'A', 10);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('6e24a0e2-0534-4a51-860b-bd1f6deca79c', 0, '商务舱', 'B', 20);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('d1ad2198-f131-406a-8a6e-8de566c6887a', 0, '头等舱', 'A', 10);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('e2694217-7b6f-44eb-b526-12139f143a73', 0, '商务舱', 'B', 20);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('f1990012-9a57-483f-a441-e80991ab85b6', 0, '头等舱', 'C', 10);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('9575a0f6-2d46-4534-8074-595f58a7e340', 0, '商务舱', 'B', 20);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('0d672a3a-82f3-4bd3-a9e1-c72db3f10994', 0, '头等舱', 'C', 10);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('bc6fbc7e-d91e-4e7f-83a6-e96f69ff8352', 0, '商务舱', 'B', 20);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('58a921d3-ba30-48a9-bd7d-ecd5cf7654b8', 0, '头等舱', 'A', 10);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('bc5fa8ed-41bb-4878-b9f7-759a87ebcfbc', 0, '商务舱', 'B', 20);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('3e02c751-3135-4334-9037-ec7b98d622dc', 0, '高级经济舱', 'C', 50);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('9a042755-f91f-4f3d-a244-5aee8dd34bad', 0, '普通经济舱', 'D', 100);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('b75f485c-1d66-47ca-8bf9-ff06faf48ab4', 0, '头等舱', 'A', 10);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('915b7e47-4b6d-4c0a-a68f-d8835a2203c0', 0, '商务舱', 'B', 20);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('3515d508-06da-4ada-976e-1558b4d32676', 0, '高级经济舱', 'C', 50);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('b18e62cc-aeef-43ed-a885-7456d05ce23f', 0, '普通经济舱', 'D', 100);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('b3940bde-ec6b-4231-a8fb-08d605a8b8a1', 0, '一般经济舱', 'E', 150);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('1eff57ff-aa4a-4f6e-bd0a-1aa737504e8d', 0, '头等舱', 'A', 10);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('ae239a00-10d3-4907-829f-6066d92f543b', 0, '商务舱', 'B', 20);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('4fa90fc9-3aa1-4f24-b1bd-60fd8e2f3160', 0, '高级经济舱', 'C', 50);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('efac3474-34cb-4b09-b182-82f88c21f393', 0, '普通经济舱', 'D', 100);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('7d8c5534-3487-4536-af2f-e6c7a819c3ed', 0, '头等舱', 'A', 10);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('06bed451-9486-4d43-876f-f26cc1e7ae96', 0, '商务舱', 'B', 50);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('0c643609-e218-45d2-8e8e-cf149947c11f', 0, '经济舱', 'C', 150);
insert into PLANE_CLASS (id, left_count, name, simple_name, total_count)
values ('06df110f-6ce3-4584-b742-beb214db55f8', 0, '测试', 'T', 50);
commit;
prompt 38 records loaded
prompt Loading AIRLINE_CLASS...
insert into AIRLINE_CLASS (id, create_date, delete_date, is_delete, update_date, version, after_change_fee, after_refund_fee, before_change_fee, before_refund_fee, default_discount, full_price, name, simple_name, split_time, total_count, plane_class_id)
values ('c656bfd1-ed44-4e53-9fb7-42b838f71d6b', to_date('18-04-2017 14:28:17', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 1000, 1000, 500, 500, 90, 2300, '经济舱', null, 2, 0, '0d672a3a-82f3-4bd3-a9e1-c72db3f10994');
insert into AIRLINE_CLASS (id, create_date, delete_date, is_delete, update_date, version, after_change_fee, after_refund_fee, before_change_fee, before_refund_fee, default_discount, full_price, name, simple_name, split_time, total_count, plane_class_id)
values ('36542701-2869-4679-9134-5bf79d9b9389', to_date('18-04-2017 14:28:17', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 500, 500, 200, 200, 90, 2300, '经济舱', null, 2, 0, 'bc6fbc7e-d91e-4e7f-83a6-e96f69ff8352');
insert into AIRLINE_CLASS (id, create_date, delete_date, is_delete, update_date, version, after_change_fee, after_refund_fee, before_change_fee, before_refund_fee, default_discount, full_price, name, simple_name, split_time, total_count, plane_class_id)
values ('f7f1f6e1-a871-49e7-a605-2e9a8cd9e0af', to_date('18-04-2017 15:27:51', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 500, 500, 200, 200, 70, 2500, '经济舱', null, 2, 0, '0d672a3a-82f3-4bd3-a9e1-c72db3f10994');
insert into AIRLINE_CLASS (id, create_date, delete_date, is_delete, update_date, version, after_change_fee, after_refund_fee, before_change_fee, before_refund_fee, default_discount, full_price, name, simple_name, split_time, total_count, plane_class_id)
values ('dbed58f0-e03a-4195-be32-b0ad80aabe94', to_date('18-04-2017 15:27:51', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 500, 500, 200, 200, 70, 2300, '经济舱', null, 2, 0, 'bc6fbc7e-d91e-4e7f-83a6-e96f69ff8352');
insert into AIRLINE_CLASS (id, create_date, delete_date, is_delete, update_date, version, after_change_fee, after_refund_fee, before_change_fee, before_refund_fee, default_discount, full_price, name, simple_name, split_time, total_count, plane_class_id)
values ('08a0f7dd-1602-4466-8a55-4dfa417d5345', to_date('18-04-2017 15:30:14', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 500, 500, 200, 200, 70, 2300, '经济舱', null, 2, 0, '29a66ca7-675c-44cc-9c4d-aca90cddf887');
insert into AIRLINE_CLASS (id, create_date, delete_date, is_delete, update_date, version, after_change_fee, after_refund_fee, before_change_fee, before_refund_fee, default_discount, full_price, name, simple_name, split_time, total_count, plane_class_id)
values ('99df6b12-89ce-47eb-86da-63197c1c789e', to_date('18-04-2017 15:32:59', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 500, 500, 200, 200, 70, 2300, '经济舱', null, 2, 0, '29a66ca7-675c-44cc-9c4d-aca90cddf887');
insert into AIRLINE_CLASS (id, create_date, delete_date, is_delete, update_date, version, after_change_fee, after_refund_fee, before_change_fee, before_refund_fee, default_discount, full_price, name, simple_name, split_time, total_count, plane_class_id)
values ('07178ad2-3b72-453c-99b5-0b3cc57499a0', to_date('03-05-2017 22:33:04', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 400, 700, 200, 350, 70, 2500, '经济舱', null, 2, 0, '06df110f-6ce3-4584-b742-beb214db55f8');
insert into AIRLINE_CLASS (id, create_date, delete_date, is_delete, update_date, version, after_change_fee, after_refund_fee, before_change_fee, before_refund_fee, default_discount, full_price, name, simple_name, split_time, total_count, plane_class_id)
values ('acbec444-6fa8-4baf-858f-eb1227aeeb09', to_date('03-05-2017 22:35:29', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 500, 1000, 250, 500, 70, 2500, '经济舱', null, 2, 0, '06df110f-6ce3-4584-b742-beb214db55f8');
insert into AIRLINE_CLASS (id, create_date, delete_date, is_delete, update_date, version, after_change_fee, after_refund_fee, before_change_fee, before_refund_fee, default_discount, full_price, name, simple_name, split_time, total_count, plane_class_id)
values ('28e042d3-55b8-4aad-b0e6-334e37fdf9fa', to_date('03-05-2017 22:42:17', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 500, 700, 50, 250, 70, 2500, '经济舱', null, 2, 0, '06df110f-6ce3-4584-b742-beb214db55f8');
insert into AIRLINE_CLASS (id, create_date, delete_date, is_delete, update_date, version, after_change_fee, after_refund_fee, before_change_fee, before_refund_fee, default_discount, full_price, name, simple_name, split_time, total_count, plane_class_id)
values ('df1b5763-f11e-4a3b-a5d8-0cb6e32ad52d', to_date('03-05-2017 22:47:30', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 600, 1000, 300, 500, 60, 2700, '经济舱', null, 2, 0, '06df110f-6ce3-4584-b742-beb214db55f8');
insert into AIRLINE_CLASS (id, create_date, delete_date, is_delete, update_date, version, after_change_fee, after_refund_fee, before_change_fee, before_refund_fee, default_discount, full_price, name, simple_name, split_time, total_count, plane_class_id)
values ('39da0ca1-0828-43c2-b1d0-5d36e3ebb7a2', to_date('03-05-2017 22:49:14', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 300, 500, 150, 300, 70, 2300, '经济舱', null, 2, 0, '06df110f-6ce3-4584-b742-beb214db55f8');
insert into AIRLINE_CLASS (id, create_date, delete_date, is_delete, update_date, version, after_change_fee, after_refund_fee, before_change_fee, before_refund_fee, default_discount, full_price, name, simple_name, split_time, total_count, plane_class_id)
values ('f39da58d-b3fb-4631-9ce7-e7c53df4dbaa', to_date('03-05-2017 22:58:29', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 300, 500, 150, 250, 70, 2300, '经济舱', null, 2, 0, '06df110f-6ce3-4584-b742-beb214db55f8');
insert into AIRLINE_CLASS (id, create_date, delete_date, is_delete, update_date, version, after_change_fee, after_refund_fee, before_change_fee, before_refund_fee, default_discount, full_price, name, simple_name, split_time, total_count, plane_class_id)
values ('d6a28a08-d177-4480-9950-9bdd3a1fb875', to_date('03-05-2017 22:59:33', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 600, 1000, 300, 500, 90, 2300, '经济舱', null, 2, 0, '06df110f-6ce3-4584-b742-beb214db55f8');
insert into AIRLINE_CLASS (id, create_date, delete_date, is_delete, update_date, version, after_change_fee, after_refund_fee, before_change_fee, before_refund_fee, default_discount, full_price, name, simple_name, split_time, total_count, plane_class_id)
values ('de3b94d4-2081-4afc-9731-c49139b1f4b2', to_date('03-05-2017 23:00:51', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 600, 1000, 300, 500, 80, 500, '经济舱', null, 2, 0, '06df110f-6ce3-4584-b742-beb214db55f8');
insert into AIRLINE_CLASS (id, create_date, delete_date, is_delete, update_date, version, after_change_fee, after_refund_fee, before_change_fee, before_refund_fee, default_discount, full_price, name, simple_name, split_time, total_count, plane_class_id)
values ('0217a9a9-8902-4e79-9f83-9b4799be165e', to_date('11-05-2017 23:26:47', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 300, 800, 200, 500, 70, 5000, '头等舱', null, 2, 0, '0d672a3a-82f3-4bd3-a9e1-c72db3f10994');
insert into AIRLINE_CLASS (id, create_date, delete_date, is_delete, update_date, version, after_change_fee, after_refund_fee, before_change_fee, before_refund_fee, default_discount, full_price, name, simple_name, split_time, total_count, plane_class_id)
values ('49914b79-acc0-46b9-ba69-4cd0e8bb1a87', to_date('11-05-2017 23:26:47', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 300, 800, 200, 500, 85, 5000, '商务舱', null, 2, 0, 'bc6fbc7e-d91e-4e7f-83a6-e96f69ff8352');
commit;
prompt 16 records loaded
prompt Loading AIRLINE_LINKS_AIRLINE_CLASS...
insert into AIRLINE_LINKS_AIRLINE_CLASS (airline_id, airline_class_id)
values ('f77c02c6-339b-4e2b-a018-4e3cd12a905f', 'c656bfd1-ed44-4e53-9fb7-42b838f71d6b');
insert into AIRLINE_LINKS_AIRLINE_CLASS (airline_id, airline_class_id)
values ('f77c02c6-339b-4e2b-a018-4e3cd12a905f', '36542701-2869-4679-9134-5bf79d9b9389');
insert into AIRLINE_LINKS_AIRLINE_CLASS (airline_id, airline_class_id)
values ('206f1507-e802-48eb-a78c-17297a545f3d', 'f7f1f6e1-a871-49e7-a605-2e9a8cd9e0af');
insert into AIRLINE_LINKS_AIRLINE_CLASS (airline_id, airline_class_id)
values ('206f1507-e802-48eb-a78c-17297a545f3d', 'dbed58f0-e03a-4195-be32-b0ad80aabe94');
insert into AIRLINE_LINKS_AIRLINE_CLASS (airline_id, airline_class_id)
values ('5b7c8e64-0ed2-4f69-a0ba-b079373c12b8', '08a0f7dd-1602-4466-8a55-4dfa417d5345');
insert into AIRLINE_LINKS_AIRLINE_CLASS (airline_id, airline_class_id)
values ('e778e59f-a899-42d0-a684-1bb2f7fc0c2d', '99df6b12-89ce-47eb-86da-63197c1c789e');
insert into AIRLINE_LINKS_AIRLINE_CLASS (airline_id, airline_class_id)
values ('7f76fa13-8923-4d46-a50a-bc247f56cfe1', '07178ad2-3b72-453c-99b5-0b3cc57499a0');
insert into AIRLINE_LINKS_AIRLINE_CLASS (airline_id, airline_class_id)
values ('4f514a11-a316-426e-8362-bddb2c8d8100', 'acbec444-6fa8-4baf-858f-eb1227aeeb09');
insert into AIRLINE_LINKS_AIRLINE_CLASS (airline_id, airline_class_id)
values ('1d10cf37-60ad-40ec-bd76-9dc34a875861', '28e042d3-55b8-4aad-b0e6-334e37fdf9fa');
insert into AIRLINE_LINKS_AIRLINE_CLASS (airline_id, airline_class_id)
values ('75e4e421-b791-4aba-a018-fda347fe62e4', 'df1b5763-f11e-4a3b-a5d8-0cb6e32ad52d');
insert into AIRLINE_LINKS_AIRLINE_CLASS (airline_id, airline_class_id)
values ('3c7e82d6-c3dd-4289-8fa8-9b9aa276b915', '39da0ca1-0828-43c2-b1d0-5d36e3ebb7a2');
insert into AIRLINE_LINKS_AIRLINE_CLASS (airline_id, airline_class_id)
values ('d3a36299-bea0-46de-b425-aed43ebe309c', 'f39da58d-b3fb-4631-9ce7-e7c53df4dbaa');
insert into AIRLINE_LINKS_AIRLINE_CLASS (airline_id, airline_class_id)
values ('beff8708-5c24-42c3-806f-37a96fc645e5', 'd6a28a08-d177-4480-9950-9bdd3a1fb875');
insert into AIRLINE_LINKS_AIRLINE_CLASS (airline_id, airline_class_id)
values ('70f312ee-b4f0-47b7-92de-e9f622349697', 'de3b94d4-2081-4afc-9731-c49139b1f4b2');
insert into AIRLINE_LINKS_AIRLINE_CLASS (airline_id, airline_class_id)
values ('732a0b9b-7c8b-4196-9539-37045d437584', '0217a9a9-8902-4e79-9f83-9b4799be165e');
insert into AIRLINE_LINKS_AIRLINE_CLASS (airline_id, airline_class_id)
values ('732a0b9b-7c8b-4196-9539-37045d437584', '49914b79-acc0-46b9-ba69-4cd0e8bb1a87');
commit;
prompt 16 records loaded
prompt Loading CUSTOMER...
insert into CUSTOMER (id, create_date, delete_date, is_delete, update_date, version, checked_email, checked_phone_number, id_number, new_email, new_phone_number, password, password_answer, password_question, phone_check_number, phone_send_time, real_name, remained_distance, salt, send_mail_time, url_code, username)
values ('b7d6d462-5cc3-4dce-bd70-334cd1b59a06', to_date('27-04-2017 23:53:28', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('11-05-2017 23:22:42', 'dd-mm-yyyy hh24:mi:ss'), 15, '69676990@qq.com', null, '44520141556322214', null, '18819471306', 'b3421df1df6ab38f5d81581193ef73b5', '李洋', '您的大学班主任？', null, null, '帅哥', null, '179e285e-41c2-4f9e-89dc-974d038031c1', null, null, 'qq69676990');
insert into CUSTOMER (id, create_date, delete_date, is_delete, update_date, version, checked_email, checked_phone_number, id_number, new_email, new_phone_number, password, password_answer, password_question, phone_check_number, phone_send_time, real_name, remained_distance, salt, send_mail_time, url_code, username)
values ('5af1e74d-7e75-49d3-b69f-e20590e21f64', to_date('27-04-2017 15:32:12', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('27-04-2017 15:33:32', 'dd-mm-yyyy hh24:mi:ss'), 2, null, null, '23234144234234', null, '1888888888888', 'c3841ac3fc07acbe86c79ff0d3f51b76', 'dianzi', '您大学学的什么专业？', null, null, '孙悟空', null, '9173411b-dd33-4bf6-92c9-115d67271673', null, null, '孙悟空');
commit;
prompt 2 records loaded
prompt Loading COMMON_PASSAGER...
insert into COMMON_PASSAGER (id, create_date, delete_date, is_delete, update_date, version, id_number, id_type, name, phone_number, sex, customer_id)
values ('05da5165-fc73-4778-b899-99e53ae7a7a5', to_date('09-05-2017 21:34:59', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '44052189451111111', '身份证', '廖伟业', '18819471555', '男', 'b7d6d462-5cc3-4dce-bd70-334cd1b59a06');
insert into COMMON_PASSAGER (id, create_date, delete_date, is_delete, update_date, version, id_number, id_type, name, phone_number, sex, customer_id)
values ('12c1f0eb-f205-4e2c-8d1b-c9f0417b978f', to_date('09-05-2017 21:35:23', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '4561424545445', '身份证', '陈叶涛', '13800138000', '女', 'b7d6d462-5cc3-4dce-bd70-334cd1b59a06');
insert into COMMON_PASSAGER (id, create_date, delete_date, is_delete, update_date, version, id_number, id_type, name, phone_number, sex, customer_id)
values ('5ea4f30f-5000-44e5-a1eb-5a6fae7413df', to_date('10-05-2017 15:48:06', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '4404404440000041122', '身份证', '蔡荣珅', '18818818181', '男', 'b7d6d462-5cc3-4dce-bd70-334cd1b59a06');
insert into COMMON_PASSAGER (id, create_date, delete_date, is_delete, update_date, version, id_number, id_type, name, phone_number, sex, customer_id)
values ('c7d76727-4a28-443e-bf85-ffb0efcffb2b', to_date('11-05-2017 23:19:10', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '123456123456', '身份证', '陈广', '18818818181', '男', 'b7d6d462-5cc3-4dce-bd70-334cd1b59a06');
insert into COMMON_PASSAGER (id, create_date, delete_date, is_delete, update_date, version, id_number, id_type, name, phone_number, sex, customer_id)
values ('5da0dce9-fedb-4dd1-af91-a9d71f26e8b6', to_date('11-05-2017 23:27:52', 'dd-mm-yyyy hh24:mi:ss'), null, 'Y', to_date('11-05-2017 23:31:27', 'dd-mm-yyyy hh24:mi:ss'), 2, '123456', '身份证', '测试', '123456', '男', 'b7d6d462-5cc3-4dce-bd70-334cd1b59a06');
insert into COMMON_PASSAGER (id, create_date, delete_date, is_delete, update_date, version, id_number, id_type, name, phone_number, sex, customer_id)
values ('849a61a2-6c1b-470b-a813-463ae1125f0d', to_date('11-05-2017 23:27:52', 'dd-mm-yyyy hh24:mi:ss'), null, 'Y', to_date('11-05-2017 23:31:24', 'dd-mm-yyyy hh24:mi:ss'), 2, '123456', '身份证', '测试啊', '123456789', '男', 'b7d6d462-5cc3-4dce-bd70-334cd1b59a06');
insert into COMMON_PASSAGER (id, create_date, delete_date, is_delete, update_date, version, id_number, id_type, name, phone_number, sex, customer_id)
values ('aa026662-7909-4f19-bcb9-8c8c82a6d8a6', to_date('30-04-2017 15:24:40', 'dd-mm-yyyy hh24:mi:ss'), null, 'Y', to_date('30-04-2017 15:41:42', 'dd-mm-yyyy hh24:mi:ss'), 2, '445102199408301719', '身份证', '陈耿', '18819471306', '男', 'b7d6d462-5cc3-4dce-bd70-334cd1b59a06');
insert into COMMON_PASSAGER (id, create_date, delete_date, is_delete, update_date, version, id_number, id_type, name, phone_number, sex, customer_id)
values ('562fb221-e386-46c7-9f89-127783f4fc1f', to_date('30-04-2017 15:40:12', 'dd-mm-yyyy hh24:mi:ss'), null, 'Y', to_date('30-04-2017 15:51:59', 'dd-mm-yyyy hh24:mi:ss'), 2, '445102199408301719', '身份证', '帅哥', '18819471306', '男', 'b7d6d462-5cc3-4dce-bd70-334cd1b59a06');
insert into COMMON_PASSAGER (id, create_date, delete_date, is_delete, update_date, version, id_number, id_type, name, phone_number, sex, customer_id)
values ('1942469a-a355-4254-b894-bc6e681589c7', to_date('30-04-2017 15:40:57', 'dd-mm-yyyy hh24:mi:ss'), null, 'Y', to_date('30-04-2017 15:52:01', 'dd-mm-yyyy hh24:mi:ss'), 2, '445102199408301719', '身份证', '帅哥啊', '18819471306', '男', 'b7d6d462-5cc3-4dce-bd70-334cd1b59a06');
insert into COMMON_PASSAGER (id, create_date, delete_date, is_delete, update_date, version, id_number, id_type, name, phone_number, sex, customer_id)
values ('774ad0cb-a9cc-4f8b-b1c8-2ef747d5a507', to_date('30-04-2017 15:41:42', 'dd-mm-yyyy hh24:mi:ss'), null, 'Y', to_date('30-04-2017 15:52:02', 'dd-mm-yyyy hh24:mi:ss'), 2, '445102199408301719', '身份证', '帅哥3', '18819471306', '男', 'b7d6d462-5cc3-4dce-bd70-334cd1b59a06');
insert into COMMON_PASSAGER (id, create_date, delete_date, is_delete, update_date, version, id_number, id_type, name, phone_number, sex, customer_id)
values ('178faa46-8f4f-4b7b-a934-1b23339b7c46', to_date('30-04-2017 15:52:13', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '445102199408301719', '身份证', '陈耿', '18819471306', '男', 'b7d6d462-5cc3-4dce-bd70-334cd1b59a06');
commit;
prompt 11 records loaded
prompt Loading LEFT_TICKET...
insert into LEFT_TICKET (id, create_date, delete_date, is_delete, update_date, version, departure_date, left_ticket_count, min_price, sale_ticket_count, airline_id)
values ('878a0399-4b2c-464c-8fe9-0dfb90410f30', to_date('07-05-2017 21:03:02', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '2017-05-12', 50, 3571.4285714285716, 0, '7f76fa13-8923-4d46-a50a-bc247f56cfe1');
insert into LEFT_TICKET (id, create_date, delete_date, is_delete, update_date, version, departure_date, left_ticket_count, min_price, sale_ticket_count, airline_id)
values ('92405d46-1927-4a4f-9cf8-3868235a89d5', to_date('07-05-2017 21:03:02', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '2017-05-12', 50, 4500, 0, '75e4e421-b791-4aba-a018-fda347fe62e4');
insert into LEFT_TICKET (id, create_date, delete_date, is_delete, update_date, version, departure_date, left_ticket_count, min_price, sale_ticket_count, airline_id)
values ('44022727-6095-40be-8450-b06c0932a796', to_date('07-05-2017 21:03:02', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '2017-05-12', 50, 2555.5555555555557, 0, 'beff8708-5c24-42c3-806f-37a96fc645e5');
insert into LEFT_TICKET (id, create_date, delete_date, is_delete, update_date, version, departure_date, left_ticket_count, min_price, sale_ticket_count, airline_id)
values ('517d0a60-c412-4ab8-8daf-63f0910e9c52', to_date('07-05-2017 21:03:02', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '2017-05-12', 50, 625, 0, '70f312ee-b4f0-47b7-92de-e9f622349697');
insert into LEFT_TICKET (id, create_date, delete_date, is_delete, update_date, version, departure_date, left_ticket_count, min_price, sale_ticket_count, airline_id)
values ('b0d02100-64eb-436e-9862-94632b374be9', to_date('08-05-2017 12:38:31', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '2017-05-13', 50, 3571, 0, '7f76fa13-8923-4d46-a50a-bc247f56cfe1');
insert into LEFT_TICKET (id, create_date, delete_date, is_delete, update_date, version, departure_date, left_ticket_count, min_price, sale_ticket_count, airline_id)
values ('7d70d3db-4797-439a-94ce-20a035f3418d', to_date('08-05-2017 12:38:31', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '2017-05-13', 50, 3571, 0, '1d10cf37-60ad-40ec-bd76-9dc34a875861');
insert into LEFT_TICKET (id, create_date, delete_date, is_delete, update_date, version, departure_date, left_ticket_count, min_price, sale_ticket_count, airline_id)
values ('89818213-1930-4d70-a59b-84a94c214495', to_date('08-05-2017 12:38:31', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '2017-05-13', 50, 4500, 0, '75e4e421-b791-4aba-a018-fda347fe62e4');
insert into LEFT_TICKET (id, create_date, delete_date, is_delete, update_date, version, departure_date, left_ticket_count, min_price, sale_ticket_count, airline_id)
values ('4dffb565-88bc-4434-8c19-fef6cf0ef2d0', to_date('08-05-2017 12:38:31', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '2017-05-13', 50, 2556, 0, 'beff8708-5c24-42c3-806f-37a96fc645e5');
insert into LEFT_TICKET (id, create_date, delete_date, is_delete, update_date, version, departure_date, left_ticket_count, min_price, sale_ticket_count, airline_id)
values ('4d1b8e1f-cf32-417d-8fcc-44874c9c539d', to_date('08-05-2017 12:38:31', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '2017-05-13', 50, 625, 0, '70f312ee-b4f0-47b7-92de-e9f622349697');
insert into LEFT_TICKET (id, create_date, delete_date, is_delete, update_date, version, departure_date, left_ticket_count, min_price, sale_ticket_count, airline_id)
values ('56bb0599-0135-4ac6-8ad4-a9b77208a775', to_date('11-05-2017 23:20:44', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '2017-05-20', 50, 3571, 0, '1d10cf37-60ad-40ec-bd76-9dc34a875861');
insert into LEFT_TICKET (id, create_date, delete_date, is_delete, update_date, version, departure_date, left_ticket_count, min_price, sale_ticket_count, airline_id)
values ('14f26cf2-4338-455a-a392-67afcefde7b0', to_date('11-05-2017 23:20:44', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '2017-05-20', 50, 4500, 0, '75e4e421-b791-4aba-a018-fda347fe62e4');
insert into LEFT_TICKET (id, create_date, delete_date, is_delete, update_date, version, departure_date, left_ticket_count, min_price, sale_ticket_count, airline_id)
values ('8822158c-2bcc-465a-974a-a070d21e1f49', to_date('11-05-2017 23:20:44', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '2017-05-20', 50, 3571, 0, '7f76fa13-8923-4d46-a50a-bc247f56cfe1');
insert into LEFT_TICKET (id, create_date, delete_date, is_delete, update_date, version, departure_date, left_ticket_count, min_price, sale_ticket_count, airline_id)
values ('476bffa7-8c05-4049-bc7c-3f23e6b5b200', to_date('11-05-2017 23:20:44', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '2017-05-20', 50, 2556, 0, 'beff8708-5c24-42c3-806f-37a96fc645e5');
insert into LEFT_TICKET (id, create_date, delete_date, is_delete, update_date, version, departure_date, left_ticket_count, min_price, sale_ticket_count, airline_id)
values ('0f95854c-1a1a-430e-8c81-5b025816ae63', to_date('11-05-2017 23:20:44', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '2017-05-20', 50, 625, 0, '70f312ee-b4f0-47b7-92de-e9f622349697');
insert into LEFT_TICKET (id, create_date, delete_date, is_delete, update_date, version, departure_date, left_ticket_count, min_price, sale_ticket_count, airline_id)
values ('2a837ff5-a984-42d2-8a9a-e6f4245f7418', to_date('11-05-2017 23:27:00', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '2017-05-12', 30, 5882, 0, '732a0b9b-7c8b-4196-9539-37045d437584');
insert into LEFT_TICKET (id, create_date, delete_date, is_delete, update_date, version, departure_date, left_ticket_count, min_price, sale_ticket_count, airline_id)
values ('19d6c27f-c6fb-4f2a-a399-76658df8028c', to_date('12-05-2017 17:20:39', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('12-05-2017 22:14:37', 'dd-mm-yyyy hh24:mi:ss'), 3, '2017-05-14', 48, 3200, 2, '7f76fa13-8923-4d46-a50a-bc247f56cfe1');
insert into LEFT_TICKET (id, create_date, delete_date, is_delete, update_date, version, departure_date, left_ticket_count, min_price, sale_ticket_count, airline_id)
values ('ccf21cca-b542-4d15-8ab0-8686fc60e736', to_date('12-05-2017 17:20:39', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '2017-05-14', 50, 3571, 0, '1d10cf37-60ad-40ec-bd76-9dc34a875861');
insert into LEFT_TICKET (id, create_date, delete_date, is_delete, update_date, version, departure_date, left_ticket_count, min_price, sale_ticket_count, airline_id)
values ('8e6d7fce-13e9-487f-b10a-843c88a982db', to_date('12-05-2017 17:20:39', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '2017-05-14', 50, 4500, 0, '75e4e421-b791-4aba-a018-fda347fe62e4');
insert into LEFT_TICKET (id, create_date, delete_date, is_delete, update_date, version, departure_date, left_ticket_count, min_price, sale_ticket_count, airline_id)
values ('f76ebd0b-fe26-4732-9ee5-fe7a9e97bd8e', to_date('12-05-2017 17:20:39', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '2017-05-14', 50, 2556, 0, 'beff8708-5c24-42c3-806f-37a96fc645e5');
insert into LEFT_TICKET (id, create_date, delete_date, is_delete, update_date, version, departure_date, left_ticket_count, min_price, sale_ticket_count, airline_id)
values ('79201869-efab-40bb-a241-6ed6425763d0', to_date('12-05-2017 17:20:39', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '2017-05-14', 50, 625, 0, '70f312ee-b4f0-47b7-92de-e9f622349697');
insert into LEFT_TICKET (id, create_date, delete_date, is_delete, update_date, version, departure_date, left_ticket_count, min_price, sale_ticket_count, airline_id)
values ('f475840b-8ecc-4e04-93cc-3913e46b8706', to_date('12-05-2017 21:37:22', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '2017-5-12', 50, 3571, 0, '7f76fa13-8923-4d46-a50a-bc247f56cfe1');
commit;
prompt 21 records loaded
prompt Loading LEFT_TICKET_CLASS...
insert into LEFT_TICKET_CLASS (id, create_date, delete_date, is_delete, update_date, version, cur_price, discount, full_price, left_count, sale_count, total_count, airline_class_id)
values ('d0e5a5af-a629-4980-801c-f43e202e965b', to_date('07-05-2017 21:02:52', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 3571.4285714285716, 70, 2500, 50, 0, 50, '07178ad2-3b72-453c-99b5-0b3cc57499a0');
insert into LEFT_TICKET_CLASS (id, create_date, delete_date, is_delete, update_date, version, cur_price, discount, full_price, left_count, sale_count, total_count, airline_class_id)
values ('83ea402b-c1bb-4525-bf6e-d75bfe517eda', to_date('07-05-2017 21:03:02', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 4500, 60, 2700, 50, 0, 50, 'df1b5763-f11e-4a3b-a5d8-0cb6e32ad52d');
insert into LEFT_TICKET_CLASS (id, create_date, delete_date, is_delete, update_date, version, cur_price, discount, full_price, left_count, sale_count, total_count, airline_class_id)
values ('e4f7918e-028d-451a-a361-ef8d2fb9da7b', to_date('07-05-2017 21:03:02', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 2555.5555555555557, 90, 2300, 50, 0, 50, 'd6a28a08-d177-4480-9950-9bdd3a1fb875');
insert into LEFT_TICKET_CLASS (id, create_date, delete_date, is_delete, update_date, version, cur_price, discount, full_price, left_count, sale_count, total_count, airline_class_id)
values ('a1fcf6a9-2c9a-4924-b872-7b62c8ca6af4', to_date('07-05-2017 21:03:02', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 625, 80, 500, 50, 0, 50, 'de3b94d4-2081-4afc-9731-c49139b1f4b2');
insert into LEFT_TICKET_CLASS (id, create_date, delete_date, is_delete, update_date, version, cur_price, discount, full_price, left_count, sale_count, total_count, airline_class_id)
values ('51745fc6-a1fb-4db5-993a-de79a96bdbfd', to_date('08-05-2017 12:38:31', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('12-05-2017 17:15:21', 'dd-mm-yyyy hh24:mi:ss'), 9, 3571, 70, 2500, 39, 11, 50, '07178ad2-3b72-453c-99b5-0b3cc57499a0');
insert into LEFT_TICKET_CLASS (id, create_date, delete_date, is_delete, update_date, version, cur_price, discount, full_price, left_count, sale_count, total_count, airline_class_id)
values ('00d115c1-eec7-47bf-8696-ccc4e681742d', to_date('08-05-2017 12:38:31', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('11-05-2017 20:36:25', 'dd-mm-yyyy hh24:mi:ss'), 2, 3571, 70, 2500, 48, 2, 50, '28e042d3-55b8-4aad-b0e6-334e37fdf9fa');
insert into LEFT_TICKET_CLASS (id, create_date, delete_date, is_delete, update_date, version, cur_price, discount, full_price, left_count, sale_count, total_count, airline_class_id)
values ('d7cd3321-876c-48d6-844f-af883754c22b', to_date('08-05-2017 12:38:31', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 4500, 60, 2700, 50, 0, 50, 'df1b5763-f11e-4a3b-a5d8-0cb6e32ad52d');
insert into LEFT_TICKET_CLASS (id, create_date, delete_date, is_delete, update_date, version, cur_price, discount, full_price, left_count, sale_count, total_count, airline_class_id)
values ('8ddfef89-950f-49b4-a05a-aaee21bbfa8a', to_date('08-05-2017 12:38:31', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 2556, 90, 2300, 50, 0, 50, 'd6a28a08-d177-4480-9950-9bdd3a1fb875');
insert into LEFT_TICKET_CLASS (id, create_date, delete_date, is_delete, update_date, version, cur_price, discount, full_price, left_count, sale_count, total_count, airline_class_id)
values ('fd6360ef-f044-4152-9dba-b0fb4e37190f', to_date('08-05-2017 12:38:31', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 625, 80, 500, 50, 0, 50, 'de3b94d4-2081-4afc-9731-c49139b1f4b2');
insert into LEFT_TICKET_CLASS (id, create_date, delete_date, is_delete, update_date, version, cur_price, discount, full_price, left_count, sale_count, total_count, airline_class_id)
values ('d42dec22-1d5f-4d27-af2d-683f2b4bc554', to_date('11-05-2017 23:20:44', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 3571, 70, 2500, 50, 0, 50, '28e042d3-55b8-4aad-b0e6-334e37fdf9fa');
insert into LEFT_TICKET_CLASS (id, create_date, delete_date, is_delete, update_date, version, cur_price, discount, full_price, left_count, sale_count, total_count, airline_class_id)
values ('1509d6e3-db7f-42ee-9fcc-11b210b53d8c', to_date('11-05-2017 23:20:44', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 4500, 60, 2700, 50, 0, 50, 'df1b5763-f11e-4a3b-a5d8-0cb6e32ad52d');
insert into LEFT_TICKET_CLASS (id, create_date, delete_date, is_delete, update_date, version, cur_price, discount, full_price, left_count, sale_count, total_count, airline_class_id)
values ('90858093-c4f1-47c5-882d-96c6971d18f0', to_date('11-05-2017 23:20:44', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 3571, 70, 2500, 50, 0, 50, '07178ad2-3b72-453c-99b5-0b3cc57499a0');
insert into LEFT_TICKET_CLASS (id, create_date, delete_date, is_delete, update_date, version, cur_price, discount, full_price, left_count, sale_count, total_count, airline_class_id)
values ('5d4d6e1d-68c6-46bb-961f-602d1793ae3e', to_date('11-05-2017 23:20:44', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 2556, 90, 2300, 50, 0, 50, 'd6a28a08-d177-4480-9950-9bdd3a1fb875');
insert into LEFT_TICKET_CLASS (id, create_date, delete_date, is_delete, update_date, version, cur_price, discount, full_price, left_count, sale_count, total_count, airline_class_id)
values ('3b58210d-eabc-460f-867d-16a3d6d979c5', to_date('11-05-2017 23:20:44', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 625, 80, 500, 50, 0, 50, 'de3b94d4-2081-4afc-9731-c49139b1f4b2');
insert into LEFT_TICKET_CLASS (id, create_date, delete_date, is_delete, update_date, version, cur_price, discount, full_price, left_count, sale_count, total_count, airline_class_id)
values ('7826cff9-ae11-4d56-8ad1-3adca5b88522', to_date('11-05-2017 23:27:00', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('12-05-2017 14:36:18', 'dd-mm-yyyy hh24:mi:ss'), 5, 7143, 70, 5000, 10, 0, 10, '0217a9a9-8902-4e79-9f83-9b4799be165e');
insert into LEFT_TICKET_CLASS (id, create_date, delete_date, is_delete, update_date, version, cur_price, discount, full_price, left_count, sale_count, total_count, airline_class_id)
values ('105952c3-83d0-4599-943c-24e6d0c49e86', to_date('11-05-2017 23:27:00', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 5882, 85, 5000, 20, 0, 20, '49914b79-acc0-46b9-ba69-4cd0e8bb1a87');
insert into LEFT_TICKET_CLASS (id, create_date, delete_date, is_delete, update_date, version, cur_price, discount, full_price, left_count, sale_count, total_count, airline_class_id)
values ('47f54c9b-7fd4-4e77-8e7c-58370f5fad0d', to_date('12-05-2017 17:20:39', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('12-05-2017 22:14:37', 'dd-mm-yyyy hh24:mi:ss'), 7, 3200, 128, 2500, 48, 2, 50, '07178ad2-3b72-453c-99b5-0b3cc57499a0');
insert into LEFT_TICKET_CLASS (id, create_date, delete_date, is_delete, update_date, version, cur_price, discount, full_price, left_count, sale_count, total_count, airline_class_id)
values ('970b4eda-b1ff-4d39-b1b4-ade426dcba6d', to_date('12-05-2017 17:20:39', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 3571, 70, 2500, 50, 0, 50, '28e042d3-55b8-4aad-b0e6-334e37fdf9fa');
insert into LEFT_TICKET_CLASS (id, create_date, delete_date, is_delete, update_date, version, cur_price, discount, full_price, left_count, sale_count, total_count, airline_class_id)
values ('b9678fca-b2ca-48fc-a645-539fdc624289', to_date('12-05-2017 17:20:39', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 4500, 60, 2700, 50, 0, 50, 'df1b5763-f11e-4a3b-a5d8-0cb6e32ad52d');
insert into LEFT_TICKET_CLASS (id, create_date, delete_date, is_delete, update_date, version, cur_price, discount, full_price, left_count, sale_count, total_count, airline_class_id)
values ('a67efd72-9223-4058-b4e0-bad5a088d922', to_date('12-05-2017 17:20:39', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 2556, 90, 2300, 50, 0, 50, 'd6a28a08-d177-4480-9950-9bdd3a1fb875');
insert into LEFT_TICKET_CLASS (id, create_date, delete_date, is_delete, update_date, version, cur_price, discount, full_price, left_count, sale_count, total_count, airline_class_id)
values ('446b9260-da18-4906-b25e-e7f2632b43dd', to_date('12-05-2017 17:20:39', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 625, 80, 500, 50, 0, 50, 'de3b94d4-2081-4afc-9731-c49139b1f4b2');
insert into LEFT_TICKET_CLASS (id, create_date, delete_date, is_delete, update_date, version, cur_price, discount, full_price, left_count, sale_count, total_count, airline_class_id)
values ('9dd9dd73-17e7-4f21-b087-5e3cbb979123', to_date('12-05-2017 21:37:22', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 3571, 70, 2500, 50, 0, 50, '07178ad2-3b72-453c-99b5-0b3cc57499a0');
commit;
prompt 22 records loaded
prompt Loading LEFTTICKET_LINKS_CLASS...
insert into LEFTTICKET_LINKS_CLASS (leftticket_id, leftticket_class_id)
values ('878a0399-4b2c-464c-8fe9-0dfb90410f30', 'd0e5a5af-a629-4980-801c-f43e202e965b');
insert into LEFTTICKET_LINKS_CLASS (leftticket_id, leftticket_class_id)
values ('92405d46-1927-4a4f-9cf8-3868235a89d5', '83ea402b-c1bb-4525-bf6e-d75bfe517eda');
insert into LEFTTICKET_LINKS_CLASS (leftticket_id, leftticket_class_id)
values ('44022727-6095-40be-8450-b06c0932a796', 'e4f7918e-028d-451a-a361-ef8d2fb9da7b');
insert into LEFTTICKET_LINKS_CLASS (leftticket_id, leftticket_class_id)
values ('517d0a60-c412-4ab8-8daf-63f0910e9c52', 'a1fcf6a9-2c9a-4924-b872-7b62c8ca6af4');
insert into LEFTTICKET_LINKS_CLASS (leftticket_id, leftticket_class_id)
values ('b0d02100-64eb-436e-9862-94632b374be9', '51745fc6-a1fb-4db5-993a-de79a96bdbfd');
insert into LEFTTICKET_LINKS_CLASS (leftticket_id, leftticket_class_id)
values ('7d70d3db-4797-439a-94ce-20a035f3418d', '00d115c1-eec7-47bf-8696-ccc4e681742d');
insert into LEFTTICKET_LINKS_CLASS (leftticket_id, leftticket_class_id)
values ('89818213-1930-4d70-a59b-84a94c214495', 'd7cd3321-876c-48d6-844f-af883754c22b');
insert into LEFTTICKET_LINKS_CLASS (leftticket_id, leftticket_class_id)
values ('4dffb565-88bc-4434-8c19-fef6cf0ef2d0', '8ddfef89-950f-49b4-a05a-aaee21bbfa8a');
insert into LEFTTICKET_LINKS_CLASS (leftticket_id, leftticket_class_id)
values ('4d1b8e1f-cf32-417d-8fcc-44874c9c539d', 'fd6360ef-f044-4152-9dba-b0fb4e37190f');
insert into LEFTTICKET_LINKS_CLASS (leftticket_id, leftticket_class_id)
values ('56bb0599-0135-4ac6-8ad4-a9b77208a775', 'd42dec22-1d5f-4d27-af2d-683f2b4bc554');
insert into LEFTTICKET_LINKS_CLASS (leftticket_id, leftticket_class_id)
values ('14f26cf2-4338-455a-a392-67afcefde7b0', '1509d6e3-db7f-42ee-9fcc-11b210b53d8c');
insert into LEFTTICKET_LINKS_CLASS (leftticket_id, leftticket_class_id)
values ('8822158c-2bcc-465a-974a-a070d21e1f49', '90858093-c4f1-47c5-882d-96c6971d18f0');
insert into LEFTTICKET_LINKS_CLASS (leftticket_id, leftticket_class_id)
values ('476bffa7-8c05-4049-bc7c-3f23e6b5b200', '5d4d6e1d-68c6-46bb-961f-602d1793ae3e');
insert into LEFTTICKET_LINKS_CLASS (leftticket_id, leftticket_class_id)
values ('0f95854c-1a1a-430e-8c81-5b025816ae63', '3b58210d-eabc-460f-867d-16a3d6d979c5');
insert into LEFTTICKET_LINKS_CLASS (leftticket_id, leftticket_class_id)
values ('2a837ff5-a984-42d2-8a9a-e6f4245f7418', '7826cff9-ae11-4d56-8ad1-3adca5b88522');
insert into LEFTTICKET_LINKS_CLASS (leftticket_id, leftticket_class_id)
values ('2a837ff5-a984-42d2-8a9a-e6f4245f7418', '105952c3-83d0-4599-943c-24e6d0c49e86');
insert into LEFTTICKET_LINKS_CLASS (leftticket_id, leftticket_class_id)
values ('19d6c27f-c6fb-4f2a-a399-76658df8028c', '47f54c9b-7fd4-4e77-8e7c-58370f5fad0d');
insert into LEFTTICKET_LINKS_CLASS (leftticket_id, leftticket_class_id)
values ('ccf21cca-b542-4d15-8ab0-8686fc60e736', '970b4eda-b1ff-4d39-b1b4-ade426dcba6d');
insert into LEFTTICKET_LINKS_CLASS (leftticket_id, leftticket_class_id)
values ('8e6d7fce-13e9-487f-b10a-843c88a982db', 'b9678fca-b2ca-48fc-a645-539fdc624289');
insert into LEFTTICKET_LINKS_CLASS (leftticket_id, leftticket_class_id)
values ('f76ebd0b-fe26-4732-9ee5-fe7a9e97bd8e', 'a67efd72-9223-4058-b4e0-bad5a088d922');
insert into LEFTTICKET_LINKS_CLASS (leftticket_id, leftticket_class_id)
values ('79201869-efab-40bb-a241-6ed6425763d0', '446b9260-da18-4906-b25e-e7f2632b43dd');
insert into LEFTTICKET_LINKS_CLASS (leftticket_id, leftticket_class_id)
values ('f475840b-8ecc-4e04-93cc-3913e46b8706', '9dd9dd73-17e7-4f21-b087-5e3cbb979123');
commit;
prompt 22 records loaded
prompt Loading PAYMENT...
insert into PAYMENT (id, create_date, delete_date, is_delete, update_date, version, ip_address, payment_money, payment_num, payment_time, payment_type, remark, customer_id)
values ('190c0345-7086-4bb8-9702-88d58965c136', to_date('11-05-2017 20:29:05', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '0:0:0:0:0:0:0:1', 14284, '1494505745186001', to_date('11-05-2017 20:29:05', 'dd-mm-yyyy hh24:mi:ss'), 1, null, null);
insert into PAYMENT (id, create_date, delete_date, is_delete, update_date, version, ip_address, payment_money, payment_num, payment_time, payment_type, remark, customer_id)
values ('8b9088c8-5c08-4607-9a2b-8d609edaf21c', to_date('11-05-2017 21:50:48', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '0:0:0:0:0:0:0:1', 14284, '1494510644208001', to_date('11-05-2017 21:50:44', 'dd-mm-yyyy hh24:mi:ss'), 1, null, null);
insert into PAYMENT (id, create_date, delete_date, is_delete, update_date, version, ip_address, payment_money, payment_num, payment_time, payment_type, remark, customer_id)
values ('1ee334cd-9c31-4742-b396-5db94e5572cb', to_date('11-05-2017 23:19:24', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '127.0.0.1', 3571, '1494515959789001', to_date('11-05-2017 23:19:19', 'dd-mm-yyyy hh24:mi:ss'), 1, null, 'b7d6d462-5cc3-4dce-bd70-334cd1b59a06');
insert into PAYMENT (id, create_date, delete_date, is_delete, update_date, version, ip_address, payment_money, payment_num, payment_time, payment_type, remark, customer_id)
values ('cdbc62f8-ecd7-4572-bf50-4d133b8a6c3d', to_date('12-05-2017 17:17:03', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '0:0:0:0:0:0:0:1', 7142, '1494580623688001', to_date('12-05-2017 17:17:03', 'dd-mm-yyyy hh24:mi:ss'), 1, null, 'b7d6d462-5cc3-4dce-bd70-334cd1b59a06');
insert into PAYMENT (id, create_date, delete_date, is_delete, update_date, version, ip_address, payment_money, payment_num, payment_time, payment_type, remark, customer_id)
values ('b34cf75f-6e0c-4677-a30e-7c9f36072ae5', to_date('12-05-2017 17:21:07', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '127.0.0.1', 7142, '1494580867040001', to_date('12-05-2017 17:21:07', 'dd-mm-yyyy hh24:mi:ss'), 1, null, 'b7d6d462-5cc3-4dce-bd70-334cd1b59a06');
commit;
prompt 5 records loaded
prompt Loading PLANE_LINKS_PLANE_CLASS...
insert into PLANE_LINKS_PLANE_CLASS (plane_id, plane_class_id)
values ('b8da2c21-cb77-45d2-a504-5e2789cf7e95', '9eee149c-5836-4b59-bf61-9b50f04f08fe');
insert into PLANE_LINKS_PLANE_CLASS (plane_id, plane_class_id)
values ('b8da2c21-cb77-45d2-a504-5e2789cf7e95', 'f7cc6157-b6f9-4b78-8efb-b383512208c2');
insert into PLANE_LINKS_PLANE_CLASS (plane_id, plane_class_id)
values ('b8da2c21-cb77-45d2-a504-5e2789cf7e95', '0381a850-98d4-4fd3-adae-4bf54db38176');
insert into PLANE_LINKS_PLANE_CLASS (plane_id, plane_class_id)
values ('b8da2c21-cb77-45d2-a504-5e2789cf7e95', '0a46726b-6e01-40b0-8020-6583e9623790');
insert into PLANE_LINKS_PLANE_CLASS (plane_id, plane_class_id)
values ('a403c36f-fb79-4b1d-8b36-0f4982dd5126', '598d3000-d97d-4ca8-8878-4742a6e6b146');
insert into PLANE_LINKS_PLANE_CLASS (plane_id, plane_class_id)
values ('a403c36f-fb79-4b1d-8b36-0f4982dd5126', '569781fd-5d66-459f-8f3d-66cd85d21d19');
insert into PLANE_LINKS_PLANE_CLASS (plane_id, plane_class_id)
values ('a403c36f-fb79-4b1d-8b36-0f4982dd5126', 'a939057d-cb6f-4d6a-a2b9-9b00e45756ee');
insert into PLANE_LINKS_PLANE_CLASS (plane_id, plane_class_id)
values ('a403c36f-fb79-4b1d-8b36-0f4982dd5126', '0eeadeb7-8c2d-48f7-8d7b-9fc7216ae34d');
insert into PLANE_LINKS_PLANE_CLASS (plane_id, plane_class_id)
values ('cac87d7e-0680-4c73-b137-8dd3f053b246', '29a66ca7-675c-44cc-9c4d-aca90cddf887');
insert into PLANE_LINKS_PLANE_CLASS (plane_id, plane_class_id)
values ('30a3b7d0-6873-48ee-b27c-940c8c0062d1', '0d672a3a-82f3-4bd3-a9e1-c72db3f10994');
insert into PLANE_LINKS_PLANE_CLASS (plane_id, plane_class_id)
values ('30a3b7d0-6873-48ee-b27c-940c8c0062d1', 'bc6fbc7e-d91e-4e7f-83a6-e96f69ff8352');
insert into PLANE_LINKS_PLANE_CLASS (plane_id, plane_class_id)
values ('a8d32f97-6989-44a7-978b-d3db0848b3fc', '1eff57ff-aa4a-4f6e-bd0a-1aa737504e8d');
insert into PLANE_LINKS_PLANE_CLASS (plane_id, plane_class_id)
values ('a8d32f97-6989-44a7-978b-d3db0848b3fc', 'ae239a00-10d3-4907-829f-6066d92f543b');
insert into PLANE_LINKS_PLANE_CLASS (plane_id, plane_class_id)
values ('a8d32f97-6989-44a7-978b-d3db0848b3fc', '4fa90fc9-3aa1-4f24-b1bd-60fd8e2f3160');
insert into PLANE_LINKS_PLANE_CLASS (plane_id, plane_class_id)
values ('a8d32f97-6989-44a7-978b-d3db0848b3fc', 'efac3474-34cb-4b09-b182-82f88c21f393');
insert into PLANE_LINKS_PLANE_CLASS (plane_id, plane_class_id)
values ('68ed9526-5568-4707-8e2e-d655edd5b239', '7d8c5534-3487-4536-af2f-e6c7a819c3ed');
insert into PLANE_LINKS_PLANE_CLASS (plane_id, plane_class_id)
values ('68ed9526-5568-4707-8e2e-d655edd5b239', '06bed451-9486-4d43-876f-f26cc1e7ae96');
insert into PLANE_LINKS_PLANE_CLASS (plane_id, plane_class_id)
values ('68ed9526-5568-4707-8e2e-d655edd5b239', '0c643609-e218-45d2-8e8e-cf149947c11f');
insert into PLANE_LINKS_PLANE_CLASS (plane_id, plane_class_id)
values ('1876a56f-0716-478e-a103-4dc5e28046e1', '06df110f-6ce3-4584-b742-beb214db55f8');
commit;
prompt 19 records loaded
prompt Loading STAFF...
insert into STAFF (id, create_date, delete_date, is_delete, update_date, version, checked_email, is_disable, password, posts, real_name, salt, username)
values ('8ece6247-36a2-413b-9fbc-8d11600d7d7f', to_date('24-03-2017 14:41:26', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '13800@qq.com', 'N', '8e193a24eff7c54f337cf167f8bcca20', '超级管理员', '超级管理员', '6ef627f9-e2ba-4639-9508-4ef709dcd999', 'superadmin');
insert into STAFF (id, create_date, delete_date, is_delete, update_date, version, checked_email, is_disable, password, posts, real_name, salt, username)
values ('7c1b19f4-d399-4244-ad62-9debf1eaf698', to_date('24-03-2017 14:45:30', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '69676990@qq.com', 'N', '63746df7919519060f5a790de7d3657b', '助理管理员', '陈耿', 'ecb9728b-85d5-47f4-b7dc-205a006fe404', 'qq69676990');
insert into STAFF (id, create_date, delete_date, is_delete, update_date, version, checked_email, is_disable, password, posts, real_name, salt, username)
values ('63733dee-e4b7-4770-a1bc-1d3d0e5e199f', to_date('24-03-2017 14:46:10', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('13-05-2017 00:03:04', 'dd-mm-yyyy hh24:mi:ss'), 8, '69676990@qq.com', 'N', 'eb16b16f90a20d7a9e118be216f97c41', '测试人员', '测试员', '81023998-32a4-486a-924d-bdb3cdea00f0', 'testadmin1');
insert into STAFF (id, create_date, delete_date, is_delete, update_date, version, checked_email, is_disable, password, posts, real_name, salt, username)
values ('d48bdc42-5bb2-4b45-91fc-170a7c1cf9e8', to_date('24-03-2017 14:46:53', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('10-04-2017 11:43:59', 'dd-mm-yyyy hh24:mi:ss'), 3, 'test@qq.com', 'N', '9bf0933e7b1c06295d506ce829dab0d9', '测试', '测试', '8befae26-ef2c-449d-8e9e-683977943cec', 'testadmin2');
insert into STAFF (id, create_date, delete_date, is_delete, update_date, version, checked_email, is_disable, password, posts, real_name, salt, username)
values ('f1a58dab-0bc1-4364-be80-b5a21e7b7005', to_date('24-03-2017 14:47:19', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 'test@qq.com', 'N', 'd7d4802b454b4b9367576a6a60909402', '测试', '测试', '6da21740-1e1a-434c-beb4-a378149d379f', 'testadmin3');
insert into STAFF (id, create_date, delete_date, is_delete, update_date, version, checked_email, is_disable, password, posts, real_name, salt, username)
values ('c53f016c-3f57-49b7-960a-9e55474d0b26', to_date('24-03-2017 14:49:58', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 'test@qq.com', 'N', '513c20d5cbacb33c5f5b3d08a55fcf26', '测试', '测试', 'ac023b44-bd57-4b7e-9e8b-189b4d292727', 'testadmin4');
insert into STAFF (id, create_date, delete_date, is_delete, update_date, version, checked_email, is_disable, password, posts, real_name, salt, username)
values ('55d0c610-11b7-4d00-a164-81fd5545ec78', to_date('24-03-2017 14:50:19', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, 'test@qq.com', 'N', '5ea83056a27a23db58aaa86a6c315e6f', '测试', '测试', '9e255dee-15db-44d7-b772-2dee343c0e7e', 'testadmin5');
insert into STAFF (id, create_date, delete_date, is_delete, update_date, version, checked_email, is_disable, password, posts, real_name, salt, username)
values ('225a079c-5767-420a-87df-66fffe372e61', to_date('23-03-2017 11:07:00', 'dd-mm-yyyy hh24:mi:ss'), null, 'Y', to_date('24-03-2017 14:43:25', 'dd-mm-yyyy hh24:mi:ss'), 21, '123456@qq.com', 'N', '16046d297430759c6f3a034aab2d641b', '管理员', '管理员', '7dd6a9a4-56fe-40df-9f1a-73d6c0d5897e', 'testadmin');
commit;
prompt 8 records loaded
prompt Loading STAFF_PERMS...
insert into STAFF_PERMS (id, create_date, delete_date, is_delete, update_date, version, jump_url, menu_text)
values ('eeb2ab61-15c0-49c7-987f-da46254d5e89', to_date('28-02-2017 17:05:36', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '/staff/', '员工管理');
insert into STAFF_PERMS (id, create_date, delete_date, is_delete, update_date, version, jump_url, menu_text)
values ('9c90b7e9-67c2-417b-bbc5-3645f7300b38', to_date('28-02-2017 17:06:25', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '/plane/', '机型管理');
insert into STAFF_PERMS (id, create_date, delete_date, is_delete, update_date, version, jump_url, menu_text)
values ('dd0e0b68-ec05-4ae6-aee3-414419e33ea7', to_date('28-02-2017 17:07:06', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '/airline/', '航班管理');
insert into STAFF_PERMS (id, create_date, delete_date, is_delete, update_date, version, jump_url, menu_text)
values ('4e600bc4-774d-4742-9661-b721c6b33e6d', to_date('28-02-2017 17:07:50', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '/ticketprice/', '票价管理');
insert into STAFF_PERMS (id, create_date, delete_date, is_delete, update_date, version, jump_url, menu_text)
values ('252566fd-10dd-41b9-b62c-29acc53b24b9', to_date('28-02-2017 17:08:25', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '/order/', '订单管理');
insert into STAFF_PERMS (id, create_date, delete_date, is_delete, update_date, version, jump_url, menu_text)
values ('47e7ea31-f044-4161-8d0e-9141a2ec9fb6', to_date('28-02-2017 17:08:56', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '/assistorder/', '协助购票');
insert into STAFF_PERMS (id, create_date, delete_date, is_delete, update_date, version, jump_url, menu_text)
values ('395d63ae-7a84-42f1-a97d-0850118490c8', to_date('28-02-2017 17:09:39', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '/airport/', '机场管理');
insert into STAFF_PERMS (id, create_date, delete_date, is_delete, update_date, version, jump_url, menu_text)
values ('8b6763dd-90e3-44d1-9093-5f4155571da5', to_date('28-02-2017 17:10:12', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '/information/', '个人信息管理');
commit;
prompt 8 records loaded
prompt Loading STAFF_LINKS_STAFF_PERMS...
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('8ece6247-36a2-413b-9fbc-8d11600d7d7f', 'eeb2ab61-15c0-49c7-987f-da46254d5e89');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('8ece6247-36a2-413b-9fbc-8d11600d7d7f', '9c90b7e9-67c2-417b-bbc5-3645f7300b38');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('8ece6247-36a2-413b-9fbc-8d11600d7d7f', 'dd0e0b68-ec05-4ae6-aee3-414419e33ea7');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('8ece6247-36a2-413b-9fbc-8d11600d7d7f', '4e600bc4-774d-4742-9661-b721c6b33e6d');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('8ece6247-36a2-413b-9fbc-8d11600d7d7f', '252566fd-10dd-41b9-b62c-29acc53b24b9');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('8ece6247-36a2-413b-9fbc-8d11600d7d7f', '47e7ea31-f044-4161-8d0e-9141a2ec9fb6');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('8ece6247-36a2-413b-9fbc-8d11600d7d7f', '395d63ae-7a84-42f1-a97d-0850118490c8');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('8ece6247-36a2-413b-9fbc-8d11600d7d7f', '8b6763dd-90e3-44d1-9093-5f4155571da5');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('7c1b19f4-d399-4244-ad62-9debf1eaf698', 'eeb2ab61-15c0-49c7-987f-da46254d5e89');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('7c1b19f4-d399-4244-ad62-9debf1eaf698', '9c90b7e9-67c2-417b-bbc5-3645f7300b38');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('7c1b19f4-d399-4244-ad62-9debf1eaf698', 'dd0e0b68-ec05-4ae6-aee3-414419e33ea7');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('7c1b19f4-d399-4244-ad62-9debf1eaf698', '4e600bc4-774d-4742-9661-b721c6b33e6d');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('7c1b19f4-d399-4244-ad62-9debf1eaf698', '252566fd-10dd-41b9-b62c-29acc53b24b9');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('7c1b19f4-d399-4244-ad62-9debf1eaf698', '47e7ea31-f044-4161-8d0e-9141a2ec9fb6');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('7c1b19f4-d399-4244-ad62-9debf1eaf698', '395d63ae-7a84-42f1-a97d-0850118490c8');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('7c1b19f4-d399-4244-ad62-9debf1eaf698', '8b6763dd-90e3-44d1-9093-5f4155571da5');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('d48bdc42-5bb2-4b45-91fc-170a7c1cf9e8', '9c90b7e9-67c2-417b-bbc5-3645f7300b38');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('d48bdc42-5bb2-4b45-91fc-170a7c1cf9e8', '47e7ea31-f044-4161-8d0e-9141a2ec9fb6');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('f1a58dab-0bc1-4364-be80-b5a21e7b7005', 'dd0e0b68-ec05-4ae6-aee3-414419e33ea7');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('f1a58dab-0bc1-4364-be80-b5a21e7b7005', '47e7ea31-f044-4161-8d0e-9141a2ec9fb6');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('225a079c-5767-420a-87df-66fffe372e61', 'eeb2ab61-15c0-49c7-987f-da46254d5e89');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('225a079c-5767-420a-87df-66fffe372e61', '9c90b7e9-67c2-417b-bbc5-3645f7300b38');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('225a079c-5767-420a-87df-66fffe372e61', 'dd0e0b68-ec05-4ae6-aee3-414419e33ea7');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('225a079c-5767-420a-87df-66fffe372e61', '252566fd-10dd-41b9-b62c-29acc53b24b9');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('225a079c-5767-420a-87df-66fffe372e61', '395d63ae-7a84-42f1-a97d-0850118490c8');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('225a079c-5767-420a-87df-66fffe372e61', '8b6763dd-90e3-44d1-9093-5f4155571da5');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('63733dee-e4b7-4770-a1bc-1d3d0e5e199f', '252566fd-10dd-41b9-b62c-29acc53b24b9');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('63733dee-e4b7-4770-a1bc-1d3d0e5e199f', '395d63ae-7a84-42f1-a97d-0850118490c8');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('63733dee-e4b7-4770-a1bc-1d3d0e5e199f', '47e7ea31-f044-4161-8d0e-9141a2ec9fb6');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('63733dee-e4b7-4770-a1bc-1d3d0e5e199f', '4e600bc4-774d-4742-9661-b721c6b33e6d');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('63733dee-e4b7-4770-a1bc-1d3d0e5e199f', '8b6763dd-90e3-44d1-9093-5f4155571da5');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('63733dee-e4b7-4770-a1bc-1d3d0e5e199f', '9c90b7e9-67c2-417b-bbc5-3645f7300b38');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('63733dee-e4b7-4770-a1bc-1d3d0e5e199f', 'dd0e0b68-ec05-4ae6-aee3-414419e33ea7');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('63733dee-e4b7-4770-a1bc-1d3d0e5e199f', 'eeb2ab61-15c0-49c7-987f-da46254d5e89');
commit;
prompt 34 records loaded
prompt Loading TICKET_ORDER...
insert into TICKET_ORDER (id, create_date, delete_date, is_delete, update_date, version, delete_by_customer, flight_day, order_date, order_num, order_status, order_time, order_type, pay_fee, airline_id, customer_id, left_ticket_class_id, main_order_id, payment_id, left_ticket_id)
values ('5801fcf6-1a4b-4a55-86e1-8175b1ae3ac2', to_date('11-05-2017 17:56:44', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('11-05-2017 21:43:45', 'dd-mm-yyyy hh24:mi:ss'), 3, 'Y', '2017-05-13', to_date('11-05-2017 17:56:44', 'dd-mm-yyyy hh24:mi:ss'), '1494496604809001', 2, to_date('11-05-2017 17:56:44', 'dd-mm-yyyy hh24:mi:ss'), 1, 14284, '7f76fa13-8923-4d46-a50a-bc247f56cfe1', 'b7d6d462-5cc3-4dce-bd70-334cd1b59a06', '51745fc6-a1fb-4db5-993a-de79a96bdbfd', null, '190c0345-7086-4bb8-9702-88d58965c136', null);
insert into TICKET_ORDER (id, create_date, delete_date, is_delete, update_date, version, delete_by_customer, flight_day, order_date, order_num, order_status, order_time, order_type, pay_fee, airline_id, customer_id, left_ticket_class_id, main_order_id, payment_id, left_ticket_id)
values ('406f42e4-44b6-43ae-9645-dc15edfd10a5', to_date('11-05-2017 20:36:25', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('11-05-2017 21:45:40', 'dd-mm-yyyy hh24:mi:ss'), 3, 'Y', '2017-05-13', to_date('11-05-2017 20:36:25', 'dd-mm-yyyy hh24:mi:ss'), '1494506185499001', 3, to_date('11-05-2017 20:36:25', 'dd-mm-yyyy hh24:mi:ss'), 1, 7142, '1d10cf37-60ad-40ec-bd76-9dc34a875861', 'b7d6d462-5cc3-4dce-bd70-334cd1b59a06', '00d115c1-eec7-47bf-8696-ccc4e681742d', null, null, null);
insert into TICKET_ORDER (id, create_date, delete_date, is_delete, update_date, version, delete_by_customer, flight_day, order_date, order_num, order_status, order_time, order_type, pay_fee, airline_id, customer_id, left_ticket_class_id, main_order_id, payment_id, left_ticket_id)
values ('dd826793-1e91-4a3c-ad6a-591a84ff03df', to_date('11-05-2017 21:39:31', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('11-05-2017 21:47:12', 'dd-mm-yyyy hh24:mi:ss'), 4, 'Y', '2017-05-13', to_date('11-05-2017 21:39:31', 'dd-mm-yyyy hh24:mi:ss'), '1494509971279001', 3, to_date('11-05-2017 21:39:31', 'dd-mm-yyyy hh24:mi:ss'), 1, 14284, '7f76fa13-8923-4d46-a50a-bc247f56cfe1', 'b7d6d462-5cc3-4dce-bd70-334cd1b59a06', '51745fc6-a1fb-4db5-993a-de79a96bdbfd', null, null, 'b0d02100-64eb-436e-9862-94632b374be9');
insert into TICKET_ORDER (id, create_date, delete_date, is_delete, update_date, version, delete_by_customer, flight_day, order_date, order_num, order_status, order_time, order_type, pay_fee, airline_id, customer_id, left_ticket_class_id, main_order_id, payment_id, left_ticket_id)
values ('f17ef6ed-8724-4d4a-be62-d62d98518e5b', to_date('11-05-2017 21:44:19', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('11-05-2017 23:10:18', 'dd-mm-yyyy hh24:mi:ss'), 4, 'Y', '2017-05-13', to_date('11-05-2017 21:44:19', 'dd-mm-yyyy hh24:mi:ss'), '1494510259067001', 2, to_date('11-05-2017 21:44:19', 'dd-mm-yyyy hh24:mi:ss'), 1, 14284, '7f76fa13-8923-4d46-a50a-bc247f56cfe1', 'b7d6d462-5cc3-4dce-bd70-334cd1b59a06', '51745fc6-a1fb-4db5-993a-de79a96bdbfd', null, '8b9088c8-5c08-4607-9a2b-8d609edaf21c', 'b0d02100-64eb-436e-9862-94632b374be9');
insert into TICKET_ORDER (id, create_date, delete_date, is_delete, update_date, version, delete_by_customer, flight_day, order_date, order_num, order_status, order_time, order_type, pay_fee, airline_id, customer_id, left_ticket_class_id, main_order_id, payment_id, left_ticket_id)
values ('8cd606ef-a343-4c9f-a4f9-66ac5fa325a0', to_date('12-05-2017 14:45:17', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('12-05-2017 17:14:55', 'dd-mm-yyyy hh24:mi:ss'), 4274, 'N', '2017-05-13', to_date('09-08-2017 14:15:17', 'dd-mm-yyyy hh24:mi:ss'), '1494571517819001', 4, to_date('12-05-2017 14:45:17', 'dd-mm-yyyy hh24:mi:ss'), 1, 7142, '7f76fa13-8923-4d46-a50a-bc247f56cfe1', 'b7d6d462-5cc3-4dce-bd70-334cd1b59a06', '51745fc6-a1fb-4db5-993a-de79a96bdbfd', null, null, 'b0d02100-64eb-436e-9862-94632b374be9');
insert into TICKET_ORDER (id, create_date, delete_date, is_delete, update_date, version, delete_by_customer, flight_day, order_date, order_num, order_status, order_time, order_type, pay_fee, airline_id, customer_id, left_ticket_class_id, main_order_id, payment_id, left_ticket_id)
values ('02a0e97c-b44b-4519-ae72-0aa2f0f4c86c', to_date('11-05-2017 23:19:10', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('11-05-2017 23:19:24', 'dd-mm-yyyy hh24:mi:ss'), 3, 'N', '2017-05-13', to_date('11-05-2017 23:19:10', 'dd-mm-yyyy hh24:mi:ss'), '1494515950130001', 2, to_date('11-05-2017 23:19:10', 'dd-mm-yyyy hh24:mi:ss'), 1, 3571, '7f76fa13-8923-4d46-a50a-bc247f56cfe1', 'b7d6d462-5cc3-4dce-bd70-334cd1b59a06', '51745fc6-a1fb-4db5-993a-de79a96bdbfd', null, '1ee334cd-9c31-4742-b396-5db94e5572cb', 'b0d02100-64eb-436e-9862-94632b374be9');
insert into TICKET_ORDER (id, create_date, delete_date, is_delete, update_date, version, delete_by_customer, flight_day, order_date, order_num, order_status, order_time, order_type, pay_fee, airline_id, customer_id, left_ticket_class_id, main_order_id, payment_id, left_ticket_id)
values ('07fc50ea-e718-4957-a9e5-fe5c48cde52e', to_date('11-05-2017 23:27:52', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('11-05-2017 23:30:53', 'dd-mm-yyyy hh24:mi:ss'), 3, 'N', '2017-05-12', to_date('11-05-2017 23:27:52', 'dd-mm-yyyy hh24:mi:ss'), '1494516472899001', 3, to_date('11-05-2017 23:27:52', 'dd-mm-yyyy hh24:mi:ss'), 1, 50001, '732a0b9b-7c8b-4196-9539-37045d437584', 'b7d6d462-5cc3-4dce-bd70-334cd1b59a06', '7826cff9-ae11-4d56-8ad1-3adca5b88522', null, null, '2a837ff5-a984-42d2-8a9a-e6f4245f7418');
insert into TICKET_ORDER (id, create_date, delete_date, is_delete, update_date, version, delete_by_customer, flight_day, order_date, order_num, order_status, order_time, order_type, pay_fee, airline_id, customer_id, left_ticket_class_id, main_order_id, payment_id, left_ticket_id)
values ('547a1b24-f486-4a80-b5aa-dbea9a89de6b', to_date('11-05-2017 23:30:12', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('12-05-2017 14:36:18', 'dd-mm-yyyy hh24:mi:ss'), 3, 'N', '2017-05-12', to_date('12-05-2017 00:00:12', 'dd-mm-yyyy hh24:mi:ss'), '1494516612889001', 4, to_date('11-05-2017 23:30:12', 'dd-mm-yyyy hh24:mi:ss'), 1, 21429, '732a0b9b-7c8b-4196-9539-37045d437584', 'b7d6d462-5cc3-4dce-bd70-334cd1b59a06', '7826cff9-ae11-4d56-8ad1-3adca5b88522', null, null, '2a837ff5-a984-42d2-8a9a-e6f4245f7418');
insert into TICKET_ORDER (id, create_date, delete_date, is_delete, update_date, version, delete_by_customer, flight_day, order_date, order_num, order_status, order_time, order_type, pay_fee, airline_id, customer_id, left_ticket_class_id, main_order_id, payment_id, left_ticket_id)
values ('8d801dd2-fd18-407c-bb6d-25973649c0c5', to_date('12-05-2017 17:15:21', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('12-05-2017 17:17:03', 'dd-mm-yyyy hh24:mi:ss'), 3, 'N', '2017-05-13', to_date('12-05-2017 17:15:21', 'dd-mm-yyyy hh24:mi:ss'), '1494580521037001', 2, to_date('12-05-2017 17:15:21', 'dd-mm-yyyy hh24:mi:ss'), 1, 7142, '7f76fa13-8923-4d46-a50a-bc247f56cfe1', 'b7d6d462-5cc3-4dce-bd70-334cd1b59a06', '51745fc6-a1fb-4db5-993a-de79a96bdbfd', null, 'cdbc62f8-ecd7-4572-bf50-4d133b8a6c3d', 'b0d02100-64eb-436e-9862-94632b374be9');
insert into TICKET_ORDER (id, create_date, delete_date, is_delete, update_date, version, delete_by_customer, flight_day, order_date, order_num, order_status, order_time, order_type, pay_fee, airline_id, customer_id, left_ticket_class_id, main_order_id, payment_id, left_ticket_id)
values ('7b7a1dde-78a7-4044-b405-33505cd59014', to_date('12-05-2017 17:20:45', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', to_date('12-05-2017 17:21:07', 'dd-mm-yyyy hh24:mi:ss'), 3, 'N', '2017-05-14', to_date('12-05-2017 17:20:45', 'dd-mm-yyyy hh24:mi:ss'), '1494580845959001', 2, to_date('12-05-2017 17:20:45', 'dd-mm-yyyy hh24:mi:ss'), 1, 7142, '7f76fa13-8923-4d46-a50a-bc247f56cfe1', 'b7d6d462-5cc3-4dce-bd70-334cd1b59a06', '47f54c9b-7fd4-4e77-8e7c-58370f5fad0d', null, 'b34cf75f-6e0c-4677-a30e-7c9f36072ae5', '19d6c27f-c6fb-4f2a-a399-76658df8028c');
commit;
prompt 10 records loaded
prompt Loading SUB_ORDER...
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('47f3704e-9107-401a-9905-9c6375560698', 3571, 2, null, '178faa46-8f4f-4b7b-a934-1b23339b7c46', null);
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('14a772e8-c7e8-4c7b-b4b6-cf967b2c48c6', 3571, 2, null, '05da5165-fc73-4778-b899-99e53ae7a7a5', null);
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('990972c9-f67e-4fb1-9492-e12fb4490a51', 3571, 2, null, '12c1f0eb-f205-4e2c-8d1b-c9f0417b978f', null);
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('ef83e380-1833-41a0-a2bc-232bc23580a6', 3571, 2, null, '5ea4f30f-5000-44e5-a1eb-5a6fae7413df', null);
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('1a8e1084-4ac1-45fa-be07-6dc4063f6ef2', 3651, 3, null, '05da5165-fc73-4778-b899-99e53ae7a7a5', null);
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('8eb46068-91cb-4a58-92b2-54d87bf4fd00', 3651, 3, null, '5ea4f30f-5000-44e5-a1eb-5a6fae7413df', null);
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('ee502a10-e5a1-4a42-9322-7fdc1ecd6ebf', 3651, 3, null, '178faa46-8f4f-4b7b-a934-1b23339b7c46', null);
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('b70bdbe8-90e6-4f61-aeae-eca430d591e6', 3651, 3, null, '05da5165-fc73-4778-b899-99e53ae7a7a5', null);
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('ad6a87c7-2570-42ba-b5c3-a1055a342082', 3651, 3, null, '12c1f0eb-f205-4e2c-8d1b-c9f0417b978f', null);
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('e0395e72-1f60-446d-b2cb-b6f318f9ea33', 3651, 3, null, '5ea4f30f-5000-44e5-a1eb-5a6fae7413df', null);
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('b2e69fd4-6b85-469c-adc1-dd8d13c1f9a5', 3651, 2, null, '178faa46-8f4f-4b7b-a934-1b23339b7c46', null);
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('7fc0f84c-cb56-4443-8e70-26c7c02a0877', 3651, 2, null, '05da5165-fc73-4778-b899-99e53ae7a7a5', null);
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('e1f18c36-0e19-4563-9e6c-d1863b6cc682', 3651, 2, null, '12c1f0eb-f205-4e2c-8d1b-c9f0417b978f', null);
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('e3a52288-276f-43a8-8026-105cea2a5444', 3651, 2, null, '5ea4f30f-5000-44e5-a1eb-5a6fae7413df', null);
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('f4ea607b-87c6-4969-bed4-f0a01f31862a', 3651, 4, null, '178faa46-8f4f-4b7b-a934-1b23339b7c46', null);
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('6d10551f-ba20-4a55-9f3a-91d66a54fd5b', 3651, 4, null, '5ea4f30f-5000-44e5-a1eb-5a6fae7413df', null);
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('a970db43-29e7-4a34-b35f-b613b6f0e369', 3651, 2, null, 'c7d76727-4a28-443e-bf85-ffb0efcffb2b', null);
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('facf9ff7-852c-4c27-95d7-ea2cfdafec84', 7218, 3, null, '178faa46-8f4f-4b7b-a934-1b23339b7c46', null);
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('9b2dea2f-0736-4617-a70f-aae641309da5', 7218, 3, null, '05da5165-fc73-4778-b899-99e53ae7a7a5', null);
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('68d5d55e-7b34-48f4-a4b5-56bfa7e42aff', 7218, 3, null, '12c1f0eb-f205-4e2c-8d1b-c9f0417b978f', null);
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('e82329e6-a9d7-4028-9aa6-1d89080d34f4', 7218, 3, null, '5ea4f30f-5000-44e5-a1eb-5a6fae7413df', null);
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('aaa7adf4-9fa1-47b6-a732-bcbbab912ef4', 7218, 3, null, 'c7d76727-4a28-443e-bf85-ffb0efcffb2b', null);
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('a800948e-50fd-4e74-916f-c83db5d98aea', 7218, 3, null, '5da0dce9-fedb-4dd1-af91-a9d71f26e8b6', null);
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('e5f72f9d-7fdc-40a2-b281-87451b63ef54', 7218, 3, null, '849a61a2-6c1b-470b-a813-463ae1125f0d', null);
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('67d12bcc-7d42-471c-9195-901c4bf5ffbe', 7218, 4, null, '05da5165-fc73-4778-b899-99e53ae7a7a5', null);
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('3941d454-568f-4e64-89ad-24db5d55788f', 7218, 4, null, '12c1f0eb-f205-4e2c-8d1b-c9f0417b978f', null);
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('c112ab90-60e0-4afe-8bb8-f6ef72f2ff58', 7218, 4, null, '5ea4f30f-5000-44e5-a1eb-5a6fae7413df', null);
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('67fa6314-0fb3-4fd0-b6f3-fd6087e6b662', 3651, 2, null, '05da5165-fc73-4778-b899-99e53ae7a7a5', null);
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('951d3c45-b83f-481c-a4ff-3ef20c66ee03', 3651, 2, null, '5ea4f30f-5000-44e5-a1eb-5a6fae7413df', null);
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('429a9e5b-f5ea-41eb-801c-f91a83f88618', 3651, 2, null, '178faa46-8f4f-4b7b-a934-1b23339b7c46', null);
insert into SUB_ORDER (id, pay_fee, status, alter_ticket_order_id, common_passager_id, refund_payment_id)
values ('75e5eaf1-a6ca-477c-8f4c-1535e9ac02d2', 3651, 2, null, '5ea4f30f-5000-44e5-a1eb-5a6fae7413df', null);
commit;
prompt 31 records loaded
prompt Loading TICKET_ORDER_SUB_ORDER_LIST...
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('5801fcf6-1a4b-4a55-86e1-8175b1ae3ac2', '47f3704e-9107-401a-9905-9c6375560698');
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('5801fcf6-1a4b-4a55-86e1-8175b1ae3ac2', '14a772e8-c7e8-4c7b-b4b6-cf967b2c48c6');
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('5801fcf6-1a4b-4a55-86e1-8175b1ae3ac2', '990972c9-f67e-4fb1-9492-e12fb4490a51');
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('5801fcf6-1a4b-4a55-86e1-8175b1ae3ac2', 'ef83e380-1833-41a0-a2bc-232bc23580a6');
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('406f42e4-44b6-43ae-9645-dc15edfd10a5', '1a8e1084-4ac1-45fa-be07-6dc4063f6ef2');
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('406f42e4-44b6-43ae-9645-dc15edfd10a5', '8eb46068-91cb-4a58-92b2-54d87bf4fd00');
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('dd826793-1e91-4a3c-ad6a-591a84ff03df', 'ee502a10-e5a1-4a42-9322-7fdc1ecd6ebf');
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('dd826793-1e91-4a3c-ad6a-591a84ff03df', 'b70bdbe8-90e6-4f61-aeae-eca430d591e6');
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('dd826793-1e91-4a3c-ad6a-591a84ff03df', 'ad6a87c7-2570-42ba-b5c3-a1055a342082');
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('dd826793-1e91-4a3c-ad6a-591a84ff03df', 'e0395e72-1f60-446d-b2cb-b6f318f9ea33');
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('f17ef6ed-8724-4d4a-be62-d62d98518e5b', 'b2e69fd4-6b85-469c-adc1-dd8d13c1f9a5');
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('f17ef6ed-8724-4d4a-be62-d62d98518e5b', '7fc0f84c-cb56-4443-8e70-26c7c02a0877');
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('f17ef6ed-8724-4d4a-be62-d62d98518e5b', 'e1f18c36-0e19-4563-9e6c-d1863b6cc682');
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('f17ef6ed-8724-4d4a-be62-d62d98518e5b', 'e3a52288-276f-43a8-8026-105cea2a5444');
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('8cd606ef-a343-4c9f-a4f9-66ac5fa325a0', 'f4ea607b-87c6-4969-bed4-f0a01f31862a');
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('8cd606ef-a343-4c9f-a4f9-66ac5fa325a0', '6d10551f-ba20-4a55-9f3a-91d66a54fd5b');
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('02a0e97c-b44b-4519-ae72-0aa2f0f4c86c', 'a970db43-29e7-4a34-b35f-b613b6f0e369');
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('07fc50ea-e718-4957-a9e5-fe5c48cde52e', 'facf9ff7-852c-4c27-95d7-ea2cfdafec84');
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('07fc50ea-e718-4957-a9e5-fe5c48cde52e', '9b2dea2f-0736-4617-a70f-aae641309da5');
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('07fc50ea-e718-4957-a9e5-fe5c48cde52e', '68d5d55e-7b34-48f4-a4b5-56bfa7e42aff');
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('07fc50ea-e718-4957-a9e5-fe5c48cde52e', 'e82329e6-a9d7-4028-9aa6-1d89080d34f4');
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('07fc50ea-e718-4957-a9e5-fe5c48cde52e', 'aaa7adf4-9fa1-47b6-a732-bcbbab912ef4');
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('07fc50ea-e718-4957-a9e5-fe5c48cde52e', 'a800948e-50fd-4e74-916f-c83db5d98aea');
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('07fc50ea-e718-4957-a9e5-fe5c48cde52e', 'e5f72f9d-7fdc-40a2-b281-87451b63ef54');
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('547a1b24-f486-4a80-b5aa-dbea9a89de6b', '67d12bcc-7d42-471c-9195-901c4bf5ffbe');
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('547a1b24-f486-4a80-b5aa-dbea9a89de6b', '3941d454-568f-4e64-89ad-24db5d55788f');
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('547a1b24-f486-4a80-b5aa-dbea9a89de6b', 'c112ab90-60e0-4afe-8bb8-f6ef72f2ff58');
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('8d801dd2-fd18-407c-bb6d-25973649c0c5', '67fa6314-0fb3-4fd0-b6f3-fd6087e6b662');
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('8d801dd2-fd18-407c-bb6d-25973649c0c5', '951d3c45-b83f-481c-a4ff-3ef20c66ee03');
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('7b7a1dde-78a7-4044-b405-33505cd59014', '429a9e5b-f5ea-41eb-801c-f91a83f88618');
insert into TICKET_ORDER_SUB_ORDER_LIST (ticket_order_id, sub_order_list_id)
values ('7b7a1dde-78a7-4044-b405-33505cd59014', '75e5eaf1-a6ca-477c-8f4c-1535e9ac02d2');
commit;
prompt 31 records loaded
prompt Enabling foreign key constraints for AIRLINE...
alter table AIRLINE enable constraint FK7U9Y7LVV5IMBWPJDJPN52W9QX;
alter table AIRLINE enable constraint FKP8EM34PS4FC8TQMHU2A927C1S;
alter table AIRLINE enable constraint FKSJ5UMBORTVW6PIRFL6KEGLHUM;
prompt Enabling foreign key constraints for AIRLINE_CLASS...
alter table AIRLINE_CLASS enable constraint FKP03QWM8PPK8LNXXGSO355148;
prompt Enabling foreign key constraints for AIRLINE_LINKS_AIRLINE_CLASS...
alter table AIRLINE_LINKS_AIRLINE_CLASS enable constraint FK4FSWASS89JGVJWW4MK183V9FY;
alter table AIRLINE_LINKS_AIRLINE_CLASS enable constraint FKNTOT2DPJP03B6VQQNFC215342;
prompt Enabling foreign key constraints for COMMON_PASSAGER...
alter table COMMON_PASSAGER enable constraint FK18MA7XVOLGW87UCP50AJAD0MF;
prompt Enabling foreign key constraints for LEFT_TICKET...
alter table LEFT_TICKET enable constraint FK9AJCJQPLHQIAFHDU3JMCXAOWH;
prompt Enabling foreign key constraints for LEFT_TICKET_CLASS...
alter table LEFT_TICKET_CLASS enable constraint FKCIXWWRFA5FJ2K4NAHS0CROM0D;
prompt Enabling foreign key constraints for LEFTTICKET_LINKS_CLASS...
alter table LEFTTICKET_LINKS_CLASS enable constraint FKC9LGFEC99A1DMD8T245CXUKVP;
alter table LEFTTICKET_LINKS_CLASS enable constraint FKHT5DCSK46X0OVBY6JXD0B6K5Q;
prompt Enabling foreign key constraints for PAYMENT...
alter table PAYMENT enable constraint FKBY2SKJF3OV608YB6NM16B49LG;
prompt Enabling foreign key constraints for PLANE_LINKS_PLANE_CLASS...
alter table PLANE_LINKS_PLANE_CLASS enable constraint FK2PV2J1F9FKIM30XY5MW5UUKWN;
alter table PLANE_LINKS_PLANE_CLASS enable constraint FKR411YCA7QBX5X551YHWABAJPC;
prompt Enabling foreign key constraints for STAFF_LINKS_STAFF_PERMS...
alter table STAFF_LINKS_STAFF_PERMS enable constraint FK39PAVQVSL5S6S0LAHPPR5EMIU;
alter table STAFF_LINKS_STAFF_PERMS enable constraint FKBVAWFLF68I2RIMUU6B68OJ14Y;
prompt Enabling foreign key constraints for TICKET_ORDER...
alter table TICKET_ORDER enable constraint FK2139BYR77Q72TTBYRIIOBQSWH;
alter table TICKET_ORDER enable constraint FK66ASOB1PEKPA97B7B0CLGPDMI;
alter table TICKET_ORDER enable constraint FK9YXK99ALV34YOUV5CQAJ27LVU;
alter table TICKET_ORDER enable constraint FKMXN58OGEAUU27HBAL96OTVWCD;
alter table TICKET_ORDER enable constraint FKOS908KM3VXJWT4BS6NIF68PSB;
alter table TICKET_ORDER enable constraint FKR216WU66LBNMHE6YWUB1SEMF3;
prompt Enabling foreign key constraints for SUB_ORDER...
alter table SUB_ORDER enable constraint FKI2DS8DGV4QJWAV6VJQNMPSQT;
alter table SUB_ORDER enable constraint FKPKGKPU4OECH7N89R5YCWUOVW0;
alter table SUB_ORDER enable constraint FKSA68Y3LBE8X3P7AU9UHSG6EX7;
prompt Enabling foreign key constraints for TICKET_ORDER_SUB_ORDER_LIST...
alter table TICKET_ORDER_SUB_ORDER_LIST enable constraint FK3C9MC3MVD1FXGBH0S3XML569K;
alter table TICKET_ORDER_SUB_ORDER_LIST enable constraint FK8SQMHB6LMWX06W8C40Y7R5UGR;
prompt Enabling triggers for AIRPORT...
alter table AIRPORT enable all triggers;
prompt Enabling triggers for PLANE...
alter table PLANE enable all triggers;
prompt Enabling triggers for AIRLINE...
alter table AIRLINE enable all triggers;
prompt Enabling triggers for PLANE_CLASS...
alter table PLANE_CLASS enable all triggers;
prompt Enabling triggers for AIRLINE_CLASS...
alter table AIRLINE_CLASS enable all triggers;
prompt Enabling triggers for AIRLINE_LINKS_AIRLINE_CLASS...
alter table AIRLINE_LINKS_AIRLINE_CLASS enable all triggers;
prompt Enabling triggers for CUSTOMER...
alter table CUSTOMER enable all triggers;
prompt Enabling triggers for COMMON_PASSAGER...
alter table COMMON_PASSAGER enable all triggers;
prompt Enabling triggers for LEFT_TICKET...
alter table LEFT_TICKET enable all triggers;
prompt Enabling triggers for LEFT_TICKET_CLASS...
alter table LEFT_TICKET_CLASS enable all triggers;
prompt Enabling triggers for LEFTTICKET_LINKS_CLASS...
alter table LEFTTICKET_LINKS_CLASS enable all triggers;
prompt Enabling triggers for PAYMENT...
alter table PAYMENT enable all triggers;
prompt Enabling triggers for PLANE_LINKS_PLANE_CLASS...
alter table PLANE_LINKS_PLANE_CLASS enable all triggers;
prompt Enabling triggers for STAFF...
alter table STAFF enable all triggers;
prompt Enabling triggers for STAFF_PERMS...
alter table STAFF_PERMS enable all triggers;
prompt Enabling triggers for STAFF_LINKS_STAFF_PERMS...
alter table STAFF_LINKS_STAFF_PERMS enable all triggers;
prompt Enabling triggers for TICKET_ORDER...
alter table TICKET_ORDER enable all triggers;
prompt Enabling triggers for SUB_ORDER...
alter table SUB_ORDER enable all triggers;
prompt Enabling triggers for TICKET_ORDER_SUB_ORDER_LIST...
alter table TICKET_ORDER_SUB_ORDER_LIST enable all triggers;
set feedback on
set define on
prompt Done.
