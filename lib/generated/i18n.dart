import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/constant.dart';

class S implements WidgetsLocalizations {
  const S();

  static S? current;

  static const GeneratedLocalizationsDelegate delegate =
      GeneratedLocalizationsDelegate();

  static S? of(BuildContext context) => Localizations.of<S>(context, S);

  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get appName => "Naveli";

  String get plEnterEmail => "Please enter E-mail";

  String get plEnterEmailOrMobile => "Please enter E-mail Or Mobile";

  String get plEnterValidEmail => "Please enter valid email address";

  String get noInternet => "No internet";

  String get doYouKnow => "Do you know?";

  String get update => "Update";

  String get here => "Here";

  String get letKnowYou => "Let's know you better!";

  String get enterYourName => "Enter your name";

  String get plSelectYourGender => "Please select your gender";

  String get plEnterName => "Please enter name";

  String get nutrition => "Nutrition";

  String get download => "Download PDF";

  String get reports => "Graphs & Reports";

  String get askYourQuestion => "Ask your Question";

  String get queOfDay => "Question of the Day";

  String get plWriteQue => "Please write your Question";

  String get plSelectYourMedicine => "Please select your medicines";

  String get plSelectTs => "Please accept terms of service";

  String get plSelectPrivacy => "Please accept privacy policy";

  String get ailments => "Ailments";

  String get plSelectYourRelation => "Please select your relationship status";

  String get plEnterMobile => "Please enter mobile no.";

  String get plSelectSleepTime => "Please select your sleep time";

  String get plWakeUpSleepTime => "Please select your wake up time";

  String get plFeelAnswer => "Please feel all questions answers";

  String get plSelectMedicine => "Please select medicine";

  String get plSelectAilment => "Please select ailment";

  String get plAddComment => "Please add comment";

  String get plEnterHamAapkeKon => "Please enter hum aapke hain kaun";

  String get plEnterAge => "Please enter age";

  String get selectOption => "Select an option below";

  String get like => "Like";

  String get dislike => "Dislike";

  String get plEnterHeight => "Please enter height";

  String get plSelectWeight => "Please select weight";

  String get plSelectPreviousPeriodDate => "Please your previous periods date";

  String get userDataSyncFailed => "User data sync failed";

  String get plSelectYourBday => "Please select your birth date";

  String get plEnterValidOtp => "Please enter valid OTP";

  String get mythVsFacts => "Myth vs facts";

  String get logYourSymptoms => "Log Symptoms";

  String get womenInNews => "NeoW in News";

  String get oops => "Network Error";

  String get allAboutPeriods => "All about Periods";

  String get plEnter10DigitsMobile => "Please enter 10 Digits mobile no.";

  String get plSelectUserType => "Please select user type";

  String get plEnterPassword => "Please enter password";

  String get sleep => "Sleep";

  String get pco => "PCO";

  String get pms => "PMS";

  String get share => "Share";

  String get comment => "Comment ";

  String get welcomeForum => "Welcome to NeoW’s Forum";

  String get water => "Water";

  String get follow => "Follow";

  String get settings => "Settings";

  String get profile => "Profile";

  String get welcomeToOurForum => "Welcome to Our Forum";

  String get kg => "Kg";

  String get hamAapkeKon => "Hum Aapke hain Kaun!";

  String get naveliUniqueId => "Naveli’s Unique ID";

  String get relationShipWithNeow => "Your relationship\nwith NeoW?";

  String get gender => "Gender";

  String get secretDiary => "Secret Diary";

  String get healthMix => "Health Mix";

  String get reminder => "Reminder";

  String get hisutism => "Hirsutism";

  String get dataNotFound => "Data not found";

  String get contactNoNotAvailable => "Contact number not available.";

  String get locationService => 'Location service';

  String get waterReminder => 'Water Intake';

  String get logYourWeight => 'Log Your Weight';

  String get logYourSleepHour => 'Log Your Sleep hour';

  String get width => 'Width';

  String get areYouSure => 'Are you sure?';

  String get thisActionPermanentlyDelete =>
      'This action will permanently delete this album';

  String get min => 'Min';

  String get height => 'Height';

  String get track => 'Track';

  String get age => 'Age';

  String get locationPermission => 'Location permission';

  String get plEnableLocationService =>
      'Please enable location service to get current location.';

  String get plAllowLocationPermission =>
      'Please allow location permission to get current location.';

  String get enableService => 'Enable service';

  String get allowPermission => 'Allow permission';

  String get done => 'Done';

  String get online => "You are online now";

  String get periodsInformation => "Periods Information";

  String get superWomen => "Super Women";

  String get offline => "You are offline now";

  String get login => "Login";

  String get medication => "Medication";

  String get signUp => "SignUp";

  String get alreadyHave => "Already have an account? LogIn";

  String get dontHave => "Don't have an account? SignUp";

  String get forgotPassword => "Forgot password";

  String get wesupport =>
      "We support all forms of gender expression. However, we need this to calculate your body metrics.";

  String get yourgender => "Whats your gender vibe? fam?";

  String get relationshipStatus => "Relationship Status";

  String get yourJourney => "Your journey in candles?";

  String get selectDate => "Select Date";

  String get name => "Name";

  String get other => "Other";

  String get enterOtherGender => "Enter other gender";

  String get female => "Female";

  String get selectAny => "Select any one in below ";

  String get whoAreYou => "Who are you ?";

  String get neowMe => "Neow";

  String get buddy => "Buddy";

  String get cycleEnthu => "Cycle Enthusiast";

  String get emailOrPhone => "E-mail or Phone No.";

  String get password => "Password";

  String get welcomeToNewYou => "Welcome to New You!";

  String get welcome =>
      "We'll ask you a few questions to help personalize your experience. ";

  String get yoQuickSurvey => "Yo, Quick survey time- Help us level up";

  String get myDailyInsights => "My daily insights - Today";

  String get yourFabulousName => "Your Fabulous name, please";

  String get neowmeName => "Neowme, Naam to";

  String get sunaHoga => "suna hi hoga";

  String get email => "Email";

  String get phone => "Phone No.";

  String get submit => "Submit";

  String get willAsk =>
      "We'll ask you a few questions to help personalize your experience.";

  String get resendOtp => "Resend OTP";

  String get requestOtp => "Request for new OTP in";

  String get seconds => "seconds";

  String get enterYourOtp => "Enter Your OTP";

  String get beforeWeGet => "Before we get started";

  String get yatriGanDhyanDe => "Yatrigan Kripya Dhyaan dein";

  String get pleaseAsk =>
      "Please ask your parent or guardian to help you set up your NeoW account.";

  String get asYouAre =>
      "As you're younger than 16 years old. we're legally required to ask a parent or guardian for:";

  String get theirPermission => "Their permission for you to use the NeoW app.";

  String get theirHelp => "Their help to set up your privacy settings";

  String get accept => "Accept";

  String get next => "Next";

  String get sleepNow => "Sleep Now";

  String get apply => "Apply";

  String get quiz => "Quiz";

  String get knowYourBody => "Know your body";

  String get myDashboard => "My Dashboard";

  String get weight => "Weight";

  String get calculateBmi => "Calculate BMI";

  String get bmiScore => "BMI Score";

  String get normal => "Normal";

  String get bmi => "BMI";

  String get decline => "Decline";

  String get removeAccess => "Remove access";

  String get bmiCalculator => "BMI Calculator";

  String get youAndClue => "You and Clue";

  String get wePromise =>
      "We promise to keep your data safe, secure and private. Please take a moment to get to know our policies.";

  String get iAgree => "I agree to NeoW's  ";

  String get termsOfServices => "Terms Of Service.";

  String get iHaveReadClue => "I have read NeoW’s  ";

  String get privacyPolicy => "Privacy Policy";

  String get iAgreeProcessing =>
      "I agree to Clue processing the health data I choose to share with the app, so they can provide their service.";

  String get iShowedAbove =>
      "I showed the above policies to my parent/guardian. and they agreed I could use Clue and that Clue could process my health data.";

  String get quickSurvey => "Yo, Quick survey time- Help us level up";

  String get averageCycle => "Average cycle length (Days)";

  String get whenDidYour => "When did your last periods begin?";

  String get averagePeriod => "Average period length (Days)";

  String get letsSprinkle => "Let’s sprinkle some magic together";

  String get iDontRemember => "I don’t Remember";

  String get date => "Date";

  String get days => "Days";

  String get getReminder => "Get reminders about your cycle";

  String get stayYourPeriod => "Stay unstoppable, even during your period!";

  String get nightReminder => "Night Reminder Time";

  String get cancel => "Cancel";

  String get delete => "Delete";

  String get ok => "Ok";

  String get setReminder => "Set Reminder";

  String get mood => "Mood";

  String get or => "or";

  String get plSelectState => "Please select your state!";

  String get plSelectCity => "Please select your city!";

  String get male => "Male";

  String get edit => "Edit";

  String get accepted => "Accepted";

  String get transgender => "Transgender";

  String get otherPlSpec => "Other, please specify";

  String get solo => "Solo";

  String get tied => "Tied";

  String get openForSurprises => "Open for surprises";

  String get sendRequest => "Send request";

  String get openForSur => "Open For Surprises";

  String get yourBDayHelp =>
      "(Your birthdate helps us tailor the app for you!)";

  String get numberOfDays => "Number of days between two periods?";

  String get howLongDosePeriod => "How long does your period last?";

  String get neowInNews => "NeoW in News";

  String get quickQuestion => "Quick Question";

  String get periodMedication => "Period Medication";

  String get deStress => "De-Stress";

  String get healthMixLatest => "Health Mix - Latest";

  String get latest => "Latest";

  String get expertAdvice => "Expert Advice";

  String get cycleWisdom => "Cycle Wisdom";

  String get grooveWithNeow => "Groove with neow";

  String get testimonials => "Testimonials";

  String get funCorner => "Fun corner";

  String get calebSpeaks => "Celeb Speaks";

  String get avgSleepTime => "Average sleep time";

  String get empowHer => "EmpowHer";

  String get interest => "Interest";

  String get dashboard => "Dashboard";

  String get aboutUs => "About us";

  String get help => "Help";

  String get rateUs => "Rate & Review";

  String get logout => "Logout";

  String get home => "Home";

  String get forum => "Forum";

  String get flow => "Flow";

  String get staining => "Staining";

  String get low => "Low";

  String get medium => "Medium";

  String get high => "High";

  String get clotSize => "Clot size";

  String get small => "Small";

  String get accountAccess => "Account access";

  String get yourNaveli => "Your Naveli";

  String get large => "Large";

  String get pain => "Pain";

  String get workingAbility => "Working ability";

  String get always => "Always";

  String get almostAlways => "Almost Always";

  String get almostNever => "Almost Never";

  String get none => "None";

  String get location => "Location";

  String get periodCramps => "Period Cramps";

  String get noHurt => "No Pain";

  String get hurtLittleBit => "Little";

  String get hurtMore => "Bad";

  String get hurtWorst => "Severe";

  String get collectionMethod => "Collection Method";

  String get sanitaryPads => "Sanitary Pads";

  String get cloth => "Cloth";

  String get period_panty => "Period Panty";

  String get tampons => "Tampons";

  String get cups => "Cups";

  String get relaxed => "Relaxed";

  String get sad => "Sad";

  String get energy => "Energy";

  String get lively => "Lively";

  String get irritated => "Irritated";

  String get stress => "Stress";

