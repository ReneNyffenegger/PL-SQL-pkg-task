create table task (
   name     varchar2(100)                    not null,
   id       integer         generated always as identity,
   --
   constraint task_pk primary key (id),
   constraint task_uq unique(name)
)
organization index;
