*** Settings ***
Documentation     This suite contains alias correspondance.
Library        Collections
Library        SeleniumLibrary
Resource    ../Ressources/variables.robot

#Le pourquoi du comment
#Bib Collections pour récupérer les méthode de récupération des dictionnaires

*** Variables ***
&{ALIASES}=    Etant=Given    Quand=When    Alors=Then

*** Keywords ***
Get Alias
    [Arguments]    ${alias}
    ${correspondance}=  Get From Dictionary    dictionary=${ALIASES}    key=${alias}
    RETURN    ${correspondance}


Etant
    [Documentation]    Alias pour Given
    Get Alias    Etant

Quand
    [Documentation]    Alias pour When
    Get Alias    Quand

Alors
    [Documentation]    Alias pour Then
    Get Alias    Alors

