//
//  Constants.h
//  MarathonMegan
//
//  Created by Jennifer Duffey on 2/18/13.
//
//

#define vcLoginView		@"LoginViewController"
#define vcFormView		@"FormViewController"
#define vcMenuView		@"MenuViewController"
#define vcGoalsView		@"GoalsViewController"
#define vcCalendarView	@"CalendarViewController"
#define vcRunView		@"RunViewController"

#define ENTRY_SEGUE		@"entrySegue"
#define LOGIN_SEGUE		@"LoginSegue"
#define SIGN_UP_SEGUE	@"SignUpSegue"
#define MAIN_SEGUE		@"mainSegue"
#define BACK_SEGUE		@"BackSegue"
#define GOALS_SEGUE		@"GoalsSegue"


#define KEY_WEEKS_CLASS			@"weeks"
#define KEY_ACTIVITY_CLASS		@"activity"
#define KEY_USER_CLASS			@"User"
#define KEY_USER_OBJECT			@"user"
#define KEY_MILES_OBJECT			@"miles"
#define KEY_NOTES_OBJECT			@"notes"
#define KEY_START_DATE_OBJECT		@"startDate"
#define KEY_MILES_TO_RUN_OBJECT	@"milesToRun"
#define KEY_WEEK_NUMBER_OBJECT	@"weekNumber"
#define KEY_DATE_OF_RUN_OBJECT	@"dateOfRun"

#define ACTIVITY_CELL_IDENTIFIER			@"ActivityCellIdentifier"
#define TODAY_CELL_IDENTIFIER				@"TodayCellIdentifier"
#define DAY_CELL_IDENTIFIER				@"DayCellIdentifier"
#define DAY_SELECTED_CELL_IDENTIFIER		@"DaySelectedCellIdentifier"
#define DISABLED_DAY_CELL_IDENTIFIER		@"DisabledDayCellIdentifier"
#define CALENDAR_HEADER_CELL_IDENTIFIER		@"CalendarHeaderCellIdentifier"
#define CALENDAR_FOOTER_CELL_IDENTIFIER		@"CalendarFooterCellIdentifier"
#define MENU_CELL_IDENTIFIER		@"MenuCellIdentifier"

#define FONT_MARKETING_SCRIPT		@"MarketingScript"
#define FONT_BAUHAUS			@"BauhausStd-Bold"

#define TOTAL_CALENDAR_CELLS			43

#define BUTTON_WIDTH			300
#define BUTTON_HEIGHT			42
#define FONT_SIZE_BUTTON			16
#define FONT_SIZE_DAYS_LEFT		50

#define CIRCLE_PADDING			5
#define CIRCLE_SIZE				15
#define SMALL_GAP				2

#define MENU_LEFT			-293

// Colors
#define VINE_COLOR				@"0x01b987"

#define IS_TALLSCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPhone" ] )
#define IS_IPOD   ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPod touch" ] )

typedef enum
{
	LoginStateRegister = 1,
	LoginStateLogin = 2
} LoginState;

typedef enum
{
	MarathonMeganColorYellow = 1,
	MarathonMeganColorOrange = 2,
	MarathonMeganColorBlue = 3,
	MarathonMeganColorGreen = 4,
	MarathonMeganColorRed = 5,
	MarathonMeganColorVine = 6
} MarathonMeganColor;