  String get moderate => "Moderate";

  String get acne => "Acne";

  String get minimal => "Minimal";

  String get rejected => "Rejected";

  String get severe => "Severe";

  String get add => "Add";

  String get lbs => "Lbs";

  String get cm => "Cm";

  String get ft => "Ft";

  String get bedTime => "BedTime";

  String get wakeUpTime => "WakeUp Time";

  String get sleepTime => "Sleep time";

  String get hr => "Hr";

  String get reminderFor => "Reminder For";

  String get selectState => "Select State";

  String get selectDistrict => "Select District";

  String get zodiac => "Zodiac";

  String get selectYourWeight => "Select your weight";

  String get enterNaveliUid => "Enter naveli's Unique Id";

  String get trackYourWeight => "Track your weight and achieve your goals.";

  String get verificationFailed => "verification failed please try again!";

  String get newomeDescription =>
      "I am anyone who has periods and wants to understand my body better while staying healthy.";

  String get cycleDescription =>
      "I am an individual seeking to understand more about periods and overall health and wellness.";

  String get buddyDescription =>
      "I am a partner or guardian who wants to monitor my Neowme's health using her unique buddy code.";

  String get alreadySentRequest =>
      "You have already sent request to another naveli";

  String get keepTrackOfWater =>
      "Keep track of your water intake and set reminders to stay hydrated and healthy";

  String get freqOfChange => "Frequency of Change in a Day";

  String get neverMissADate =>
      "Never miss a date! Stay effortlessly organized by setting dates, events, and tasks with ease.";

  String get aajMainUpar => "Aaj Main Upar Asman Neeche";

  String get whatTimeDoGoBed => "What time do you usually go to bed?";

  String get plEnterUid => "Please enter Unique Id";

  String get plSlReminderDate => "Please select reminder date";

  String get plSlReminderType => "Please select reminder type";

  String get plSlReminderFor => "Please enter reminder for";

  String get whatTimeWakeUp =>
      "What time do you usually wake up in the morning?";

  String get yeDukhKaahe => "Ye dukh kaahe khatam nahi hota hai";

  String get plSelectWeightType => "Please select weight type";

  String get trackAndConquer => "Track and conquer your ailments";

  String get monitorYourBmi =>
      "Monitor your BMI for insights into your overall health and body composition";

  String get howManyDays => "How many days you experience severe pain?";

  String get effortlesslyTrack =>
      "Effortlessly track your medication! Set reminders to monitor your progress with ease.";

  String get howManyTimesYou =>
      "How many times you change your pad/ panty/ cup/ tampon/ others daily?";

  String get exploreTheHidden => "Explore the hidden wonders about your body?";

  String get capacityToPerform =>
      "Capacity to perform tasks effectively while on periods";

  String get uncoveringTruth => "Uncovering Truths and Solving Misconceptions";

  String get decodingPeriod => "Decoding Periods: All you need to know!";

  String get plSelectHirsutism => "Please all hirsutism!";

  String get leadingLadies => "Leading Ladies- : Women Making Headlines";

  String get questionOfDay => "Question of the Day";

  String get periodPainCan =>
      "Period pain can occur in various locations including the lower abdomen, lower back,thighs, etc. How many places does it hurt?";

  String get underStandYourBody =>
      "Understand Your Body Better: Track Symptoms During Your Period";

  String get ifYouHave =>
      "If you have any burning questions, don't hesitate to ask! Our experts are here to provide answers";

  String get eatGlowRepeat =>
      "Eat, Glow, Repeat: Yummy nutrition tips from our experts";

  String get welcomeToNeow =>
      "Welcome to Neow’s Forum- Hey New Women! Welcome to the Neow’s Forum. Engage in insightful discussions, find support, and be inspired to thrive  in every aspect of your life. Join us to connect, grow, and celebrate the journey of womanhood together!";

  String get welcomeToSecret =>
      "Welcome to Secret Diary, your personal space for thoughts, dreams and reflections. Express yourself freely and unlock the power of self-discovery.";

  /// new ///

  String get deActiveYourAcc => "Deactivate your Account";

  String get metricSystem => "Metric system!";

  String get yes => "Yes";

  String get no => "No";

  String get music => "Music";

  String get learning => "Learning";

  String get bodyCare => "Body care";

  String get gratitude => "Gratitude";

  String get workout => "Workout";

  String get hangout => "Hangout";

  String get screenTime => "Screen time";

  String get food => "Food";

  String get cleaning => "   Cleaning   ";

  String get periodDate => "Period date";

  String get cycleLength => "Cycle length";

  String get periodLength => "Period length";

  String get askMeAny => "Hi! You Can Ask Me\nAnything";
  String get announcements => "Announcements ";

  String get askNow => "Ask Now";
  String get check => "Check Now";

  String get goals => "Goals";

  String get addGoals => "Add Goals";

  String get yourGoals => "Your Goals";

  String get dailyDiary => "Daily Diary";

  String get hobbies => "Hobbies";

  String get addHobbies => "Add Hobbies";

  String get yourHobbies => "Your Hobbies";

  String get toDoList => "To Do List";

  String get habitToCut => "Habits to cut";

  String get addHabitsCut => "Add Habits cut";

  String get yourHabits => "Your Habits";

  String get addHabitsAdopt => "Add Habits adopt";

  String get habitsToAdopt => "Habits to adopt";

  String get newThingsToTry => "New things to try";

  String get addThings => "Add Things";

  String get bookToRead => "Books to Read";

  String get addBook => "Add Book";

  String get yourBookToRead => "Your Books to Read";

  String get movieToWatch => "Movies to watch";

  String get addMovies => "Add Movies";

  String get yourThings => "Your Things";

  String get familyGoals => "Family Goals";

  String get yourFamilyGoals => "Your Family Goals";

  String get yourMovieToWatch => "Your Movies to watch";

  String get placeToVisit => "Places to Visit";

  String get yourPlacesToVisit => "Your Places to Visit";

  String get makeAWish => "Make a Wish";

  String get addYourWish => "Add your wish";

  String get addPlaces => "Add Places";

  String get reflection => "Reflection";

  String get goalsAchieved => "Goals Achieved";

  String get quote => "Quote";

  String get month => "Month";

  String get year => "Year";

  String get glass => "glass";

  String get goalsYetToAchieved => "Goals - Yet to Achieve";

  String get unlockTheSecrets => "Unlock the secrets of your cycle!";

  String get mainFocusOfMonth => "Main Focus of the Month";

  String get doubleTapOnBox => "Double Tap on box and write your wish";

  String get max250Char => "(Max. 250 Character)";

  String get max100Char => "(Max. 100 Character)";

  String get monthlyMission => "Monthly Mission";

  String get yeDinYeMahine => "Ye Din, Ye Mahine, Saal !";

  String get rakhnaHaiKhyaal => "Rakhna Hai Apna Khayaal";

  String get targetsMet => "Targets met ?";

  String get monthlyReminder => "Monthly Reminder";

  String get reminderDate => "Reminder Date ";

  String get reminderType => "Reminder Type ";

  String get mainFocus => "Main Focus of the Month";

  String get addYourBullet => "add your bullet point for your to do list";

  String get itDoseNotMatter =>
      "It does not matter how slowly you go as long as you do not stop.";

  String get addYourSecret => "add your bullet point for your secret diary";

  String get reflectOnYour =>
      "Reflect on your monthly goals and achievements effortlessly and strive for progress each time!";

  String get symptomsHundredScore =>
      "You might have heavy Menstrual Bleeding. Get Yourself Examine For";

  String get symptomsPainScore =>
      "You might have Dysmenorrheal the Possible cause may be";

  String get kickOffMonthlyMission =>
      "Kick off your Monthly Missions effortlessly! Set and track goals for the month ahead. Stay motivated, organized, and achieve success with ease.";

  String get yourDailyDose =>
      "Your daily dose of joy! Record your thoughts, moments, and goals effortlessly. Let's make every day memorable together!";

  String get symptomsHundredOption =>
      "• FIBROIDS\n• CYST\n• ENDOMETRIAL POLYP\n• CANCER";

  String get symptomsPainOption =>
      "• ENDOMETRIOSIS\n• FIBROIDS\n• PELVIC INFECTIONS\n• CYST";

  String get whatsYourGender => "Whats your gender vibe? fam?";

  @override
  // TODO: implement reorderItemDown
  String get reorderItemDown => throw UnimplementedError();

  @override
  // TODO: implement reorderItemLeft
  String get reorderItemLeft => throw UnimplementedError();

  @override
  // TODO: implement reorderItemRight
  String get reorderItemRight => throw UnimplementedError();

  @override
  // TODO: implement reorderItemToEnd
  String get reorderItemToEnd => throw UnimplementedError();

  @override
  // TODO: implement reorderItemToStart
  String get reorderItemToStart => throw UnimplementedError();

  @override
  // TODO: implement reorderItemUp
  String get reorderItemUp => throw UnimplementedError();

  String get optionNeow => "NEOW";

  String get optionNeowSubtitle => "Understand my body and health";

  String get optionBuddy => "BUDDY";

  String get optionBuddySubtitle => "Monitor my NeoW's health";

  String get optionFitness => "FITNESS ENTHUSIAST";

  String get optionFitnessSubtitle => "Learn about periods & wellness";

  String get enterPhoneNumber => 'Enter your phone number';

  String get continueText => 'Continue';

  String get tcTitle =>
      "By clicking the box below, you agree to our Terms and Conditions and Privacy Policy.";

  String get tcSubtitle =>
      "In case you are younger than 16 years, please ask your parent/guardian to help you set up your NeoW account. Their permission is mandatory for you to use NeoW app.";

  String get whereAreYouFrom => "Where are you from?";

  String get letUsknowYouBetter => "Let us know you better!";

  String get helpUsPersonaliseyourExp =>
      "Answer a few questions to help personalise your experience.";

  String get getStarted => "Get Started";

  String get neowNaamSunaHoga => "Naam to suna hi hoga";

  String get typeHere => "Type here";

  String get yourJourneyInCandles => "Your journey in candles";

  String get yourJourneyDescription =>
      "Your birth date helps us tailor the app for you!";

  String get wohHaiKahan => "Woh hai kahan?";

  String get akeleHaiTohKya => "Akele hai toh\nkya gham hai";

  String get quickSurveyTime => "Yo, Quick Survey Time";

  String get helpUsLevelUp => "Help us level up.";

  String get cycleLengthDiff => "Average Cycle Length (Days)";

  String get periodLengthDiff => "Average Period Length (Days)";

  String get unusualCycle => "Unusual Cycle";

  String get unusualPeriod => "Unusual Period Length";

  String get unusualPeriodDescription =>
      "It seems your period length may be a bit unusual. Typically, periods last between 2-7 days. If your period consistently falls outside this range, we suggest reaching out to a healthcare provider for guidance.";

  String get unusualCycleDescription =>
      "We noticed that your cycle appears to be unusual. The typical range is between 21-35 days. If your cycle is consistently outside this range, we recommend consulting a healthcare provider for further advice.";

  String get lastPeriodDay => "Your Last Period Date";

  String get gottonYourselfVaccinated =>
      "Have you gotten yourself vaccinated against cervical cancer?";

  String get howManyDoseTaken => "How many doses have you\ntaken?";

  String get dose1 => "Dose 1";

  String get dose2 => "Dose 2";

  String get dose3 => "Dose 3";

  String get dose2Pending => "Dose 2 Is Pending!";

