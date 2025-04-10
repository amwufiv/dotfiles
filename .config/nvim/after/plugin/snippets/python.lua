local ls = require('luasnip')
local s = ls.snippet

local t, i, c, f = ls.text_node, ls.insert_node, ls.choice_node, ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

local filename = function()
  return f(function(_args, snip)
    local name = snip.snippet.env.TM_FILENAME_BASE
    return name
  end)
end

local period_enum = function ()
  return f(function(_args, snip)
    local filename = snip.snippet.env.TM_FILENAME_BASE
    local st =  vim.split(filename, '_')
    local c = string.upper(st[#st]:sub(1, 1))
    local available = {H = "H", D = "D", W = "W", M = "M"}
    return available[c] or "D"
  end)
end

local db_str = function ()
  return f(function(_args, snip)
    local db = "pcg_qq_dw"
    local filename = snip.snippet.env.TM_FILENAME_BASE
    local st = vim.split(filename, '_')
    local layer = string.lower(st[1])
    if layer == "ads" then
      db = "pcg_qq_ads"
    elseif layer == "ods" then
      db = "pcg_qq_ods"
    else
      db = "pcg_qq_dw"
    end
    return db
    end)
end

local date_str = function ()
  return f(function(_args, snip)
    local filename = snip.snippet.env.TM_FILENAME_BASE
    local st =  vim.split(filename, '_')
    local c = string.upper(st[#st]:sub(1, 1))
    local d
    if c == "D" then
      d = "imp_date"
    elseif c == "H" then
      d = "imp_hour"
    elseif c =="W" then
      d = "imp_week"
    elseif c == "M" then
      d = "imp_month"
    else
      d = "imp_date"
    end
    return d
  end)
end


local today = function ()
  return os.date('%Y%m%d')
end

return {
  s("header",{
    t({
      "#!/usr/bin/env python",
      "# -*- coding: utf-8 -*-",
      "#  ------------------------------------------------------------------------------------------------",
      "#  Product: QQ",
      "#  Author: ufivhuang",
      "#  Taskname: insert-"
    }),
    filename(),
    t({
      "",
      "#  Describe: ",
      string.format("#  Notes0: created by ufivhuang on %s", today()),
      "#  TdwAppgroup: g_pcg_pcgpt432d52f1_littleworlddw",
      "#  CycleUnit: ",
    }),
    period_enum(),
    t({
      "",
      "#  AutotuneType: 1",
      "# -------------------------------------------------------------------------------------------------",
      ""
    })
  }),
  s("init", 
    fmt([[


DST_TABLE = "{filename}"
DST_DB = "{db_str}"


def init_env(tdw):
    execute_sql(tdw, "use {{dst_db}}".format(dst_db=DST_DB))


def execute_sql(tdw, sql):
    tdw.WriteLog("executing SQL:\n %s" % sql)
    tdw.execute(sql)


def create_table(tdw):
    create_sql = """
        CREATE TABLE IF NOT EXISTS {{dst_table}} (
            {date_str} BIGINT COMMENT '日期'
        )
        COMMENT ''
        PARTITION BY LIST({date_str}) (
            PARTITION DEFAULT
        ) STORED AS ORCFILE COMPRESS
    """.format(dst_table=DST_TABLE)
    execute_sql(tdw, create_sql)


def insert_data(tdw, {date_str}):
    insert_sql = """
        INSERT OVERWRITE TABLE {{dst_table}} PARTITION({date_str}={{{date_str}}})

    """.format(dst_table=DST_TABLE, {date_str}={date_str})
    execute_sql(tdw, insert_sql)


def truncate_partition(tdw, imp_date):
    execute_sql(tdw, "ALTER TABLE {{dst_table}} DROP PARTITION (p_{{imp_date}})".format(dst_table=DST_TABLE, imp_date=imp_date))
    execute_sql(tdw, "ALTER TABLE {{dst_table}} ADD PARTITION p_{{imp_date}} values in ({{imp_date}})".format(dst_table=DST_TABLE, imp_date=imp_date))


def TDW_PL(tdw, argv):
    tdw.WriteLog("%s begin!" % DST_TABLE)

    # get args
    {date_str} = argv[0]

    # 0、set db
    init_env(tdw)

    # 1、create table
    create_table(tdw)

    # 2、insert data
    insert_data(tdw,{date_str})

    tdw.WriteLog("%s end!" % DST_TABLE)
]],{filename = filename(), db_str = db_str(), date_str = date_str()})
  ),
  s("initpg", fmt([[


import pg_db_configure as configure

DST_TABLE = "{filename}"
DST_DB = "{db_str}"


def init_env(tdw):
    execute_sql(tdw, "use {{dst_db}}".format(dst_db=DST_DB))
    tdw.execute('set pg_url=%s' % (configure.sng_mqqdata_pg_url))
    tdw.execute('set pgdata.user=%s' % (configure.sng_mqqdata_pg_user))
    tdw.execute('set pgdata.passwd=%s' % (configure.sng_mqqdata_pg_passwd))

def execute_sql(tdw, sql):
    tdw.WriteLog("executing SQL:\n %s" % sql)
    tdw.execute(sql)


def create_table(tdw):
    create_sql = """
        CREATE EXTERNAL TABLE IF NOT EXISTS {{dst_table}} (
            {date_str} BIGINT COMMENT '日期'
        )
        COMMENT ''
        STORED AS PGDATA
    """.format(dst_table=DST_TABLE)
    execute_sql(tdw, create_sql)


def insert_data(tdw, {date_str}):
    insert_sql = """
        INSERT TABLE {{dst_table}}

    """.format(dst_table=DST_TABLE, {date_str}={date_str})
    execute_sql(tdw, insert_sql)

def truncate_partition(tdw, {date_str}):
    execute_sql(tdw, "use {{dst_db}}".format(dst_db=DST_DB))
    sql = "DELETE FROM {{dst_table}} WHERE {date_str} = {{{date_str}}}".format(dst_table=DST_TABLE, {date_str}={date_str})
    execute_sql(tdw, sql)

def TDW_PL(tdw, argv):
    tdw.WriteLog("%s begin!" % DST_TABLE)

    # get args
    {date_str} = argv[0]

    # 0、set db
    init_env(tdw)

    # 1、create table
    create_table(tdw)

    # 2、清空分区
    truncate_partition(tdw, {date_str})

    # 3、insert data
    insert_data(tdw, {date_str})

    tdw.WriteLog("%s end!" % DST_TABLE)
  ]],{filename = filename(), db_str = db_str(), date_str = date_str()})
)
}
