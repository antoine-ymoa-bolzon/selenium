*** Settings ***

Documentation     This suite contains variable definitions.
Library          OperatingSystem
Library          Process
Library          String
Library          AppiumLibrary
Library          subprocess

Resource         variables.robot

*** Variables ***
&{APP_X}    REMOTE=http://127.0.0.1:4723/wd/hub    
...         VERSION=15    
...         NAME=Android    
...         DEVICE=emulator-5554    
...         CALC_PCK=io.appium.android.apis    
...         CALC_ACT=io.appium.android.apis.ApiDemos    
...         CALC_PATH=C:\Users\Administrateur\AppData\Local\Android\Sdk\platform-tools\ApiDemos-debug.apk
...         AUTO_NAME=UiAutomator2
${REMOTE_URL}                     http://127.0.0.1:4723/wd/hub
${PLATFORM_VERSION}               15
${PLATFORM_NAME}                  Android
${DEVICE_NAME}                    emulator-5554
${CALCULATOR_APP_PACKAGE}         io.appium.android.apis
${AUTOMATION_NAME}                UiAutomator2
${CALCULATOR_APP_ACTIVITY}        io.appium.android.apis.ApiDemos
${CALCULATOR_APP_PATH}            C:\Users\Administrateur\AppData\Local\Android\Sdk\platform-tools\ApiDemos-debug.apk

${EL_PASO}          C:\\Users\\Administrateur\\AppData\\Local\\Android\\Sdk\\platform-tools\\adb.exe
${EMULATOR_NAME}    Pixel_7_API_35
${ADB_COMMAND}      ${EL_PASO}adb devices
${START_COMMAND}    emulator -avd ${EMULATOR_NAME}
${EMULATOR_PATH}   emulator
${ADB_PATH}    C:/Users/Administrateur/AppData/Local/Android/Sdk/platform-tools/
${TIMEOUT}    10s
${BUTTON_START_LABEL}    Start
${BUTTON_FORMAT_LABEL}    Set format string
${CHRONO_EVIDENCE}        0
#${EMULATOR_PATH}    C:/Users/Administrateur/AppData/Local/Android/Sdk/emulator/emulator.exe
#${EMULATOR_NAME}    Pixel_4_API_30


*** Keywords ***


The user launch ApiDemo App
    Open Application    ${APP_X.REMOTE}    
    ...    platformName=${APP_X.NAME}    
    ...    platformVersion=${APP_X.VERSION}    
    ...    deviceName=${APP_X.DEVICE}    
    ...    appPackage=${APP_X.CALC_PCK}    
    ...    appActivity=${APP_X.CALC_ACT}    
    ...    automationName=${APP_X.AUTO_NAME}

The user click on views rubric
    Wait Until Element Is Visible    //android.widget.TextView[@text="Views"]    ${TIMEOUT}
    Click Element    //android.widget.TextView[@text="Views"]

The user click on specific rubric VANILLA
    [Arguments]    ${RUBRIQUE}
    Wait Until Element Is Visible    //android.widget.TextView[@text="${RUBRIQUE}"]    ${TIMEOUT}
    Click Element    //android.widget.TextView[@text="${RUBRIQUE}"]

The user click on specific rubric
    [Arguments]    ${RUBRIQUE}
    ${SCROLL_ATTEMPTS}=    Set Variable    5  # Nombre maximum de tentatives de scroll
    ${FOUND}=    Set Variable    False    #si l'élément est trouvé, par défaut non

    FOR    ${i}    IN RANGE    ${SCROLL_ATTEMPTS}
        #chercher l'élément, mais sans faire planter le test s'il n'est pas trouvé
        Run Keyword And Ignore Error    Wait Until Element Is Visible    //android.widget.TextView[@text="${RUBRIQUE}"]    ${TIMEOUT}
        ${ELEMENT_PRESENT}=    Run Keyword And Return Status    Element Should Be Visible    //android.widget.TextView[@text="${RUBRIQUE}"]
        
        IF    ${ELEMENT_PRESENT}
            Click Element    //android.widget.TextView[@text="${RUBRIQUE}"]
            ${FOUND}=    Set Variable    True
            BREAK
        ELSE
            Log    Scrolling down to find ${RUBRIQUE} (Attempt ${i+1}/${SCROLL_ATTEMPTS})
            Swipe    500    1500    500    500    500
        END
    END

    #Si jamais élément toujours pas trouvé, ça plante
    Run Keyword If    not ${FOUND}    Fail    Could not find rubric: ${RUBRIQUE} after scrolling


The user click on animations rubric
    Wait Until Element Is Visible    //android.widget.TextView[@text="Animation"]    ${TIMEOUT}
    Click Element    //android.widget.TextView[@text="Animation"]

The user click on push rubric
    Wait Until Element Is Visible    //android.widget.TextView[@text="Push"]    ${TIMEOUT}
    Click Element    //android.widget.TextView[@text="Push"]

The user select specific option
    [Arguments]    ${OPTION}
    #cliquer sur la liste déroulante (spinner)
    Wait Until Element Is Visible    //android.widget.Spinner[@resource-id='io.appium.android.apis:id/spinner']    ${TIMEOUT}
    Click Element    //android.widget.Spinner[@resource-id='io.appium.android.apis:id/spinner']

    #cliquer sur l'option choisie
    Wait Until Element Is Visible    //android.widget.CheckedTextView[@text="${OPTION}"]    ${TIMEOUT}
    Click Element    //android.widget.CheckedTextView[@text="${OPTION}"]