  String get dose2Timing => "Take it 6 months after your first dose.";

  String get veryGood => "Very Good!";

  String get vaccinationComplete => "Your vaccination is complete.";

  String get uhoh => "Uh-oh!";

  String get getVaccinatedToday =>
      "Get yourself vaccinated today. You need 2 doses at an interval of 6 months.";

  String get tryingToGetPregnant => "Have you been trying to get pregnant?";

  String get tryingSince12Months =>
      "Have you been trying since 12 months or more than that?";

  String get youNeedFertilityWork =>
      "You need a fertility work up to find out the cause.";

  String get clickHere => "Click Here";

  String get keepTrying =>
      "Keep trying for at least 6 months - To know more about your fertile period";

  String get irregularBleeding =>
      "Do you experience heavy/\nirregular bleeding?";

  String get getUltrasound =>
      "Get yourself an\nUltrasound and a Pap Smear today.";

  String get possiblecause =>
      "Possible cause may be:\n• Fibroids\n• Endometriosis\n• Cancer\n• Cyst";

  String get getExamined => "Get examined today!";

  String get haveYouGotPapSmear => "Have you got any Pap Smear in the past?";

  String get getOneToday =>
      "Get one today. It is a very important test to diagnose Cervical Cancer and its early stages.";

  String get lastpapSmear => "When was your last Pap Smear?";

  String get threeYearsBack => "3 Years Back";

  String get lessThanThreeYears => "Less Than 3 Years";

  String get repeatPapSmear => "Repeat a Pap smear today!";

  String get okay => "Okay";

  String get getOneAfter3Years => "Get another one at an interval of 3 years!";

  String get hadPeriodLasyYear =>
      "Have you had any periods\nin the last one year?";

  String get doNotWorry => "Do Not Worry!";

  String get postmenopausalSymptoms =>
      "These are Postmenopausal symptoms due to estrogen deficiency, consult a gynecologist to start HRT (Hormone Replacement Therapy) to relieve these symptoms.";

  String get experiencedPostmenopausalSpotting =>
      "Have you experienced\npostmenopausal spotting or\nor bleeding after 1 Year of\nstoppage?";

  String get getUltrasoundAndPapSmear =>
      "Get yourself an\nUltrasound and a Pap\nSmear today.";

  String get possibleCauses =>
      "Possible causes may be :\n• Estrogen Deficiency\n• Vaginal Dryness\n• Cancer";

  String get youAreNotMenopausal => "You are not Menopausal yet!";

  String get reachedMenopause => 'You have reached\nMenopause!';

  String get doYouExp => 'Do you experience:';

  String get selectMultiple => '(Select Multiple)';

  String get pleaseSelectAtleastOne => "Please select at least one symptom";

  String get hotFlushes => 'Hot Flushes';

  String get tiredness => 'Tiredness';

  String get moodSwings => "Mood Swings";

  String get vaginalDryness => 'Vaginal Dryness';

  String get decreasedSexDrive => 'Decreased Sex Drive';

  String get jointPain => 'Joint Pain';

  String get personalisingExp => 'Personalising your experience';

  String get welcomeViewText => "Welcome!";

  String get dayText => "Day";

  String get daysText => "Days";

  String get viewAll => "View All";

  String get trackAndLearn => "Track and Learn";

  String get explore => "Explore";

  String get articles => "Articles";

  String get latestVideos => "Latest Videos";

  String get shorts => "Shorts";

  String get letsTakeDive => "Let\'s take a dive\ninto your day!";

  String get chatNow => 'Chat Now';

  String get askADoctor => "Ask a Doctor.";

  String get haveAnyQuestion =>
      "Have any questions, our\nexperts are here to guide.";

  String get askDoctor => "Here";

  String get hi => "Hi";

  String get theNeowStory => "The NeoW Story";

  String get leadingLadies1 => "Leading Ladies: Women making\nHeadlines";

  String get leadingLadies2 => "Leading Ladies: Women Making Headlines";

  String get tapHere => "Here";

  String get popular => "Popular";

  String get oldest => "Oldest";

  String get saved => "Saved";

  String get noContentInThisCategory => "No content uploaded in this category.";

  String get veryActive => "Very\nActive";

  String get active => "Active\n";

  String get inActive => "Inactive\n";

  String get somewhatActive => 'Somewhat\nActive';

  String get headache => 'Headache';

  String get backache => 'Backache';

  String get legPain => 'Leg Pain';

  String get abdominalPain => 'Abdominal Pain';

  String get daysOfPain => "Days of Pain";

  String get times => "times";

  String get time => "time";

  String get tired => "Tired";

  String get noAcne => "None";

  String get save => "Save";

  String get pleaseSelectStaining => "Please select staining.";

  String get pleaseSelectClotSize => "Please select clot size.";

  String get pleaseSelectWorkingAbility => "Please select working ability.";

  String get pleaseSelectAtleastOneLocation =>
      "Please select at least one pain location.";

  String get pleaseSelectCramps => "Please select cramps status.";

  String get pleaseSelectDays => "Please select days.";

  String get pleaseSelectMethod => "Please select collection method.";

  String get pleaseSelectFrequency => "Please select frequency of change.";

  String get pleaseSelectMood => "Please select mood.";

  String get pleaseSelectEnergyLevel => "Please select energy level.";

  String get pleaseSelectStressLevel => "Please select stress level.";

  String get pleaseSelectAcne => "Please select acne severity.";

  String get failedToLogSymptoms => "Failed to log symptoms. Please try again.";

  String get symptomsLoggedSuccess => "Symptoms logged successfully.";

  String get logOnlyOnPeriodDay =>
      "You can log your Symptoms only on Period Days.";

  String get logPeriod => "Log Period";

  String get postDetails => "Post Details";

  String get tags => "Tags";

  String get description => "Description";

  String get trackYourHealth => "Track Your Health";

  String get exploreHealthmix => "Explore HealthMix";

  String get notifications => "Notifications";

  String get noNotificationYet => "No notifications yet!";

  String get viewAndAccessAllYourReport =>
      'View and access all your\nhealth reports here.';

  String get myHealthReports => 'My Health Reports';

  String get missionAndVision => "Mission and Vision";

  String get reminders => "Reminders";

  String get timelyReminders => "Timely reminders, tailored for you";

  String get findAnswersAndAssistance =>
      "Find answers and get\nassistance here";

  String get controlYourAppSettings => "Control your app settings your way";

  String get shareNeowApp => "Share NeoW App";

  String get shareAppWithFriends =>
      "Share our app with your friends\nand family.";

  String get followUsOn => "Follow us on:";

  String get rateAndWriteReview => "Rate and write an app review";

  String get today => "Today";

  String get personalInformation => "Personal Information";

  String get state => "State";

  String get district => "District";

  String get phoneNumber => "Phone Number";

  String get dateOfBirth => "Date of Birth";

  String get editEmail => "Edit email";

  String get enterEmail => "Enter email";

  String get ageGroup => "Age Group";

  String get vaccination => "Vaccination";

  String get aboutYouCycle => "About Your Cycle";

  String get symptoms => "Symptoms";

  String get failedToSaveVaccDetails => "Failed to save vaccination details.";

  String get vaccinationDetailsSavedSuccess =>
      "Vaccination details saved successfully!";

  String get nameCannotBeEmpty => "Name cannot be empty";

  String get emailCannotBeEmpty => "Email cannot be empty";

  String get pleaseEnterValidEmail => "Please enter a valid email address";

  String get pleaseSelectState => "Please select a valid state";

  String get pleaseSelectCity => "Please select a valid city";

  String get atWhatAgeFirstPeriod =>
      "At what age did you get your first period ?";

  String get ageYrs => "Age (yrs)";

  String get cervicalCancerVaccine => "Cervical Cancer Vaccine";

  String get hpvVaccine => "HPV Vaccine";

  String get doYouHaveKids => "Do you have kids?";

  String get areYouPregnant => "Are you pregnant?";

  String get switchtoPregnancyMode => "Switch to Pregnancy Mode";

  String get areYouTryingToGetPregnant => "Are you trying to get pregnant?";

  String get tryingSince12MonthsOrMore =>
      "Have you been trying since 12 months or more than that?";

  String get ifYouAre21YearsOrMore =>
      "If you are 21 years or more, have you gotten a pap smear in the past six months?";

  String get ifYouAre50YearsOrMore =>
      "If you are 50 years or more, have you got periods in the last one year?";

  String get doYouExperience => "Do you experience:";

  String get decreasedLibido => "Decreased Libido";

  String get haveyouExpPostmenopausalSpotting =>
      "Have you experienced postmenopausal spotting/bleeding after one year of stoppage of period?";

  String get comingSoon => "Coming Soon.";

  String get welcomeToJourneyOfParent =>
      "Welcome to your journey to becoming a parent!";

  String get howMany => "How Many?";

  List<String> get months => [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ];

  String get loginSuccessfull => "Login Successfull";

  String get loginFailed => "Login Failed";

  String get detailsSavedSuccess => "Details saved successfully!";

  String get detailsSavedfailed => "Error in saving details!";

  String get puberty => "Puberty";

  String get exploreAll => "Explore All";

  String get perimenopause => "Perimenopause";

  String get menopause => "Menopause";

  String get postMenopause => "Post menopause";

  String get seniorYears => "Senior Years";

  String get others => "Others";

  String get savedPosts => "Saved Posts";

  String get profession => "Profession";

  String get tellUsProfession => "Tell us your profession";

  String get pleaseEnterProfession => "Please enter your profession";

  String get readMore => "Read More";

  String get noChatBotDataAvailable =>
      "Hi! I couldn't find any period predictions. Please log your period dates to get started.";

  String get years => "Years";

  String get veryBad => "Very Bad";

  String get bad => "Bad";

  String get good => "Good";

  String get excellent => "Excellent";

  String get yourFeedbackIsAnonymous => "Your feedback is anonymous";

  String get writeUsAReview => "Write us a review";

  String get thankYouForYourReview => "Thank you for your review";

  String get contactUs => "Contact Us";

  String get gotAQuestion =>
      "Got a question, stuck on something, or\njust want to share your thoughts?";

  String get dropUsALine => "Drop us a line!";

  String get weLoveToHearFromYou => "We’d love to hear from you! 🥰";

  String get wePromiseToGetBack =>
      "We promise to get back to you at the earliest—\nbecause helping you is what we do best.";

  String get ourMissionAndVision => "Our Mission & Vision";

  String get ourTeam => "Our Team";

  String get termsOfUse => "Terms of Use";

  String get noDataAvailableLogSymptoms =>
      "No data available. Please log your symptoms.";

  String get noData => "No Data";

  String get tableNo => "No.";

  String get tablePeriodDate => "Period Date (start-end)";

  String get tableCycleLength => "Cycle Length (days)";

  String get tableDeviation => "Deviation (days)";

  String get tableInterpretation => "Interpretation";

  String get tablePeriodLength => "Period Length (days)";

  String get normalAvgCycleRange => "Normal Avg Cycle Range: 21–35 Days";

  String get normalAvgPeriodLength => "Normal Avg Period Length: 2–7 Days";

  String get savedSuccess => "Saved Successfully";

  String get savedFailed => "Error in saving!";

  String get somethingWentWrong => "Something went wrong!";

  String get jiyaDhadakDhadak => "Jiya dhadak dhadak, Jiya dhadak dhadak jaye";

  String get periodExpectedToStartIn2Days =>
      "Your period is expected to start in 2 days. Get ready!";

