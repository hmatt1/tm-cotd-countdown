
[Setting name="TextColor"]
string colorCode = "\\$0F7";

[Setting name="TextPosition"]
string textPosition = "300";

// returns 1 between the last sunday in march and the last sunday in october
int getCestNow(Time::Info timeInfo) {

    int cestNow = 0;

    int yy = timeInfo.Year % 100;
    int yyDiv4 = yy / 4;
    int yearCode = (yy + yyDiv4) % 7;


    int monthCode = 0;

    if (timeInfo.Month == 1) {
        monthCode = 0;
    } else if (timeInfo.Month == 2) {
        monthCode = 3;
    } else if (timeInfo.Month == 3) {
        monthCode = 3;
    } else if (timeInfo.Month == 4) {
        monthCode = 6;
    } else if (timeInfo.Month == 5) {
        monthCode = 1;
    } else if (timeInfo.Month == 6) {
        monthCode = 4;
    } else if (timeInfo.Month == 7) {
        monthCode = 6;
    } else if (timeInfo.Month == 8) {
        monthCode = 2;
    } else if (timeInfo.Month == 9) {
        monthCode = 5;
    } else if (timeInfo.Month == 10) {
        monthCode = 0;
    } else if (timeInfo.Month == 11) {
        monthCode = 3;
    } else if (timeInfo.Month == 12) {
        monthCode = 5;
    }

    //assume we are in the 21st century since that is the current
    int centuryCode = 6;

    if (timeInfo.Year >= 2100) {
        centuryCode = 4;
    }

    if (timeInfo.Year >= 2200) {
        centuryCode = 2;
    }

    if (timeInfo.Year >= 2300) {
        centuryCode = 0;
    }

    // in year 2400, someone will have to update this with a new century code

    int dateNumber = timeInfo.Day;

    int leapYear = 0;

    if (timeInfo.Year % 4 == 0 && timeInfo.Year % 100 != 0) {
        leapYear = 1;
    }

    if (timeInfo.Year % 400 == 0) {
        leapYear = 1;
    }

    int dayOfWeek = (yearCode + monthCode + centuryCode + dateNumber - leapYear) % 7;


    bool pastLastSundayInMarch = false;

    if (timeInfo.Month > 3) {
        pastLastSundayInMarch = true;
    }

    // 26 - fri (5)
    // 27 - sat (6) 
    // 28 - sunday (0)
    // 29 - mon (1)
    // 30 - tu (2)
    // 31 - wed (3)

    int lastSunday = dateNumber - dayOfWeek;

    if (timeInfo.Month == 3 && (31 - lastSunday) < 7 ) {
        pastLastSundayInMarch = true;
    }

    bool pastLastSundayInOctober = false;

    if (timeInfo.Month > 10) {
        pastLastSundayInOctober = true;
    }

    if (timeInfo.Month == 10 && (31 - lastSunday) < 7 ) { 
        pastLastSundayInOctober = true;
    }

    if ( pastLastSundayInMarch && ! pastLastSundayInOctober) {
        cestNow = 1;
    }

    return cestNow;
}

void RenderMenuMain()
{
    
    // UTC hours when it is CEST
    int firstCup = 17;
    int secondCup = 1;
    int thirdCup = 9;

    // the same on all computers, epoch time
    uint64 now = Time::get_Stamp();

    // UTC
    auto timeInfo = Time::ParseUTC(now);
    
    // determine whether it is cest or cet
    int cestNow = getCestNow(timeInfo);


    // set cups forward an hour during CET
    if (cestNow == 0) {
        firstCup = firstCup + 1;
        secondCup = secondCup + 1;
        thirdCup = thirdCup + 1;
    }


    string text = colorCode;

    // 1 -> 1.5 (second cup in progress)
    // 1.5 -> 9 (countdown to third cup)
    // 9 -> 9.5 (third cup in progress)
    // 9.5 -> 17 (coundown to main cup)
    // 17 -> 17.5 (main cup in progress)
    // 17.5 -> 1 (coundown to second cup)

    if ( timeInfo.Hour == secondCup and timeInfo.Minute <= 30) {
        text = text + "Second COTD in progress";
    } else if ( timeInfo.Hour == thirdCup and timeInfo.Minute <= 30 ) {
        text = text + "Third COTD in progress";
    } else if (timeInfo.Hour == firstCup and timeInfo.Minute <= 30) { 
        text = text + "Main COTD in progress";
    } else {
        

        int hoursToMainCup = firstCup - timeInfo.Hour - 1;
        int hoursToThirdCup = thirdCup - timeInfo.Hour - 1;

        int hoursToSecondCup = 0;
        if (timeInfo.Hour >= secondCup) {
            hoursToSecondCup = 25 - timeInfo.Hour - 1;
        }
        
        int minutes = 60 - timeInfo.Minute;

        if (minutes == 60) {
            minutes = 0;
            hoursToMainCup = hoursToMainCup + 1;
            hoursToSecondCup = hoursToSecondCup + 1;
            hoursToThirdCup = hoursToThirdCup + 1;
        }

        if (timeInfo.Hour < secondCup or timeInfo.Hour >= firstCup) {
            text = text + hoursToSecondCup + "h " + minutes + "m until Second COTD";
        } else if (timeInfo.Hour < thirdCup) {
            text = text + hoursToThirdCup + "h " + minutes + "m until Third COTD ";
        } else {
            text = text + hoursToMainCup + "h " + minutes + "m until Main COTD";
        }
     }

	auto textSize = Draw::MeasureString(text);

	auto pos_orig = UI::GetCursorPos();
	UI::SetCursorPos(vec2(UI::GetWindowSize().x - textSize.x - Text::ParseInt(textPosition), pos_orig.y));
	UI::Text(text);
	UI::SetCursorPos(pos_orig);
}
