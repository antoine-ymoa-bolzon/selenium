*** Settings ***
Documentation     This suite contains variable definitions.
Library       SeleniumLibrary
Resource    ../Ressources/variables.robot

*** Variables ***
${URL}                https://demoqa.com/
${PRODUCT}            Designing Evolvable
${AUTH}               Glenn Block
${ADRESSE}            books
${LOCBUT}             //button[@id]
${LOCFORM}            //form[@id=userForm]
&{LINKS}              ${PRODUCT}=${AUTH}
${LOC_TABLE}          //div[@class='rt-table'][@role='grid']
${LOC_SEARCH}         //input[@id='searchBox']
${LOC_LIGNE1}         //div[@class='rt-tr -odd']
${LOC_CELL}           //div[@role='gridcell']
${LOC_PRODUCT}        [position() = 2]
${LOC_AUTH}           [position() = 3]
${TYPE}               CHECKBOX
${KEY_CONF}           \\13
${WAITING}            2s
${TEXTE}              texte par défaut
${MASK}               False
${LOCCAPTCHA}         span[@id='captcha-id']
${SCROLL}             0


*** Keywords ***
Get Keyword
    [Documentation]    This keyword gets a keyword and logs it.
    [Arguments]    ${keyword}
    ${keyword}    Set Variable    ${keyword}
    Log    ${keyword}
    RETURN    ${keyword}


Into the specific Site
    Open Browser    ${URL}    browser=chrome
    Maximize Browser Window
    Sleep    ${WAITING}

I go to a specific Rubric    
...    [Arguments]    ${ADRESSE}
    Go To    ${URL}${ADRESSE}
    Sleep    ${WAITING}

I search a specific Product
    Wait Until Element Is Visible    ${LOC_SEARCH}    ${WAITING}
    Input Text    ${LOC_SEARCH}    ${PRODUCT}
    Press Key    ${LOC_SEARCH}    ${KEY_CONF}

I find the specific Product
    ${VERIF}=    Verify the Only Result
    IF    ${VERIF} == 'True'
        Log    OK
    END


Verify the Only Result
    Sleep    ${WAITING}
    ${RECUP1}=    Get Text    ${LOC_LIGNE1}${LOC_CELL}${LOC_PRODUCT}
    ${RECUP2}=    Get Text    ${LOC_LIGNE1}${LOC_CELL}${LOC_AUTH}
    
    Log    Récupération champ Livre: ${RECUP1}\nRécupération champ Auteur: ${RECUP2}\n

    ${REP1}=    Should Match Regexp    ${RECUP1}     ^${PRODUCT}
    ${REP2}=    Should Match Regexp    ${RECUP2}     ^${AUTH}
    
    ${REG1}=    Should Be Equal As Strings    ${REP1}       ${PRODUCT}
    ${REG2}=    Should Be Equal As Strings    ${REP2}       ${AUTH}

    RETURN  True

I click to the button       
...    [Arguments]    ${LOCBUT}    ${SCROLL}
    Execute Javascript    window.scrollBy(0, ${SCROLL})
    Wait Until Element Is Visible    ${LOCBUT}    ${WAITING}
    Click Button    ${LOCBUT}

I fill the form    
...    [Arguments]    ${LOCFORM}
    Wait Until Element Is Visible    ${LOCFORM}    ${WAITING}
    I fill an Input Text    //input[@id='firstname']    Johnny          False
    I fill an Input Text    //input[@id='lastname']     Biscotte        False
    I fill an Input Text    //input[@id='userName']     Jobi            False
    I fill an Input Text    //input[@id='password']     FlexBisc0tte    True

I confirm the captcha    
...    [Arguments]    ${LOCCAPTCHA}    ${TYPE}    ${SCROLL}
    Execute Javascript    window.scrollBy(0, ${SCROLL})
    #Wait Until Element Is Visible   ${LOCCAPTCHA}    ${WAITING}
    
    IF    '$TYPE == CHECKBOX'
        I click to the button    ${LOCCAPTCHA}    0
    ELSE
        Log    Type de Captcha non pris en charge
    END
    


I go back
    Go Back

The username is still present
    Log    verif du username

I fill an Input Text 
...    [Arguments]    ${LOCINPUT}    ${TEXTE}    ${MASK}
    Wait Until Element Is Visible    ${LOCINPUT}    ${WAITING}
    IF    '$MASK == True'
        Input Password    ${LOCINPUT}    ${TEXTE}
    ELSE
        Input Text    ${LOCINPUT}    ${TEXTE}
    END
    

    


*** Comments ***

I Am On The Site KingJouet
    Open Browser    ${URL}    browser=chrome

I Accept The Cookies
    Click Element    locator=//button[@id='onetrust-accept-btn-handler']

I Search An Article
    Input Text    locator=//input[@id='algoliaSearch']    text=${PRODUCT}
    Press Key    locator=//input[@id='algoliaSearch']    key=ENTER

I See At Least One Article
    Pass Execution    message=OK

I Am On The Blocked Page
#Ouvrir la page d'accueil
    Open Browser    ${URL}    browser=chrome
    ${ELEMENT}=    Run Keyword And Return Status    Element Should Be Visible    locator=${LOCABOT}
    
    
    IF     ${ELEMENT}
        I Accept The Cookies
    ELSE
        I Contact Support Team
    END
    

I Contact Support Team
    Click Element    locator=//iframe//button[@id='show-human-auth']
    Input Text    locator=//textarea[@id='human-comment']     text=@{TEXTECOMPLET}

A Message Is Send To Support Team
    Pass Execution    OK




*** Comments ***