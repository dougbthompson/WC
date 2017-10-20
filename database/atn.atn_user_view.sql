
drop view if exists atn_user_view;
create of replace view atn_user_view
as
  select u.*, ur.*
    from biologging.atn_user u,
         biologging.user_role ur,
         biologging.project p,
         biologging.atn_project_user_role pur
   where pur.user_id       = u.id
     and pur.project_id    = p.id
     and pur_user_role_id  = ur.id
;

