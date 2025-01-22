from sikuli import *
import time
#######################################################
#Launch WebBrowser Chrome
pathimg = "../src/test_demoqa/"
click(pathimg+"raccourci_google.png")



#######################################################
#Go to DemoQA.com
site = "demoQA"


wait(pathimg+"logo_google.png", 2)

if exists(pathimg+"google_barre_recherche_2.png"):
    click(pathimg+"google_barre_recherche_2.png")
elif exists(pathimg+"google_barre_recherche_1.png"):
    click(pathimg+"google_barre_recherche_1.png")
elif exists(pathimg+"google_barre_recherche_3.png"):
    click(pathimg+"google_barre_recherche_3.png")
elif exists(pathimg+"google_nouvel_onglet.png"):
    click(pathimg+"google_nouvel_onglet.png")
else:
    click(pathimg+"google_nouvel_onglet_2.png")


type("https://demoqa.com")
type(Key.ENTER)
#######################################################
#Scenario1: Check some boxes
#######################################################
scenario = "sc1_cocherCheckbox"

#######################################################
#Navigate to Elements/Checkbox
wait(pathimg+"logo_demoqa.png",2)

if exists(pathimg+"rubrique_elements.png"):
    click(pathimg+"rubrique_elements.png")
    wait(pathimg+"rubrique_checkbox.png", 2)
    click(pathimg+"rubrique_checkbox.png")
elif exists(pathimg+"index_rubrique_elements.png"):
    click(pathimg+"index_rubrique_elements.png")
    wait(pathimg+"rubrique_checkbox.png", 2)
    click(pathimg+"rubrique_checkbox.png")
else:
    click(pathimg+"url_alim_dns_resolu.png")
    type("https://demoqa.com/checkbox")
    type(Key.ENTER)
    wait(pathimg+"rubrique_checkbox.png", 4)


    click(pathimg+"rubrique_checkbox.png")

#######################################################
#Verify the presence of the boxes to check

#wait("presence_input_checkboxes.png",3)

if exists(pathimg+"checkbox_home.png"):
    click(pathimg+"checkbox_home.png")
if exists(pathimg+"expand_large.png"):
    click(pathimg+"expand_large.png")

#wait("presence_arborescence.png",3)



#######################################################
#Check the (targeted) boxes

if exists(pathimg+"office_checkbox_checked.png"):
    click(pathimg+"office_checkbox_checked.png")
else:
    Mouse.wheel(WHEEL_DOWN, 4)
    wait(pathimg+"office_checkbox_checked.png", 2)
    click(pathimg+"office_checkbox_checked.png")



if exists(pathimg+"excel_checkbox_checked.png"):
    click(pathimg+"excel_checkbox_checked.png")
else:
    Mouse.wheel(WHEEL_DOWN, 4)
    wait(pathimg+"excel_checkbox_checked.png", 2)
    click(pathimg+"excel_checkbox_checked.png")



#######################################################      
#Verifying checking of the (targeted) boxes: Preuve de Test

if not exists(pathimg+"excel_checkbox_unchecked.png"):
    click(pathimg+"excel_checkbox_unchecked.png")
if not exists(pathimg+"office_checkbox_unchecked.png"):
    click(pathimg+"office_checkbox_unchecked.png")

screen = Screen()
dossier_sauvegarde = "C:/Users/Administrateur/Desktop/Sikuli_IDE/src/preuvesTest/" + site + "/" + scenario
#Vérification de l'existence du répertoire de sauvegarde
if not os.path.exists(dossier_sauvegarde):
    os.makedirs(dossier_sauvegarde)

#Générer un nom basé sur le temps pour garantir l'unicité
nom_image = site + "_" + scenario + "_" + time.strftime("%Y%m%d_%H%M%S")
# Chemin complet pour enregistrer l'image
chemin_complet = dossier_sauvegarde + nom_image + ".png"

#Capturer l'écran et enregistrer l'image sous le nom généré
preuveTest = screen.capture(screen.getBounds())
preuveTest.save(dossier_sauvegarde,nom_image)

#Afficher un message avec le nom de l'image
print(site + "\nPreuve de test: " + scenario + ": \n" + chemin_complet + "\n\n")


#######################################################
#Scenario2: Faire des trucs
#######################################################
scenario = "sc2_faireDesTrucs"

if exists("google_nouvel_onglet_2.png"):
    click("google_nouvel_onglet_2-1.png")
elif exists("google_nouvel_onglet.png"):
    click("google_nouvel_onglet-1.png")

type("https://google.com")
type(Key.ENTER)

#Vérifier Google
if exists("logo_google.png"):
    if exists("google_vraie_barre_recherche-1.png"):
        click("google_vraie_barre_recherche.png")
        type("Mario Brosse")
        type(Key.ENTER)
    elif exists("google_vraie_barre_recherche2.png"):
        click("google_vraie_barre_recherche2-1.png")
        type("Mario Brosse")
        type(Key.ENTER)

dossier_sauvegarde = "C:/Users/Administrateur/Desktop/Sikuli_IDE/src/preuvesTest/" + site + "/" + scenario
#Vérification de l'existence du répertoire de sauvegarde
if not os.path.exists(dossier_sauvegarde):
    os.makedirs(dossier_sauvegarde)

#Générer un nom basé sur le temps pour garantir l'unicité
nom_image = site + "_" + scenario + "_" + time.strftime("%Y%m%d_%H%M%S")
# Chemin complet pour enregistrer l'image
chemin_complet = dossier_sauvegarde + nom_image + ".png"

#Capturer l'écran et enregistrer l'image sous le nom généré
preuveTest = screen.capture(screen.getBounds())
preuveTest.save(dossier_sauvegarde,nom_image)

#Afficher un message avec le nom de l'image
print(site + "\nPreuve de test: " + scenario + ": \n" + chemin_complet + "\n\n")
