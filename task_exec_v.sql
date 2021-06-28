create or replace view task_exec_v as
select
   tsk.name          ,
   tim.s_ago(tsk_exec.start_) as start_s_ago,
   tim.s_ago(tsk_exec.end_  ) as end_s_ago,
   tsk_exec.err         ,
   ses.usr         ,
   ses.usr_proxy   ,
   ses.usr_os      ,
   case when tsk_exec.id  = task_mgmt.cur_task then 'y' else 'n'                  end cur_task,
   case when ses.cur_ses = 'y' then row_number() over (order by tsk_exec.id desc) end cur_ses_r,
   ses.cur_ses     ,
   ses.sid         ,
   ses.serial#     ,
   tsk_exec.start_ ,
   tsk.id        task_id,
   tsk_exec.id   id,
   ses.id    ses_id
from
   task       tsk                                      join
   task_exec  tsk_exec  on tsk.id = tsk_exec.task_id   join
   ses_v      ses       on ses.id = tsk_exec.ses_id;
