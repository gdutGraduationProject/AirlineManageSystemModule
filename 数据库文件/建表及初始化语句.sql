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
values ('395d63ae-7a84-42f1-a97d-0850118490c8', to_date('28-02-2017 17:09:39', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '/airport/', '机场管理');
insert into STAFF_PERMS (id, create_date, delete_date, is_delete, update_date, version, jump_url, menu_text)
values ('8b6763dd-90e3-44d1-9093-5f4155571da5', to_date('28-02-2017 17:10:12', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '/information/', '个人信息管理');
insert into STAFF (id, create_date, delete_date, is_delete, update_date, version, checked_email, is_disable, password, posts, real_name, salt, username)
values ('8ece6247-36a2-413b-9fbc-8d11600d7d7f', to_date('24-03-2017 14:41:26', 'dd-mm-yyyy hh24:mi:ss'), null, 'N', null, 1, '13800@qq.com', 'N', '8e193a24eff7c54f337cf167f8bcca20', '超级管理员', '超级管理员', '6ef627f9-e2ba-4639-9508-4ef709dcd999', 'superadmin');

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
values ('8ece6247-36a2-413b-9fbc-8d11600d7d7f', '395d63ae-7a84-42f1-a97d-0850118490c8');
insert into STAFF_LINKS_STAFF_PERMS (staff_id, staff_perms_id)
values ('8ece6247-36a2-413b-9fbc-8d11600d7d7f', '8b6763dd-90e3-44d1-9093-5f4155571da5');