  String get periodExpectedToStartTomorrow =>
      "Your period is expected to start tomorrow.";

  String get bePrepared => "Be prepared!";

  String get expectPeriodToday => "Expect your period to start today.";

  String get getReady => "Get ready!";

  String get hasPeriodStarted => "Has your period started?";

  String get yesLogSymptoms => "Yes, log my symptoms";

  String get heyNeoW => "Hey NeoW";

  String get derNaHoJaye => "Der na ho jaaye,\nkahin der na ho jaaye";

  String get dontWorryWaitFewHours =>
      "Hey! Don't worry, Let's wait for few hours";

  String get periodSeemsDelayed => "It seems your period \nis delayed.";

  String get logPeriodToStartChatBot =>
      "Please log your period first to start the chatbot.";

  String get logYourPeriod => "Log Your Period";

  String get understandYourCycleBetter =>
      "Understand your cycles better by logging your period.";

  String get periodExpectedToEndToday =>
      "Your period is expected to end today.";

  String get uniqueId => "Unique ID";

  String get language => "Language";

  String get account => "Account";

  String get deactivateAccount => "Deactivate Account";

  String get changePhoneNumber => "Change Phone Number";

  String get failedToGetNotifications => "Failed to fetch notifications";

  String get enterPairingCode => "Enter pairing code";

  String get pairingSubtitle =>
      "Enter secret code generated by your NeoW on her app.";

  String get requestSent => "Request sent to";

  String get pleaseWaitForApproval => ",\nplease wait while it gets approved!";

  String get copiedToClipboard => "Copied to clipboard!";

  String get welcomeBuddy => "Welcome Buddy!";

  String get welcomeBuddySubtitle =>
      "Track your NeoW’s health to support her well-being.";

  String get pairing => "Pairing";

  String get generateCode => "Generate Code";

  String get shareWithBuddy =>
      "Share this with your Buddy to allow them to monitor your cycle and your health.";

  String get currentlyPaired => "Currently Paired";

  String get noBuddies => "No Buddies";

  String get exitPairing => "Exit Pairing";

  String get checkPairingReq => "Check Pairing Requests";

  String get wantsToSeeData => "want to see your data";

  String get mobile => "Mobile";
}

class $en extends S {
  const $en();
}

class $mr extends S {
  $mr();

  // hindi words start //
  @override
  String get removeAccess => "एक्सेस हटाएं";

  @override
  String get mobile => "मोबाइल";

  @override
  String get wantsToSeeData => "आपका डेटा देखना चाहता है";

  @override
  String get checkPairingReq => "पेयरिंग अनुरोध जांचें";

  @override
  String get exitPairing => "पेयरिंग से बाहर निकलें";

  @override
  String get noBuddies => "कोई साथी नहीं";

  @override
  String get currentlyPaired => "वर्तमान में पेयर";

  @override
  String get shareWithBuddy =>
      "इसे अपने साथी के साथ साझा करें ताकि वे आपके चक्र और स्वास्थ्य की निगरानी कर सकें।";

  @override
  String get generateCode => "कोड जनरेट करें";

  @override
  String get pairing => "पेयरिंग";

  @override
  String get welcomeBuddySubtitle =>
      "उसकी भलाई के लिए अपनी NeoW के स्वास्थ्य पर नज़र रखें।";

  @override
  String get welcomeBuddy => "स्वागत है, साथी!";

  @override
  String get copiedToClipboard => "क्लिपबोर्ड पर कॉपी किया गया!";

  @override
  String get requestSent => "अनुरोध ";

  @override
  String get pleaseWaitForApproval =>
      " को भेजा गया है,\nकृपया स्वीकृति का इंतजार करें!";

  @override
  String get pairingSubtitle =>
      "अपनी NeoW द्वारा उसके ऐप पर जनरेट किया गया सीक्रेट कोड दर्ज करें।";

  @override
  String get enterPairingCode => "पेयरिंग कोड दर्ज करें";

  @override
  String get relationShipWithNeow => "आपका NeoW\nसे रिश्ता?";

  @override
  String get failedToGetNotifications => "सूचनाएँ प्राप्त करने में विफल रहा";

  @override
  String get changePhoneNumber => "फोन नंबर बदलें";

  @override
  String get deactivateAccount => "खाता निष्क्रिय करें";

  @override
  String get account => "खाता";

  @override
  String get language => "भाषा";

  @override
  String get uniqueId => "यूनीक आईडी";

  @override
  String get metricSystem => "मेट्रिक प्रणाली!";

  @override
  String get periodExpectedToEndToday =>
      "आपकी पीरियड आज खत्म होने की संभावना है।";

  @override
  String get understandYourCycleBetter =>
      "अपनी पीरियड को लॉग करके अपने साइकल को बेहतर समझें";

  @override
  String get logYourPeriod => "अपनी पीरियड दर्ज करें";

  @override
  String get logPeriodToStartChatBot =>
      "कृपया चैटबोट शुरू करने के लिए पहले अपना पीरियड लॉग करें।";

  @override
  String get periodSeemsDelayed =>
      "ऐसा लगता है कि आपकी पीरियड \nदेरी से आ रही है।";

  @override
  String get dontWorryWaitFewHours =>
      "कोई बात नहीं, कुछ घंटे का इंतजार करते हैं";

  @override
  String get derNaHoJaye => "देर ना हो जाए,\nकहीं देर ना हो जाए";

  @override
  String get heyNeoW => "हैलो NeoW";

  @override
  String get yesLogSymptoms => "हाँ, मेरे लक्षण दर्ज करें";

  @override
  String get getReady => "तैयार हो जाइए!";

  @override
  String get hasPeriodStarted => "क्या आपके पीरियड शुरू हो गए है?";

  @override
  String get expectPeriodToday => "आपके पीरियड आज शुरू होने की संभावना है।";

  @override
  String get bePrepared => "तैयार रहें!";

  @override
  String get periodExpectedToStartTomorrow =>
      "आपके पीरियड कल शुरू होने की संभावना है।";

  @override
  String get periodExpectedToStartIn2Days =>
      "आपके पीरियड शुरू होने में 2 दिन बाकी हैं।";

  @override
  String get jiyaDhadakDhadak => "जिया धड़क धड़क, जिया धड़क धड़क जाए।";

  @override
  String get savedSuccess => "सफलतापूर्वक सहेजा गया!";

  @override
  String get savedFailed => "सहेजने में त्रुटि!";

  @override
  String get somethingWentWrong => "कुछ गलत हो गया!";

  @override
  String get normalAvgPeriodLength => "सामान्य औसत पीरियड अवधि: 2–7 दिन";

  @override
  String get normalAvgCycleRange => "सामान्य औसत चक्र सीमा: 21–35 दिन";

  @override
  String get tableNo => "क्रमांक";

  @override
  String get tablePeriodDate => "पीरियड तिथि (प्रारंभ-समाप्ति)";

  @override
  String get tableCycleLength => "चक्र अवधि (दिन)";

  @override
  String get tableDeviation => "विचलन (दिन)";

  @override
  String get tableInterpretation => "व्याख्या";

  @override
  String get tablePeriodLength => "पीरियड अवधि (दिन)";

  @override
  String get noData => "कोई डेटा नहीं";

  @override
  String get noDataAvailableLogSymptoms =>
      "कोई डेटा उपलब्ध नहीं है। कृपया अपने लक्षण दर्ज करें।";

  @override
  String get termsOfUse => "उपयोग की शर्तें";

  @override
  String get ourTeam => "हमारी टीम";

  @override
  String get ourMissionAndVision => "हमारा मिशन और दृष्टि";

  @override
  String get wePromiseToGetBack =>
      "हम वादा करते हैं कि जल्द से जल्द आपसे संपर्क करेंगे—\nक्योंकि आपकी मदद करना ही हमारा सबसे अच्छा काम है।";

  @override
  String get weLoveToHearFromYou => "हम आपसे सुनना पसंद करेंगे! 🥰";

  @override
  String get dropUsALine => "हमें लिखें!";

  @override
  String get contactUs => "हमसे संपर्क करें";

  @override
  String get gotAQuestion =>
      "कोई सवाल है, किसी चीज़ में अटक गए हैं, या\nबस अपने विचार साझा करना चाहते हैं?";

  @override
  String get thankYouForYourReview => "आपकी समीक्षा के लिए धन्यवाद";

  @override
  String get writeUsAReview => "हमें समीक्षा लिखें";

  @override
  String get yourFeedbackIsAnonymous => "आपकी प्रतिक्रिया गुमनाम है";

  @override
  String get veryBad => "बहुत खराब";

  @override
  String get bad => "खराब";

  @override
  String get good => "अच्छा";

  @override
  String get excellent => "उत्कृष्ट";

  @override
  String get exploreAll => "सभी देखें";

  @override
  String get noChatBotDataAvailable =>
      "नमस्ते! मुझे कोई भी पीरियड प्रेडिक्शन नहीं मिला। शुरू करने के लिए अपने पीरियड की तारीखें लॉग करो";

  @override
  String get readMore => "आगे पढ़ें और जानें!";

  @override
  String get pleaseEnterProfession => "कृपया अपना पेशा दर्ज करें";

  @override
  String get profession => "पेशा";

  @override
  String get tellUsProfession => "हमें अपना पेशा बताएं";

  @override
  String get savedPosts => "सहेजे गए पोस्ट";

  @override
  String get others => "अन्य";

  @override
  String get seniorYears => "वृद्धावस्था";

  @override
  String get postMenopause => "मेनोपॉज़ के बाद की स्थिति";

  @override
  String get menopause => "मेनोपॉज़- मासिक धर्म की समाप्ति";

  @override
  String get puberty => "किशोरावस्था";

  @override
  String get perimenopause => "मेनोपॉज़- पूर्वावस्था";

  @override
  String get detailsSavedfailed => "विवरण सहेजने में त्रुटि!";

  @override
  String get detailsSavedSuccess => "विवरण सफलतापूर्वक सहेजा गया!";

  @override
  String get loginSuccessfull => "लॉग इन सफल";

  @override
  String get loginFailed => "लॉगिन विफल";

  @override
  List<String> get months => [
        'जनवरी',
        'फरवरी',
        'मार्च',
        'अप्रैल',
        'मई',
        'जून',
        'जुलाई',
        'अगस्त',
        'सितंबर',
        'अक्टूबर',
        'नवंबर',
        'दिसंबर',
      ];

  @override
  String get month => "महीना";

  @override
  String get years => "साल";

  @override
  String get year => "साल";

  @override
  String get howMany => "कितने?";

  @override
  String get comingSoon => "जल्द आ रहा है।";

  @override
  String get welcomeToJourneyOfParent =>
      "माता-पिता बनने की आपकी यात्रा में आपका स्वागत है!";

  @override
  String get haveyouExpPostmenopausalSpotting =>
      "क्या आपने एक साल से पीरियड्स बंद होने के बाद फिर से पोस्टमेनोपॉज़ल स्पॉटिंग/ब्लीडिंग का अनुभव किया है?";

  @override
  String get decreasedLibido => "कम यौन इच्छा";

  @override
  String get doYouExperience => "क्या आप इन लक्षणों का अनुभव कर रही हैं:";

  @override
  String get ifYouAre50YearsOrMore =>
      "यदि आपकी उम्र 50 साल या उससे अधिक है, तो क्या आपको पिछले एक साल में पीरियड्स आए हैं?";

