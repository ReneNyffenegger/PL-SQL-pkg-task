create table task_exec (
   start_   date            default sysdate not null,
   end_     date                                null,
   err      varchar2(250)                       null,
   task_id  integer         not null,
   ses_id   integer         not null,
   id       integer         generated always as identity,
   --
   constraint task_exec_pk primary key (id  ),
   constraint task_exec_fk_task foreign key (task_id) references task,
   constraint task_exec_fk_ses  foreign key (ses_id ) references ses
);
