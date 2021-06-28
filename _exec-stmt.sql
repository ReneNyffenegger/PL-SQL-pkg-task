begin
   task_mgmt.begin_(q'{&1}');
   &1;
   task_mgmt.done;
exception when others then
   dbms_output.put_line(q'{ERROR executing &1}');
   dbms_output.put_line('  ' || sqlerrm);
   task_mgmt.exc;
end;
/