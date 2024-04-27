--------------------------------
-- Schedule.lua
-- Handles scheduling and related
-- data.
--------------------------------

local _, KeyMaster = ...

-- Weekly reset credit for noodeling this out: AstralKeys
-- https://github.com/astralguild/AstralKeys
KeyMaster.week = 0

local initializeTime = {}
initializeTime[1] = 1500390000 -- US Tuesday at reset
initializeTime[2] = 1500447600 -- EU Wednesday at reset
initializeTime[3] = 1500505200 -- TW Thursday at reset
initializeTime[4] = 0

function KeyMaster:WeekTime()
	local region = GetCurrentRegion()

	if region == 3 then -- EU
		return GetServerTime() - initializeTime[2] - 604800 * KeyMaster.week
	elseif region == 4 then -- TW
		return GetServerTime() - initializeTime[3] - 604800 * KeyMaster.week
	else -- default to US
		return GetServerTime() - initializeTime[1] - 604800 * KeyMaster.week
	end
end

function KeyMaster:GetWeek()
	local region = GetCurrentRegion()
	if region == 3 then  -- EU
		return math.floor((GetServerTime() - initializeTime[2]) / 604800)
	elseif region == 4 then -- TW
		return math.floor((GetServerTime() - initializeTime[3]) / 604800)
	else                 -- default to US
		return math.floor((GetServerTime() - initializeTime[1]) / 604800)
	end
end

function KeyMaster:WeeklyResetTime()
	local region = GetCurrentRegion()
	local serverTime = GetServerTime()
	local d = date('*t', serverTime)
	local hourOffset, minOffset = math.modf(difftime(serverTime, time(date('!*t', serverTime))))/3600
	minOffset = minOffset or 0
	local hours
	local days

	if region ~= 3 then -- Not EU
		hours = 15 + (d.isdst and 1 or 0) + hourOffset
		if d.wday > 2 then
			if d.wday == 3 then
				days = (d.hour < hours and 0 or 7)
			else
				days = 10 - d.wday
			end
		else
			days = 3 - d.wday
		end
	else -- EU
		hours = 7 + (d.isdst and 1 or 0) + hourOffset
		if d.wday > 3 then
			if d.wday == 4 then
				days = (d.hour < hours and 0 or 7)				
			else
				days = 11 - d.wday
			end
		else
			days = 4 - d.wday
		end
	end

	local time = (((days * 24 + hours) * 60 + minOffset) * 60) + serverTime - d.hour*3600 - d.min*60 - d.sec

	return time
end