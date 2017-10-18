
create table biologging.event (
    event_id           integer,
    deployment_id      integer,
    multi_tag_serial   integer,
    ptt                integer,
    tag_manufacturer   text,
    tag_model          text,
    tag_serial_number  text,
    portal_username    text
);

create table biologging.atn_track (
    tkey          integer,
    eventid       integer,
    toppid        integer,
    ptt           integer,
    priority      integer,
    ssm_tr        integer,
    vis_prob      integer,
    rerun         integer,
    atn_replaced  integer,
    comments      text,
    contact       text,
    embargountil  date,
    vis_filter    integer,
    embargolon    real,
    embargolat    real,
    plot_points   integer,
    plot_dashes   integer
);