  @override
  String get ifYouAre21YearsOrMore =>
      "यदि आपकी उम्र 21 साल या उससे अधिक है, तो क्या आपने पिछले छह महीने में पैप स्मीयर करवाया है?";

  @override
  String get tryingSince12MonthsOrMore =>
      "क्या आप 12 महीने या उससे भी अधिक समय से प्रयास कर रहे हैं?";

  @override
  String get areYouTryingToGetPregnant =>
      "क्या आप गर्भवती होने की कोशिश कर रही हैं?";

  @override
  String get switchtoPregnancyMode => "गर्भावस्था मोड पर स्विच करें";

  @override
  String get areYouPregnant => "क्या आप गर्भवती हैं?";

  @override
  String get doYouHaveKids => "क्या आपके बच्चे हैं?";

  @override
  String get hpvVaccine => "एचपीवी वैक्सीन";

  @override
  String get cervicalCancerVaccine => "सर्वाइकल कैंसर वैक्सीन";

  @override
  String get ageYrs => "आयु (वर्ष)";

  @override
  String get atWhatAgeFirstPeriod =>
      "आपको पहली बार पीरियड किस उम्र में आया था?";

  @override
  String get nameCannotBeEmpty => "नाम खाली नहीं हो सकता";

  @override
  String get emailCannotBeEmpty => "ईमेल खाली नहीं हो सकता";

  @override
  String get pleaseEnterValidEmail => "कृपया एक मान्य ईमेल पता प्रविष्ट करें";

  @override
  String get pleaseSelectState => "कृपया एक वैध राज्य चुनें";

  @override
  String get pleaseSelectCity => "कृपया एक वैध शहर चुनें";

  @override
  String get vaccinationDetailsSavedSuccess =>
      "टीकाकरण विवरण सफलतापूर्वक सहेजा गया!";

  @override
  String get failedToSaveVaccDetails => "टीकाकरण विवरण सहेजने में विफल.";

  @override
  String get aboutYouCycle => "आपके पीरियडस के बारे में";

  @override
  String get symptoms => "पीरियड के लक्षण";

  @override
  String get vaccination => "टीकाकरण";

  @override
  String get deActiveYourAcc => "अपने खाते को निष्क्रिय करें";

  @override
  String get ageGroup => "आयु वर्ग";

  @override
  String get editEmail => "ईमेल संपादित करें";

  @override
  String get enterEmail => "ईमेल दर्ज करें";

  @override
  String get dateOfBirth => "जन्म तिथि ";

  @override
  String get phoneNumber => "फोन नंबर ";

  @override
  String get district => "जिला";

  @override
  String get state => "राज्य";

  @override
  String get personalInformation => "व्यक्तिगत जानकारी";

  @override
  String get today => "आज";

  @override
  String get rateAndWriteReview => "रेट करें और ऐप की समीक्षा लिखें";

  @override
  String get followUsOn => "पर हमें का पालन करें:";

  @override
  String get shareAppWithFriends =>
      "हमारे ऐप को अपने मित्रों और\nपरिवार के साथ साझा करें।";

  @override
  String get shareNeowApp => "NeoW ऐप साझा करें";

  @override
  String get controlYourAppSettings =>
      "अपनी ऐप सेटिंग्स को अपनी तरीके से नियंत्रित करें";

  @override
  String get findAnswersAndAssistance => "यहाँ सहायता प्राप्त करें";

  @override
  String get timelyReminders => "आपके लिए विशेष रूप से तैयार किए गए";

  @override
  String get reminders => "स्मरण सूची";

  @override
  String get missionAndVision => "मिशन और विजन";

  @override
  String get viewAndAccessAllYourReport =>
      'यहां अपने सभी स्वास्थ्य रिपोर्ट देखें';

  @override
  String get myHealthReports => "मेरी स्वास्थ्य रिपोर्ट्स";

  @override
  String get noNotificationYet => "अभी तक कोई सूचना नहीं!";

  @override
  String get notifications => "सूचनाएं";

  @override
  String get exploreHealthmix => "हेल्थमिक्स का अन्वेषण करें";

  @override
  String get trackYourHealth => "अपने स्वास्थ्य पर नज़र रखें";

  @override
  String get description => "विवरण";

  @override
  String get tags => "टैग";

  @override
  String get postDetails => "पोस्ट विवरण";

  @override
  String get logPeriod => "पीरियड लॉग करें";

  @override
  String get logOnlyOnPeriodDay =>
      "आप अपने लक्षण केवल मासिक धर्म के दिनों में ही दर्ज कर सकते हैं।";

  @override
  String get symptomsLoggedSuccess => "लक्षण सफलतापूर्वक लॉग किए गए.";

  @override
  String get failedToLogSymptoms =>
      "लक्षण लॉग करने में विफल। कृपया पुनः प्रयास करें।";

  @override
  String get pleaseSelectStaining => "कृपया स्टेन चुनें.";

  @override
  String get pleaseSelectClotSize => "कृपया थक्के का आकार चुनें.";

  @override
  String get pleaseSelectWorkingAbility => "कृपया कार्य क्षमता का चयन करें.";

  @override
  String get pleaseSelectAtleastOneLocation =>
      "कृपया कम से कम एक दर्द स्थान का चयन करें.";

  @override
  String get pleaseSelectCramps => "कृपया ऐंठन की स्थिति का चयन करें.";

  @override
  String get pleaseSelectDays => "कृपया दिन चुनें.";

  @override
  String get pleaseSelectMethod => "कृपया संग्रहण विधि का चयन करें.";

  @override
  String get pleaseSelectFrequency => "कृपया परिवर्तन की आवृत्ति का चयन करें.";

  @override
  String get pleaseSelectMood => "कृपया मूड चुनें.";

  @override
  String get pleaseSelectEnergyLevel => "कृपया ऊर्जा स्तर का चयन करें.";

  @override
  String get pleaseSelectStressLevel => "कृपया तनाव स्तर का चयन करें.";

  @override
  String get pleaseSelectAcne => "कृपया मुँहासे की गंभीरता का चयन करें.";

  @override
  String get save => "सेव";

  @override
  String get noAcne => "बिलकुल नहीं";

  @override
  String get times => "बार";

  @override
  String get tired => "थकावट";

  @override
  String get time => "बार";

  @override
  String get period_panty => "पीरियड पैंटी";

  @override
  String get daysOfPain => "दर्द के दिनों संख्या";

  @override
  String get backache => 'कमर दर्द';

  @override
  String get legPain => 'पैर में दर्द';

  @override
  String get abdominalPain => 'पेट में दर्द';

  @override
  String get headache => 'सिरदर्द';

  @override
  String get active => "सक्रिय\n";

  @override
  String get inActive => "निष्क्रिय\n";

  @override
  String get somewhatActive => 'कुछ हद तक\nसक्रिय';

  @override
  String get veryActive => "बहुत सक्रिय\n";

  @override
  String get noContentInThisCategory =>
      "इस श्रेणी में कोई सामग्री अपलोड नहीं की गई है।";

  @override
  String get saved => "सेव किया हुआ";

  @override
  String get oldest => "सबसे पुराना";

  @override
  String get popular => "लोकप्रिय";

  @override
  String get tapHere => "क्लिक करें";

  @override
  String get leadingLadies1 => "मुख्य भूमिका में महिलाएं: छाई नारी शक्ति";

  @override
  String get leadingLadies2 => "मुख्य भूमिका में महिलाएं: छाई नारी शक्ति";

  @override
  String get theNeowStory => "द नियो स्टोरी";

  @override
  String get hi => "हेलो";

  @override
  String get askDoctor => "सवाल करें।";

  @override
  String get haveAnyQuestion =>
      "कोई प्रश्न है? हमारे एक्सपर्टस मार्गदर्शन\nके लिए यहाँ हैं।";

  @override
  String get askADoctor => "डॉक्टर से पूछें।";

  @override
  String get chatNow => 'चैट करें';

  @override
  String get letsTakeDive => "आज आप कैसा महसूस\nकर रहे हैं?";

  @override
  String get shorts => "शाॅर्ट्स";

  @override
  String get latestVideos => "लेटेस्ट वीडियो";

  @override
  String get articles => "लेख";

  @override
  String get explore => "खोजें";

  @override
  String get trackAndLearn => "अपने स्वास्थ्य को ट्रैक कर";

  @override
  String get viewAll => "सभी देखें";

  @override
  String get dayText => "दिन";

  @override
  String get daysText => "दिन";

  @override
  String get welcomeViewText => "आपका  स्वागत है ।";

  @override
  String get personalisingExp => 'हम आपके अनुभव को व्यक्तिगत बनाना';

  @override
  String get hotFlushes => 'गर्मी का आभास';

  @override
  String get tiredness => 'थकान';

  @override
  String get moodSwings => "मूड में बदलाव";

  @override
  String get vaginalDryness => 'योनि में सूखापन';

  @override
  String get decreasedSexDrive => 'यौन इच्छा में कमी';

  @override
  String get jointPain => 'जोड़ों में दर्द';

  @override
  String get pleaseSelectAtleastOne => "कृपया कम से कम एक लक्षण चुनें";

  @override
  String get reachedMenopause => 'आप रजोनिवृत्ति तक पहुंच चुकी है (मेनोपॉज़)';

  @override
  String get doYouExp => '(क्या आपको इनमें से कोई लक्षण महसूस होते हैं?)';

  @override
  String get selectMultiple => '';

  @override
  String get youAreNotMenopausal => "आप अभी रजोनिवृत्त/मेनोपॉज़ नहीं हुई हैं!";

  @override
  String get getUltrasoundAndPapSmear =>
      "आज ही अपना अल्ट्रासाउंड और पैप स्मियर टेस्ट कराएं";

  @override
  String get possibleCauses =>
      "संभावित कारण:\n• एस्ट्रोजन की कमी\n• योनि में सूखापन\n• कैंसर";

  @override
  String get experiencedPostmenopausalSpotting =>
      "क्या आपको मासिक धर्म बंद होने के 1 साल बाद भी धब्बेदार रक्तस्राव (स्पॉटिंग) या ब्लीडिंग हुआ है?";

  @override
  String get doNotWorry => "चिंता न करें!";

  @override
  String get postmenopausalSymptoms =>
      "ये रजोनिवृत्ति के बाद के लक्षण हैं और एस्ट्रोजन की कमी के कारण होते हैं। इन लक्षणों से राहत के लिए गाइनोकॉलजिस्ट से संपर्क करें और एचआरटी (हार्मोन रिप्लेसमेंट थेरेपी) शुरू करवाएं।";

  @override
  String get hadPeriodLasyYear =>
      "क्या आपको पिछले एक साल में मासिक धर्म नहीं हुआ है?";

  @override
  String get getOneAfter3Years => "अगला टेस्ट 3 साल के अंतराल पर कराएं";

  @override
  String get repeatPapSmear => "आज ही पैप स्मियर दोहराएं।";

  @override
  String get okay => "ठीक है";

  @override
  String get threeYearsBack => "3 साल से पहले हुआ था";

  @override
  String get lessThanThreeYears => "3 साल से  कम";

  @override
  String get lastpapSmear => "आपका पैप स्मियर कब हुआ था?";

  @override
  String get getOneToday =>
      "नहीं – आज ही यह टेस्ट कराएं। यह सर्वाइकल कैंसर और इसके शुरुआती चरणों का पता लगाने के लिए एक बहुत महत्वपूर्ण टेस्ट है।";

