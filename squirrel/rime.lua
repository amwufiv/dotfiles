function date_translator(input, seg)
    if (input == "date") then
       --- Candidate(type, start, end, text, comment)
       yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), ""))
    end
    if (input == "time") then
        yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), ""))
    end
    if(input == "datetime") then
        yield(Candidate("datetime", seg.start, seg._end, os.date("%Y-%m-%d %H:%M:%S"), ""))
    end
 end

-- 各个信息匹配
function personal_info_translator(input, seg)
    -- on = env.engine.context:get_option("scene")
    if (input == "mail") then
        yield(Candidate("date", seg.start, seg._end, "amwufiv@gmail.com", ""))
        yield(Candidate("date", seg.start, seg._end, "lingranhuang@gmail.com", ""))
        yield(Candidate("date", seg.start, seg._end, "ieend@foxmail.com", ""))
    end
    if (input == "phone") then
        yield(Candidate("date", seg.start, seg._end, "15521166604", ""))
    end
end