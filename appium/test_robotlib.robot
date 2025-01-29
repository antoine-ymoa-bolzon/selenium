*** Settings ***
Library          AppiumLibrary
Resource         resources/keywords.robot

*** Variables ***



&{APP_X}    REMOTE=http://127.0.0.1:4723/wd/hub    VERSION=15    NAME=Android    DEVICE=emulator-5554    CALC_PCK=com.google.android.calculator    CALC_ACT=com.android.calculator2.Calculator    CALC_PATH=C:\Users\Administrateur\AppData\Local\Android\Sdk\platform-tools\com.google.android.calculator_8.4.apk    AUTO_NAME=UiAutomator2



*** Test Cases ***
Scenario Faire des Trucs sur une App
    given Launch an App
    when I do a thing
    then A thing was doing

Scenario Play With AppDemo
    given Launch an App 


*** Comments ***
1. Lancement et vérification de l'écran d'accueil
Test : Vérifier que l'application se lance correctement et que l'écran d'accueil est affiché.
 
Étapes :
Lancer l'application.
Vérifier la présence du logo API Demos
Vérifier que le menu principal est accessible.
 
 
2. Interaction avec le menu 'Views'
Test : Vérifier la navigation dans le menu Views et l'ouverture de sous-sections. Cliquer sur buttons et mettre le boutton en Off
 
Étapes :
Cliquer sur Views dans le menu principal.
Vérifier l'accès aux sous-sections comme Expandable Lists, Date Widgets, etc.
Ouvrir custom adapter et vérifier que chaque champs a bien tout les noms.
Exemple : People names = Arnold / Barry / Chuck / David
 
 
3. Navigation dans Expandable Lists
Test : Vérifier l'accès et l'interaction avec la fonctionnalité Expandable Lists.
 
Étapes :
Cliquer sur Expandable Lists.
Ouvrir la section 1. Custom Adapter.
Vérifier l'expandabilité des éléments.
Effectuer une interaction avec un élément de la liste.
 
 
4. Utilisation du Date Widget
Test : Tester l'interaction avec le widget de date. # Vérifier à chaque fois
Dans le dialog :
 
Change the date > 04/07/2003 
change the time > 11:47 PM
Change the time spinner > 04:39 PM
 
Et dans le Inline
 
changer la date avec le clavier et mettre 12:12 AM
    