  @override
  String get haveYouGotPapSmear => "क्या आपने पहले कभी पैप स्मियर कराया है?";

  @override
  String get getExamined => "जारी रखें";

  @override
  String get possiblecause =>
      "इसके संभावित कारण हो सकते हैं:\n• फाइब्रॉइड\n• सिस्ट\n• एंडोमेट्रियोसिस\n• कैंसर";

  @override
  String get getUltrasound =>
      "आज ही अपना अल्ट्रासाउंड और पैप स्मियर टेस्ट कराएं";

  @override
  String get irregularBleeding =>
      "क्या आपको बहुत ज्य़ादा ब्लीडिंग या अनियमित ब्लीडिंग हो रहा है?";

  @override
  String get keepTrying => "कम से कम 6 महीने तक कोशिश करते रहें।";

  @override
  String get clickHere => "क्लिक करें।";

  @override
  String get youNeedFertilityWork =>
      "आपको बांझपन के कारण का पता लगाने के लिए एक जांच (इंफर्टिलिटी वर्कअप) की जरूरत है।";

  @override
  String get tryingSince12Months =>
      "क्या आप 6 महीने या उससे अधिक समय से कोशिश कर रही हैं?";

  @override
  String get tryingToGetPregnant =>
      "क्या आप गर्भधारण करने की कोशिश कर रही हैं?";

  @override
  String get getVaccinatedToday =>
      "आज ही टीका लगवाएं। आपको यह 6 महीने के अंतराल पर लगवाना चाहिए।";

  @override
  String get uhoh => "ओह!";

  @override
  String get vaccinationComplete => "आपका टीकाकरण पूरा हो चुका है।";

  @override
  String get veryGood => "बहुत बढ़िया!";

  @override
  String get dose2Timing => "इसे अपनी पहली डोज़ के 6 महीने बाद लगवाएं।";

  @override
  String get dose2Pending => "एक डोज़ बाकी है";

  @override
  String get dose1 => "डोज़ 1";

  @override
  String get dose2 => "डोज़ 2";

  @override
  String get dose3 => "डोज़ 3";

  @override
  String get howManyDoseTaken => "आपने कितने डोज़ लिए हैं?";

  @override
  String get yes => "हाँ";

  @override
  String get no => "नहीं";

  @override
  String get gottonYourselfVaccinated =>
      "क्या आपने सर्वाइकल कैंसर से बचाव के लिए टीका लगवाया है?";

  @override
  String get lastPeriodDay => "आपकी पिछली पीरियड की तारीख";

  @override
  String get unusualPeriodDescription =>
      "आपकी पीरियड् अवधि असामान्य प्रतीत हो रही है। आमतौर पर, पीरियड्स 2 से 7 दिनों तक रहते हैं। यदि आपकी अवधि लगातार इस सीमा से बाहर रहती है, तो हम सुझाव देते हैं कि आप किसी डाॅक्टर संपर्क करें।";

  @override
  String get unusualPeriod => "असमान्य मासिक अवधि";

  @override
  String get periodLengthDiff => "औसत पीरियड की अवधि (दिन)";

  @override
  String get unusualCycleDescription =>
      "हमने देखा कि आपका मासिक चक्र असामान्य लग रहा है। सामान्य अवधि 21 से 35 दिनों के बीच होती है। यदि आपका चक्र लगातार इस सीमा के बाहर है, तो हम आपको सलाह देते हैं कि डॉक्टर से संपर्क करें।";
  @override
  String get unusualCycle => "असमान्य पीरियड अवधि";

  @override
  String get cycleLengthDiff => "दो पीरियडस के बीच का अंतर";

  @override
  String get helpUsLevelUp => "आपके हैल्थ को बेहतर समझने में मदद करें।";

  @override
  String get quickSurveyTime => "यो! फ़ास्ट सर्वे करें।";

  @override
  String get akeleHaiTohKya => "अकेले हैं तो क्या ग़म है?";

  @override
  String get wohHaiKahan => "वो है कहाँ";

  @override
  String get yourJourneyInCandles => "आपका जन्मदिन?";

  @override
  String get yourJourneyDescription =>
      "आपकी जन्म तिथि के आधार पर हम आपके लिए ऐप को बेहतर बना सकते हैं!";

  @override
  String get openForSurprises => "अन्य";

  @override
  String get typeHere => "यहाँ टाइप करें";

  @override
  String get neowNaamSunaHoga => "नाम तो सुना ही होगा";

  @override
  String get getStarted => "शुरू करें";

  @override
  String get helpUsPersonaliseyourExp =>
      "आपके अनुभव को व्यक्तिगत बनाने में मदद करने के लिए कुछ प्रश्नों का उत्तर दें";

  @override
  String get letUsknowYouBetter => "हमें आपको और बेहतर जानने दे";

  @override
  String get whereAreYouFrom => "आप कहाँ से हैं?";

  @override
  String get tcSubtitle =>
      "यदि आपकी आयु 16 वर्ष से कम है, तो कृपया अपने माता-पिता/अभिभावक से अपना NeoW खाता सेट करने में सहायता लेने का अनुरोध करें। NeoW ऐप का उपयोग करने के लिए उनकी अनुमति आवश्यक है।";

  @override
  String get tcTitle =>
      "नीचे दिए गए बॉक्स पर क्लिक करके, आप हमारी शर्तों और प्राइवेसी पॉलिसी स्वीकार करते हैं।";

  @override
  String get continueText => 'जारी रखें';
  @override
  String get enterPhoneNumber => 'अपना फ़ोन नंबर दर्ज करें';

  @override
  String get optionFitness => "फिटनेसप्रेमी";

  @override
  String get optionFitnessSubtitle => "स्वास्थ्य के बारे में जानने के लिए";

  @override
  String get optionBuddy => "बडी";

  @override
  String get optionBuddySubtitle => "NeoW के स्वास्थ्य की निगरानी के लिए";

  @override
  String get optionNeowSubtitle => "मेरे स्वास्थ्य को समझने के लिए";

  @override
  String get optionNeow => "नियो/NeoW";

  @override
  String get appName => "नवेली";

  @override
  String get plEnterEmail => "कृपया ईमेल दर्ज करें।";

  @override
  String get plEnterEmailOrMobile => "कृपया ईमेल या मोबाइल नंबर दर्ज करें।";

  @override
  String get plEnterValidEmail => "कृपया वैध ईमेल पता दर्ज करें।";

  @override
  String get noInternet => "कोई इंटरनेट सेवा नहीं।";

  @override
  String get doYouKnow => "क्या आप जानते हैं?";

  @override
  String get update => "अपडेट";

  @override
  String get here => "यहाँ";

  @override
  String get letKnowYou => "आइये आपको बेहतर जानते हैं!";

  @override
  String get enterYourName => "आपका नाम";

  @override
  String get plSelectYourGender => "कृपया अपना लिंग चुनें";

  @override
  String get plEnterName => "कृपया आपका नाम डाले";

  @override
  String get nutrition => "पोषण";

  @override
  String get download => "डाउनलोड पीडीऍफ़";

  @override
  String get reports => "रिपोर्ट्स";

  @override
  String get askYourQuestion => "अपना सवाल पूछें";

  @override
  String get queOfDay => "आज का प्रश्न";

  @override
  String get plWriteQue => "कृपया अपना सवाल लिखें";

  @override
  String get plSelectYourMedicine => "कृपया अपनी दवाओं का चयन करें";

  @override
  String get plSelectTs => "निृपया सेवा की शर्तों को स्वीकार करें।";

  @override
  String get plSelectPrivacy => "कृपया गोपनीयता नीति स्वीकार करें";

  @override
  String get ailments => "रोग";

  @override
  String get plSelectYourRelation => "कृपया अपनी संबंध स्थिति चुनें:";

  @override
  String get plEnterMobile => "कृपया मोबाइल नंबर दर्ज करें.";

  @override
  String get plSelectSleepTime => "कृपया अपने सोने का समय चुनें";

  @override
  String get plWakeUpSleepTime => "कृपया अपने जागने का समय चुनें";

  @override
  String get plFeelAnswer => "कृपया सभी प्रश्नों के उत्तर महसूस करें";

  @override
  String get plSelectMedicine => "कृपया दवा का चयन करें।";

  @override
  String get plSelectAilment => "कृपया बीमारी का चयन करें।";

  @override
  String get plAddComment => "कृपया अपना मंतव्य दें ।";

  @override
  String get plEnterHamAapkeKon => "कृपया अपने रिश्ते की जानकारी दें।";

  @override
  String get plEnterAge => "कृपया आयु चुनें";

  @override
  String get selectOption => "( सही विकल्प चुनें।)";

  @override
  String get like => "पसंद";

  @override
  String get dislike => "नापसन्द";

  @override
  String get plEnterHeight => "कृपया लंबाई दर्ज करें।";

  @override
  String get plSelectWeight => "कृपया वज़न चुनें";

  @override
  String get plSelectPreviousPeriodDate =>
      "कृपया अपने पिछले मासिक धर्म  की तारीख दर्ज करें।";

  @override
  String get userDataSyncFailed => "उपयोगकर्ता डेटा समन्वयन विफल";

  @override
  String get plSelectYourBday => "कृपया अपनी जन्म तिथि का चयन करें।";

  @override
  String get plEnterValidOtp => "कृपया वैध ओटीपी दर्ज करें";

  @override
  String get mythVsFacts => "मिथक बनाम सच्चाई";

  @override
  String get logYourSymptoms => "लक्षण दर्ज करें";

  @override
  String get womenInNews => "ख़बरों में NeoW";

  @override
  String get oops => "उफ़! कुछ गलत हो गया।";

  @override
  String get allAboutPeriods => "पीरियड्स";

  @override
  String get plEnter10DigitsMobile =>
      "कृपया 10 अंकों का मोबाइल नंबर दर्ज करें.";

  @override
  String get plSelectUserType => "कृपया उपयोगकर्ता का प्रकार चुनें।";

  @override
  String get plEnterPassword => "कृपया पासवर्ड दर्ज करें।";

  @override
  String get sleep => "नींद";

  @override
  String get pco => "PCO";

  @override
  String get pms => "PMS";

  @override
  String get share => "साझा करें";

  @override
  String get comment => "टिप्पणी";

  @override
  String get welcomeForum => "Neow's Forum में आपका स्वागत है";

  @override
  String get water => "पानी";

  @override
  String get follow => "अनुसरण करें";

  @override
  String get settings => "सेटिंग्स";

  @override
  String get profile => "प्रोफ़ाइल";

  @override
  String get welcomeToOurForum => "हमारे मंच में आपका स्वागत है।";

  @override
  String get kg => "किग्रा";

  @override
  String get hamAapkeKon => "हम आपके हैं कौन ?";

  @override
  String get naveliUniqueId => "नवेली की अनूठी पहचान";

  @override
  String get gender => "लिंग";

  @override
  String get secretDiary => "गुप्त डायरी";

  @override
  String get healthMix => "हेल्थ मिक्स";

  @override
  String get reminder => "स्मरण-पत्र";

  @override
  String get hisutism => "लोमश हिर्सुटिज़्म";

  @override
  String get dataNotFound => "डेटा नहीं मिला";

  @override
  String get contactNoNotAvailable => "संपर्क संख्या उपलब्ध नहीं है|";

  @override
  String get locationService => 'स्थान सेवा';

  @override
  String get waterReminder => 'पानी अनुस्मारक';