The user can see some messages
    [Arguments]    @{TEXTS}

    FOR    ${index}    IN RANGE    3
        Wait Until Element Is Visible    //android.widget.TextView[@content-desc="${TEXTS[${index}]}"]    ${TIMEOUT}
        ${text}=    Get Text     //android.widget.TextView[@content-desc="${TEXTS[${index}]}"]    text
        
        Log    ${text}
        Run Keyword If    '${text}' == '${TEXTS}[0]'    Log    Text is correct: ${TEXTS}[0]
        Run Keyword If    '${text}' == '${TEXTS}[1]'    Log    Text is correct: ${TEXTS}[1]
        Run Keyword If    '${text}' == '${TEXTS}[2]'    Log    Text is correct: ${TEXTS}[2]
        Run Keyword If    '${text}' == '${TEXTS}[3]'    Log    Text is correct: ${TEXTS}[3]
    END

The user click the button
    [Arguments]    ${BUTTON_START_LABEL}
    #Pour cliquer sur un bouton (widget.button) dont le texte serait égal à l'argument
    Wait Until Element Is Visible    //android.widget.Button[@text="${BUTTON_START_LABEL}"]    ${TIMEOUT}
    Click Element    //android.widget.Button[@text="${BUTTON_START_LABEL}"]

The user start the chronometer
    #Cliquer sur le Bouton Start
    The user click the button    ${BUTTON_START_LABEL}
    Sleep    1s
    ${CHRONO_EVIDENCE}=    Get Text    io.appium.android.apis:id/chronometer

The user change the format
    #Cliquer sur un bouton pour changer le format
    The user click the button    ${BUTTON_FORMAT_LABEL}

The chronometer is still running
    #Vérifier que le chrono continue de défiler malgré le clic pour formater
    Sleep    1s
    ${CHRONO_DELTA}=    Get Text    io.appium.android.apis:id/chronometer
    #Comparer la valeur récupérée là avec celle récupérée précedemment (dans le start)
    #Si les valeurs ne sont pas égales c'est que le chrono continue de défiler
    ${DIFF}=    Should Not Be Equal As Strings    ${CHRONO_DELTA}    ${CHRONO_EVIDENCE}
    Run Keyword If    ${DIFF}    Log    The Chrono is still running
    

The user implement a specific value to the slider
    [Arguments]    ${VALUE}
    #implémenter une valeur dans un slider
    Wait Until Element Is Visible    //android.widget.SeekBar[@resource-id="io.appium.android.apis:id/seek"]    ${TIMEOUT}
    Move SeekBar To Value    ${VALUE}    //android.widget.SeekBar[@resource-id="io.appium.android.apis:id/seek"]

Move SeekBar To Value2
    [Arguments]    ${TARGET_VALUE}    ${TARGET_ELEMENT}
    
    ${ELEMENT}=    Get WebElement    ${TARGET_ELEMENT}
    
    ${BOUNDS}=    Get Element Attribute    ${ELEMENT}    bounds
    ${START_X}=    Evaluate    ${BOUNDS}.split("[")[1].split(",")[0]    # Coordonnée X du début
    ${END_X}=    Evaluate    ${BOUNDS}.split("][")[1].split(",")[0]    # Coordonnée X de fin
    ${Y}=    Evaluate    ${BOUNDS}.split(",")[1].split("]")[0]    # Coordonnée Y

    ${START_X}=    Convert To Integer    ${START_X}
    ${END_X}=    Convert To Integer    ${END_X}
    ${Y}=    Convert To Integer    ${Y}

    ${RANGE}=    Evaluate    ${END_X} - ${START_X}
    ${PERCENTAGE}=    Evaluate    float(${TARGET_VALUE}) / 100
    ${NEW_X}=    Evaluate    ${START_X} + (${RANGE} * ${PERCENTAGE})

    Swipe    ${START_X}    ${Y}    ${NEW_X}    ${Y}    500

Move SeekBar To Value3
    [Arguments]    ${TARGET_VALUE}    ${TARGET_ELEMENT}

    ${ELEMENT}=    Get WebElement    ${TARGET_ELEMENT}
    ${BOUNDS}=    Get Element Attribute    ${ELEMENT}    bounds

    # Extraction des coordonnées avec une regex
    ${MATCHES}=    Get Regexp Matches    ${BOUNDS}    \\d+    # Extrait tous les nombres

    ${START_X}=    Set Variable    ${MATCHES}[0]
    ${START_Y}=    Set Variable    ${MATCHES}[1]
    ${END_X}=      Set Variable    ${MATCHES}[2]
    ${END_Y}=      Set Variable    ${MATCHES}[3]

    ${START_X}=    Convert To Integer    ${START_X}
    ${END_X}=      Convert To Integer    ${END_X}
    ${Y}=          Convert To Integer    ${START_Y}    # Utilisation du Y du début

    ${RANGE}=      Evaluate    ${END_X} - ${START_X}
    ${PERCENTAGE}=     Evaluate    float(${TARGET_VALUE}) / 100
    ${NEW_X}=      Evaluate    ${START_X} + (${RANGE} * ${PERCENTAGE})

    Swipe    ${START_X}    ${Y}    ${NEW_X}    ${Y}    500

Move SeekBar To Value
    [Arguments]    ${TARGET_VALUE}    ${TARGET_ELEMENT}
    #En attendant de pouvoir récupérer les coordonnées de manière plus dynamique
    Swipe    498    313    920    0    500

The implemented value is clearly visible
    [Arguments]    ${VALUE}

    Wait Until Element Is Visible    io.appium.android.apis:id/progress    ${TIMEOUT}
    ${VAL_REMONTEE}=    Get Text    io.appium.android.apis:id/progress
    ${VERIF}=    Should Be Equal As Strings    ${VALUE} from touch=true    ${VAL_REMONTEE}
