*** Settings ***
Library          AppiumLibrary
Resource         resources/keywords.robot

*** Variables ***

@{STRINGS_TO_FIND}    Freedom    is nothing else but    a chance to be better.    — Albert Camus
${SEEKBAR_VALUE}    88

*** Test Cases ***
Scenario see some animated messages
    Given The user launch ApiDemo App
    When The user click on specific rubric  Views
    And The user click on specific rubric  Animation
    And The user click on specific rubric  Push
    And The user select specific option    Hyperspace
    Then The user can see some messages     @{STRINGS_TO_FIND}


Scenario play with chronometer
    Given The user launch ApiDemo App
    When The user click on specific rubric  Views
    And The user click on specific rubric    Chronometer
    And The user start the chronometer
    And The user change the format
    Then The chronometer is still running

Scenario slide the bar:! 
    Given The user launch ApiDemo App
    When The user click on specific rubric  Views
    And The user click on specific rubric    Seek Bar
    And The user implement a specific value to the slider    ${SEEKBAR_VALUE} 
    Then The implemented value is clearly visible    ${SEEKBAR_VALUE}

*** Comments ***

Scenario contextual interface
    Given The user launch ApiDemo App
    When The user click on specific rubric  Views
    And The user click on specific rubric  Secure View
    And click to to the button    pop toast
    And click to to the button    Don't click!
    And click to to the button    pop toast
    And click to to the button    Don't click!
    Then The user should see the first error message

Scenario the rosbiff alignement
    Given The user launch ApiDemo App
    When The user click on specific rubric  Views
    And The user click on specific rubric    Splitting touches
    And slide the left column to see Leicester
    And slide the right column to see Wigmore
    Then the 2 cities are visibly on the same line

Scenario the blue balls
    Given The user launch ApiDemo App
    When The user click on specific rubric  Animations
    And The user click on specific rubric  Loading
    And click to to the button    Run
    Then the 4th ball have is color 
    

*** Comments ***
Ouvrez l’application ApiDemo
 
View animation push > Sélectionne hyperspace et retranscrit les messages affichés 
 
Ensuite chronometer commencez le et changer le format, assurez vous que le format a changer mais que le chronomètre tourne encore
 
Seek bar mettez la à 88
 
Ensuite secure view 
 
cliquez sur pop toast et cliquez sur don’t click! et fait en sorte de t’assurer que tu reviens au 1er message d’erreur 
 
Splitting touches across views 
et fait en sorte que Leicester et Wigmore sont alignés
 
Animation / Loading
 
Assure toi que la 4ème balle change de couleur
    