  @override
  String get logYourWeight => 'अपना वजन बताएं';

  @override
  String get logYourSleepHour => 'अपनी नींद के घंटे बताएं';

  @override
  String get width => 'चौड़ाई';

  @override
  String get areYouSure => 'क्या आपको यकीन है?';

  @override
  String get thisActionPermanentlyDelete =>
      'यह कार्रवाई इस एल्बम को स्थायी रूप से हटा देगी।';

  @override
  String get min => 'मिनट';

  @override
  String get height => 'ऊंचाई';

  @override
  String get track => 'ट्रैक करें';

  @override
  String get age => 'आयु';

  @override
  String get locationPermission => 'स्थान अनुमति';

  @override
  String get plEnableLocationService =>
      'वर्तमान स्थान प्राप्त करने के लिए कृपया लोकेशन सर्विस को सक्षम करें।';

  @override
  String get plAllowLocationPermission =>
      'वर्तमान स्थान प्राप्त करने के लिए कृपया लोकेशन परमिशन दें।';

  @override
  String get enableService => 'सेवा को सक्षम करें';

  @override
  String get allowPermission => 'अनुमति दें';

  @override
  String get done => 'हो गया';

  @override
  String get online => "आप अब ऑनलाइन हैं।";

  @override
  String get periodsInformation => "मासिक धर्म सम्बंधित सूचना";

  @override
  String get superWomen => "सुपर महिलाएँ";

  @override
  String get offline => "आप अब ऑफ़लाइन हैं";

  @override
  String get login => "लोग इन करें";

  @override
  String get medication => "इलाज";

  @override
  String get signUp => "साइन अप करें";

  @override
  String get alreadyHave => "पहले से ही अकाउंट है? लॉग इन करें";

  @override
  String get dontHave => "अकाउंट नहीं है? साइन अप करें";

  @override
  String get forgotPassword => "पासवर्ड भूल गए";

  @override
  String get whatsYourGender => "आपका लिंग क्या है?";

  @override
  String get relationshipStatus => "आपकी संबंध स्थिति";

  @override
  String get yourJourney => "मोमबत्ती में आपका सफ़र?";

  @override
  String get selectDate => "तारीख़ चुनें";

  @override
  String get name => "नाम";

  @override
  String get other => "अन्य";

  @override
  String get enterOtherGender => "अन्य लिंग दर्ज करें";

  @override
  String get female => "महिला";

  @override
  String get or => "या";

  @override
  String get selectAny => "नीचे से कोई भी एक चुनें";

  @override
  String get whoAreYou => "आप इनमें से कौन है?";

  @override
  String get neowMe => "Neow";

  @override
  String get buddy => "दोस्त";

  @override
  String get cycleEnthu => "साइकिल उत्साही";

  @override
  String get emailOrPhone => "ई-मेल या फोन नंबर|";

  @override
  String get password => "पासवर्ड";

  @override
  String get welcomeToNewYou => "आपके नए रूप में आपका स्वागत है!";

  @override
  String get welcome =>
      "हम आपसे कुछ सवाल पूछेंगे ताकि हम आपके अनुभव को व्यक्तिगत बना सकें।";

  @override
  String get yoQuickSurvey =>
      "यह एप्लिकेशन को आपके अनुसार ढालने में मदद करेगा।";

  @override
  String get myDailyInsights => "मेरे दैनिक अंतर्दृष्टि - आज";

  @override
  String get yourFabulousName => "आपका शुभ नाम";

  @override
  String get neowmeName => "Neow नाम तो सुना ही होगा";

  @override
  String get sunaHoga => " सुना ही होगा";

  @override
  String get email => "ईमेल";

  @override
  String get phone => "फोन नंबर.";

  @override
  String get submit => "सेव करें";

  @override
  String get willAsk =>
      " हम आपसे कुछ सवाल पूछेंगे ताकि हम आपके अनुभव को व्यक्तिगत बना सकें।";

  @override
  String get resendOtp => "नए ओ टी पी के लिए अनुरोध करें";

  @override
  String get requestOtp => "नया ओटीपी का अनुरोध करें";

  @override
  String get seconds => "सेकंड";

  @override
  String get enterYourOtp => "मोबाइल पर प्राप्त ओ टी पी भरे";

  @override
  String get beforeWeGet => "शुरुआत करने से पहले";

  @override
  String get yatriGanDhyanDe => "नियम और शर्तें,\nयात्रीगण कृपया ध्यान दें";

  @override
  String get pleaseAsk =>
      "कृपया अपने माता-पिता या अभिभावक से अपने क्लू अकाउंट को स्थापित करने में मदद  लें।";

  @override
  String get asYouAre =>
      "चूँकि आप 16 वर्ष से कम उम्र के हैं, हमें कानूनी रूप से आपके माता-पिता या अभिभावक से निम्नलिखित जानकारियाँ पूछने की आवश्यकता है";

  @override
  String get theirPermission => "क्लू ऐप का उपयोग करने के लिए उनकी अनुमति।";

  @override
  String get theirHelp =>
      "आपकी गोपनीयता सेटिंग्स को स्थापित करने में उनकी मदद।";

  @override
  String get accept => "स्वीकार करें";

  @override
  String get next => "आगे बढ़ें";

  @override
  String get sleepNow => "अब सो जाएँ";

  @override
  String get apply => "लागू करें";

  @override
  String get quiz => "प्रश्नोत्तरी";

  @override
  String get knowYourBody => "अपने शरीर को जानो";

  @override
  String get myDashboard => "मेरा डैशबोर्ड";

  @override
  String get weight => "वजन";

  @override
  String get calculateBmi => "बीएमआई की गणना करें";

  @override
  String get bmiScore => "बीएमआई स्कोर";

  @override
  String get normal => "सामान्य";

  @override
  String get bmi => "बीएमआई";

  @override
  String get bmiCalculator => "बीएमआई कैलकुलेटर";

  @override
  String get youAndClue => "तुम और क्लू";

  @override
  String get wePromise =>
      "हम आपके डेटा को सुरक्षित और निजी रखने का वादा करते हैं। कृपया हमारी नीतियों को जानने के लिए थोड़ा समय निकालें।";

  @override
  String get iAgree => "मैं NeoW की नियम और शर्तों से सहमत हूँ।";

  @override
  String get termsOfServices => "";

  @override
  String get iHaveReadClue =>
      "मैं सहमत हूँ कि NeoW ऐप मुझे सूचनाएँ, अपडेट्स और महत्वपूर्ण जानकारी ईमेल के माध्यम से अवगत कराएगा।";

  @override
  String get privacyPolicy => "गोपनीयता नीति";

  @override
  String get iAgreeProcessing =>
      "मैं इस बात से सहमत हूँ कि ‘क्लू’ मेरे स्वास्थ्य डेटा को प्रोसेस करेगा जो मैं ऐप के साथ साझा करना चुनता हूँ, ताकि वे अपनी सेवा प्रदान कर सकें।";

  @override
  String get iShowedAbove =>
      "मैंने अपने माता-पिता/ अभिभावक से ऊपर उल्लिखित नीतियों को साझा किया। उन्होंने मुझे ‘क्लू’ का उपयोग करने एवं  ‘क्लू’ ऐप्प पर मेरे स्वास्थ्य डेटा को प्रोसेस कर सकने के लिए स्वीकृति प्रदान की है।";

  @override
  String get quickSurvey =>
      "अहा! त्वरित सर्वेक्षण का समय। हमें स्तर बढ़ाने में मदद करें।";

  @override
  String get averageCycle => "औसत मासिक धर्म की लम्बाई(दिनोमे)";

  @override
  String get whenDidYour => "आपकी पिछली मासिक धर्म कब शुरू हुई थी?";

  @override
  String get averagePeriod => "मासिक धर्म सामान्य अवधि (दिन)";

  @override
  String get letsSprinkle => "आइए मिलकर कुछ जादू बिखेरें";

  @override
  String get iDontRemember => "भूल गई सब कुछ, याद नहीं अब कुछ।";

  @override
  String get date => "तारीख";

  @override
  String get days => "दिन";

  @override
  String get getReminder =>
      "अपने मासिक धर्म को याद दिलाने के लिए रिमाइंडर सेट करें";

  @override
  String get stayYourPeriod => "अपनी मासिक धर्म के दौरान भी निर्बाध रहें!";

  @override
  String get nightReminder => "रात्रि में याद दिलाने का समय";

  @override
  String get cancel => "रद्द करें";

  @override
  String get delete => "मिटाएँ";

  @override
  String get ok => "ठीक है";

  @override
  String get setReminder => "रिमाइंडर सेट करें";

  @override
  String get mood => "मूड";

  @override
  String get plSelectState => "कृपया अपना राज्य चुनें!";

  @override
  String get plSelectCity => "कृपया अपना शहर चुनें!";

  @override
  String get male => "पुरुष";

  @override
  String get edit => "संपादन करना";

  @override
  String get accepted => "स्वीकृत";

  @override
  String get transgender => "ट्रांसजेंडर";

  @override
  String get otherPlSpec => "अन्य, कृपया निर्दिष्ट करें";

  @override
  String get solo => "सिंगल";

  @override
  String get tied => "संबंध में";

  @override
  String get sendRequest => "रिक्वेस्ट भेजे";

  @override
  String get openForSur => "अन्य";

  @override
  String get yourBDayHelp =>
      "(आपकी जन्मतिथि हमें आपके लिए ऐप तैयार करने में मदद करती है!)";

  @override
  String get numberOfDays => "दो पीरियड्स के बीच दिनों की संख्या";

  @override
  String get howLongDosePeriod => "तुम्हारा पीरियड कितने दिनों तक रहता है?";

  @override
  String get neowInNews => "ख़बरों में NeoW";

  @override
  String get quickQuestion => "अहम सवाल";

  @override
  String get periodMedication => "पीरियड दवा";

  @override
  String get deStress => "तनाव कम करें";

  @override
  String get healthMixLatest => "स्वास्थ्य मिश्रण - नवीनतम";

  @override
  String get latest => "नवीनतम";

  @override
  String get expertAdvice => "अनुभवी सलाह";

  @override
  String get cycleWisdom => "साइकिल ज्ञान";

  @override
  String get grooveWithNeow => "NeoW के साथ न्यू बनें।";

  @override
  String get testimonials => "टेस्टीमोनियल";

  @override
  String get funCorner => " फन कार्न";

  @override
  String get calebSpeaks => "सेलेब बोलता है";

  @override
  String get avgSleepTime => "औसत नींद का समय";

  @override
  String get empowHer => "सशक्ति";

  @override
  String get interest => "रुचि";

  @override
  String get dashboard => "डैशबोर्ड";

  @override
  String get aboutUs => "हमारे बारे में";

  @override
  String get help => "सहायता";

  @override
  String get rateUs => "रेट और रिव्यू करें";

  @override
  String get logout => "लॉग आउट";

  @override
  String get home => "होम";

  @override
  String get forum => "फोरम";

  @override
  String get flow => "रक्त प्रवाह";

  @override
  String get staining => "पीरियड्स स्टेन";

  @override
  String get low => "कम";

  @override
  String get medium => "सामान्य";

  @override
  String get high => "ज्यादा";

  @override
  String get clotSize => "रक्त थक्का का साइज़";

  @override
  String get small => "छोटा";

  @override
  String get accountAccess => "खाते तक पहुंच";

  @override
  String get yourNaveli => "आपकी नवेली";

  @override
  String get large => "बड़ा";

