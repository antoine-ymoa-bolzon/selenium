*** Settings ***
Documentation     This suite contains Tests Scenarii.
Library       SeleniumLibrary
Resource    ../Ressources/keywords_affined.robot
Resource    ../Ressources/correspondances.robot

*** Variables ***
${URL2}         books
${URL3}         selectable
${URL4}         date-picker
${URL5}         alerts
${URL6}         checkbox
${LOGIN}        //button[@id='login']
${NEWUSER}      //button[@id='newUser']
${FORMNEWUSER}      //form[@id=userForm]
${REGISTER}     //button[@id='register']
${CAPTCHA}      //span[@id='recaptcha-anchor' and contains(text(), "I'm not a robot")]
#${CAPTCHA}        //div[@class='recaptcha-checkbox-checkmark'][@role='presentation']
                


*** Test Cases ***

Scenario : Search and Find a product
#DemoQA Rechercher Designing Evolvable dans les livres
    Given Into the specific Site
    When I go to a specific Rubric    ${URL2}
    And I search a specific Product
    Then I find the specific Product


Scenario : Capharnaum
    Given Into the specific Site
    When I go to a specific Rubric    ${URL2}
    And I click to the button       ${LOGIN}    0
    And I click to the button    ${NEWUSER}    400
    #And I fill the form       ${FORMNEWUSER}
    And I confirm the captcha    ${CAPTCHA}    CHECKBOX    400
    And I click to the button       ${REGISTER}    0
    And I go back
    Then The username is still present

    When I go to a specific Rubric    ${URL3}
    #sélectionner ...

    When I go to a specific Rubric    ${URL4}
    #truc des dates

    When I go to a specific Rubric    ${URL5}
    #cliquer un peu partout

    When I go to a specific Rubric    ${URL6}

*** Comments ***
Enoncé exo DemoQA:
Aller sur book store application 
Rechercher Designing Evolvable et s'assurer que l'auteur est bien Glenn Block et al.
Sur la même page, cliquez sur login > register > revenir sur la page de départ et s'assurer que dans le user name il y a bien le username
Ensuite, cliquer sur interactions > Selectable et sélectionner Morbi leo risus et Cras justo odio 
Ensuite l'onglet Grid à coté, selectionner le 591
retourner sur list et assurez vous que les deux éléments sont toujours sélectionner
 
Ensuite sur Widgets, date picker > dans date and time , sélectionner le 5 novembre 2035 à 23h45
 
Dans l'onglet alerts, frame & Windows > aller sur alerts et cliquer sur chaque bouton avec les instructions demander et assurez vous que l'action est correct (ex : je vérifie que sur le bouton avec la valeur "On button click, prompt box will appear" il y a bien le nom affiché en vert)
 
ensuite refaite l'étape des checkbox (je sais que vous aimez) 
Eléments > Check box > Sélectionner tous les éléments SAUF Office et Excel file.doc