
[Setting name="TextColor"]
string colorCode = "\\$0F7";

[Setting name="TextPosition"]
string textPosition = "300";

void RenderMenuMain()
{

    int firstCup = 17;
    int secondCup = 1;
    int thirdCup = 9;

    uint64 now = Time::get_Stamp();

    auto timeInfo = Time::ParseUTC(now);
    
    string text = colorCode;

    // 1 -> 1.5 (second cup in progress)
    // 1.5 -> 9 (countdown to third cup)
    // 9 -> 9.5 (third cup in progress)
    // 9.5 -> 17 (coundown to main cup)
    // 17 -> 17.5 (main cup in progress)
    // 17.5 -> 1 (coundown to second cup)

    if ( timeInfo.Hour == 1 and timeInfo.Minute <= 30) {
        text = text + "Second COTD in progress";
    } else if ( timeInfo.Hour == 9 and timeInfo.Minute <= 30 ) {
        text = text + "Third COTD in progress";
    } else if (timeInfo.Hour == 17 and timeInfo.Minute <= 30) { 
        text = text + "Main COTD in progress";
    } else {
        int minutes = 60 - timeInfo.Minute;
        int hoursToMainCup = 17 - timeInfo.Hour - 1;
        int hoursToThirdCup = 9 - timeInfo.Hour - 1;

        int hoursToSecondCup = 0;
        if (timeInfo.Hour >= 1) {
            hoursToSecondCup = 25 - timeInfo.Hour - 1;
        }

        if (timeInfo.Hour < 1 or timeInfo.Hour >= 17) {
            text = text + hoursToSecondCup + "h " + minutes + "m until Second COTD";
        } else if (timeInfo.Hour < 9) {
            text = text + hoursToThirdCup + "h " + minutes + "m until Third COTD";
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