  @override
  String get pain => "दर्द";

  @override
  String get workingAbility => "कार्य करने की क्षमता";

  @override
  String get always => "हमेशा";

  @override
  String get almostAlways => "लगभग हमेशा";

  @override
  String get almostNever => "लगभग नहीं";

  @override
  String get none => "कोई नहीं";

  @override
  String get location => "दर्द के स्थान";

  @override
  String get periodCramps => "पीरियड्स का दर्द";

  @override
  String get noHurt => "कोई दर्द नहीं";

  @override
  String get hurtLittleBit => "थोड़ा सा दर्द";

  @override
  String get hurtMore => "सामान्य से ज्यादा दर्द";

  @override
  String get hurtWorst => "बहुत ज्यादा दर्द";

  @override
  String get collectionMethod => "आपका पीरियड प्रोडक्ट";

  @override
  String get sanitaryPads => "सैनिटरी पैड्स";

  @override
  String get cloth => "कपड़ा";

  @override
  String get tampons => "मेंस्ट्रुअल कप्स";

  @override
  String get cups => "मेंस्ट्रुअल कप्स";

  @override
  String get relaxed => "खुशनुमा";

  @override
  String get sad => "उदास";

  @override
  String get energy => "शारीरिक शक्ति";

  @override
  String get lively => "जीवंत";

  @override
  String get irritated => "चिढ़चिढ़ा";

  @override
  String get stress => "तनाव";

  @override
  String get moderate => "सामान्य";

  @override
  String get acne => "मुंहासे";

  @override
  String get minimal => "कम";

  @override
  String get rejected => "अस्वीकार कर दिया";

  @override
  String get severe => "बहुत ज़्यादा";

  @override
  String get add => "जोड़ना";

  @override
  String get lbs => "एलबीएस";

  @override
  String get cm => "सेमी";

  @override
  String get ft => "फुट";

  @override
  String get bedTime => "सोने का समय";

  @override
  String get wakeUpTime => "जागने का समय";

  @override
  String get sleepTime => "सोने का समय";

  @override
  String get hr => "कलाक";

  @override
  String get reminderFor => "रिमाइंडर फॉर";

  @override
  String get selectState => "राज्य चुनें";

  @override
  String get selectDistrict => "जिला चुनें";

  @override
  String get zodiac => "राशि";

  @override
  String get selectYourWeight => "अपना वजन चुनें";

  @override
  String get enterNaveliUid => "नवेली की यूनिक आईडी दर्ज करें";

  @override
  String get trackYourWeight =>
      "अपना वज़न ट्रैक करें और अपने लक्ष्य प्राप्त करें।";

  @override
  String get verificationFailed => "सत्यापन विफल रहा कृपया फिर से प्रयास करें!";

  @override
  String get newomeDescription =>
      "मैं ऐसा व्यक्ति हूं जिसे पीरियड्स आते हैं और मैं स्वस्थ रहते हुए अपने शरीर को बेहतर ढंग से समझना चाहता हूं।.";

  @override
  String get cycleDescription =>
      "मैं एक ऐसा व्यक्ति हूं जो पीरियड्स और समग्र स्वास्थ्य और कल्याण के बारे में अधिक जानना चाहता हूं।";

  @override
  String get buddyDescription =>
      "मैं एक साथी या अभिभावक हूं जो अपने अनूठे दोस्त कोड का उपयोग करके मेरे नियोम के स्वास्थ्य की निगरानी करना चाहता है।";

  @override
  String get alreadySentRequest =>
      "आप पहले ही किसी अन्य नवेली को अनुरोध भेज चुके हैं";

  @override
  String get keepTrackOfWater =>
      "अपने पानी के सेवन पर नज़र रखें और हाइड्रेटेड और स्वस्थ रहने के लिए रिमाइंडर सेट करें";

  @override
  String get freqOfChange => "प्रतिदिन पीरियड प्रोडक्ट बदलने की संख्या";

  @override
  String get neverMissADate =>
      "कभी भी डेट मिस न करें! आसानी से तारीखें, कार्यक्रम और कार्य निर्धारित करके सहज रूप से व्यवस्थित रहें।";

  @override
  String get aajMainUpar => "आज मैं उपर अस्मान नीचे";

  @override
  String get whatTimeDoGoBed => "आप आमतौर पर किस समय सोते हैं?";

  @override
  String get plEnterUid => "कृपया विशिष्ट आईडी दर्ज करें";

  @override
  String get plSlReminderDate => "कृपया अनुस्मारक तिथि चुनें";

  @override
  String get plSlReminderType => "कृपया अनुस्मारक प्रकार चुनें";

  @override
  String get plSlReminderFor => "कृपया इसके लिए अनुस्मारक दर्ज करें";

  @override
  String get whatTimeWakeUp => "आप आमतौर पर सुबह कितने बजे उठते हैं?";

  @override
  String get yeDukhKaahe => "ये दुख कहे खतम नहीं होता है";

  @override
  String get plSelectWeightType => "कृपया वजन का प्रकार चुनें";

  @override
  String get trackAndConquer =>
      "अपने रोगों को ट्रैक करें और उन्हें दूर करने की कोशिश करे !";

  @override
  String get monitorYourBmi =>
      "अपने सामग्रिक स्वास्थ्य और शारीरिक संरचना के अंदरूनी दर्शन के लिए अपना बीएमआई मॉनिटर करें।";

  @override
  String get howManyDays => "आप कितने दिनों तक गंभीर दर्द का अनुभव करते हैं?";

  @override
  String get effortlesslyTrack =>
      "अपनी दवा को बिना किसी प्रयास के ट्रैक करें! आसानी से अपनी प्रगति की निगरानी करने के लिए अनुस्मारक निर्धारित करें।";

  @override
  String get howManyTimesYou =>
      "आप रोजाना अपना पैड/पैंटी/कप/टैम्पन/अन्य कितनी बार बदलते हैं?";

  @override
  String get exploreTheHidden => "अपने शरीर के रहस्यों को जानें।";

  @override
  String get capacityToPerform =>
      "मासिक धर्म के दौरान कार्यों को प्रभावी रूप से करने की क्षमता";

  @override
  String get uncoveringTruth => "सत्य का उजागर और गलतफहमियों का समाधान";

  @override
  String get decodingPeriod => " पीरियड्स के बारे में पूरी जानकारी।";

  @override
  String get plSelectHirsutism => "कृपया सभी हारसुटिज्म!";

  @override
  String get leadingLadies => "अग्रणी महिलाएँ-: सुर्खियाँ बटोरने वाली महिलाएँ";

  @override
  String get questionOfDay => " आज का प्रश्न";

  @override
  String get periodPainCan =>
      "मासिक धर्म का दर्द पेट के निचले हिस्से, पीठ के निचले हिस्से, जांघों आदि सहित विभिन्न स्थानों पर हो सकता है। यह कितनी जगहों पर चोट पहुँचाता है?";

  @override
  String get underStandYourBody =>
      "अपने शरीर को बेहतर समझें: अपने मासिक धर्म के दौरान लक्षणों को ट्रैक करें.";

  @override
  String get ifYouHave =>
      "यदि आपके पास स्वास्थ्य से संबंधित प्रश्न हैं, तो हिचकिचाएं नहीं! हमारे विशेषज्ञ उत्तर देने के लिए यहां हैं। ";

  @override
  String get eatGlowRepeat => "हमारे विशेषज्ञों द्वारा दिए गए पोषण सुझाव";

  @override
  String get welcomeToNeow =>
      "नियोव के फोरम में आपका स्वागत है-हे नई महिलाएं! नियोव के फोरम में आपका स्वागत है। व्यावहारिक चर्चाओं में शामिल हों, समर्थन प्राप्त करें और अपने जीवन के हर पहलू में फलने-फूलने के लिए प्रेरित हों। एक साथ जुड़ने, बढ़ने और नारीत्व की यात्रा का जश्न मनाने के लिए हमारे साथ जुड़ें!";

  @override
  String get welcomeToSecret =>
      "सीक्रेट डायरी- सीक्रेट डायरी में आपका स्वागत है, यह आपके विचारों, सपनों और अवलोकन के लिए आपका निजी स्थान है। अपने आप को स्वतंत्रता से व्यक्त करें और आत्म-खोज की शक्ति को अनलॉक करें।";

  @override
  String get wesupport =>
      "हम सभी प्रकार की अभिव्यक्ति का समर्थन करते हैं। हालांकि, आपके बेहतर स्वास्थ्य के लिए हमें यह जानकारी चाहिए।";
  @override
  String get yourgender => "आपका जेंडर क्या है?";
  @override
  // TODO: implement reorderItemDown
  String get reorderItemDown => throw UnimplementedError();

  @override
  // TODO: implement reorderItemLeft
  String get reorderItemLeft => throw UnimplementedError();

  @override
  // TODO: implement reorderItemRight
  String get reorderItemRight => throw UnimplementedError();

  @override
  // TODO: implement reorderItemToEnd
  String get reorderItemToEnd => throw UnimplementedError();

  @override
  // TODO: implement reorderItemToStart
  String get reorderItemToStart => throw UnimplementedError();

  @override
  // TODO: implement reorderItemUp
  String get reorderItemUp => throw UnimplementedError();
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale(AppConstants.LANGUAGE_ENGLISH, ""),
      Locale(AppConstants.LANGUAGE_HINDI, ""),
    ];
  }

  LocaleListResolutionCallback listResolution(
      {Locale? fallback, bool withCountry = true}) {
    return (List<Locale>? locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback!, supported, withCountry);
      }
    };
  }

  Locale Function(Locale locale, Iterable<Locale> supported) resolution(
      {Locale? fallback, bool withCountry = true}) {
    return (Locale locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback!, supported, withCountry);
    };
  }

  @override
  Future<S> load(Locale locale) {
    final String? lang = getLang(locale);
    if (lang != null) {
      switch (lang) {
        case AppConstants.LANGUAGE_HINDI:
          S.current = $mr();
          return SynchronousFuture<S>(S.current!);
        case AppConstants.LANGUAGE_ENGLISH:
          S.current = const $en();
          return SynchronousFuture<S>(S.current!);
        default:
// NO-OP.
      }
    }
    S.current = const S();
    return SynchronousFuture<S>(S.current!);
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale, true);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;

  ///
  /// Internal method to resolve a locale from a list of locales.
  ///
  Locale _resolve(Locale? locale, Locale fallback, Iterable<Locale> supported,
      bool withCountry) {
    if (locale == null || !_isSupported(locale, withCountry)) {
      return fallback;
    }

    final Locale languageLocale = Locale(locale.languageCode, "");
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback;
      return fallbackLocale;
    }
  }

  ///
  /// Returns true if the specified locale is supported, false otherwise.
  ///
  bool _isSupported(Locale? locale, bool withCountry) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
// Language must always match both locales.
        if (supportedLocale.languageCode != locale.languageCode) {
          continue;
        }

// If country code matches, return this locale.
        if (supportedLocale.countryCode == locale.countryCode) {
          return true;
        }

// If no country requirement is requested, check if this locale has no country.
        if (true != withCountry &&
            (supportedLocale.countryCode == null ||
                supportedLocale.countryCode!.isEmpty)) {
          return true;
        }
      }
    }
    return false;
  }
}

String? getLang(Locale? l) => l == null
    ? null
    : l.countryCode != null && l.countryCode!.isEmpty
        ? l.languageCode
        : l.toString();
