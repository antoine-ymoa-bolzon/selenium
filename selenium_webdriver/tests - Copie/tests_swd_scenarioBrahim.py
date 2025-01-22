import pytest
import pytest_bdd
from pytest_bdd import parsers

from selenium import webdriver
from selenium.webdriver.common.by import By
from pytest_bdd import scenario ,given, then ,when

from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.action_chains import ActionChains

import keyboard
import time



@pytest.fixture
def browser():
    driver = webdriver.Chrome()
    yield driver
    driver.quit()

def base():
    return 'https://demoqa.com/'

def url():

    page = {
        'elements':['textbox','checkbox','radio-button','webtables','buttons','links','broken','upload-download','dynamic-properties'], 
        'forms':['automation-practice-form'], 
        'alertsWindows':['browser-windows','alerts','frames','nestedframes','modal-dialogs'], 
        'widgets':['accordian','auto-complete','date-picker','slider','progress-bar','tabs','tool-tips','menu','select-menu'], 
        'interactions':['sortable','selectable','resizable','droppable','dragabble'], 
        'bookStoreApplication':['login','books','profile','swagger/']}
    
    return page


############################################################################################################
#Scénario 1 Checker des checkbox, sans cocher tout
############################################################################################################
@scenario('features/julienneDeLegume_demoQA.feature', 'The visitor can select some check options')   
def test_input_presence1():
    #vérifier que l'on est bien sur la bonne page
    #vérifier que l'on a bien la checkBox Home
    #vérifier que l'on a bien la pastille d'expand
    pass

@given('I am on the checkbox page')
def open_checkbox_page(browser):
    browser.maximize_window()
    browser.get(base() + url()['elements'][1])
    time.sleep(2)

@when('I check all the options')
def check_all_options(browser):
    browser.find_element(By.XPATH, "//span[@class='rct-checkbox']").click()
    time.sleep(2)
    browser.find_element(By.XPATH, "//button[@title='Expand all']").click()
    time.sleep(2)

@when('I uncheck some specific options')
def uncheck_some_options(browser):
    browser.execute_script("window.scrollTo(0, 400);")
    time.sleep(2)
    browser.find_element(By.XPATH, "//label[@for='tree-node-office']/span[@class='rct-checkbox']").click()
    time.sleep(2)
    browser.find_element(By.XPATH, "//label[@for='tree-node-excelFile']/span[@class='rct-checkbox']").click()
    time.sleep(2)


@then('All options are checked except some specific ones')
def verify_input_presence(browser):
    WebDriverWait(browser, 10).until(EC.presence_of_element_located((By.ID, 'result')))
    # Trouve la div avec l'id 'result'
    result_div = browser.find_element(By.ID, 'result')

    # Récupère tous les span avec la classe 'success' à l'intérieur de la div
    success_spans = result_div.find_elements(By.CSS_SELECTOR, 'span.success')

    # Vérifie que la div contient bien 9 span
    if len(success_spans) != 9:
        print(f"Erreur : Il y a {len(success_spans)} span au lieu de 9.")
    else:
        # Vérifie que le premier span contient le texte 'You have selected'
        if success_spans[0].text != 'You have selected':
            print(f"Erreur : Le premier span ne contient pas 'You have selected', mais '{success_spans[0].text}'.")
        
        # Liste des mots attendus pour les 8 autres span
        expected_words = ['desktop', 'notes', 'commands', 'workspace', 'react', 'angular', 'veu', 'wordFile']

        # Vérifie que les 8 autres span contiennent les mots attendus
        for i in range(1, len(success_spans)):
            if i-1 < len(expected_words):
                if success_spans[i].text != expected_words[i-1]:
                    print(f"Erreur : Le span {i+1} ne contient pas '{expected_words[i-1]}', mais '{success_spans[i].text}'.")
            else:
                print(f"Erreur : Le span {i+1} est inattendu.")

        # Si tout est correct, afficher une confirmation
        print("Vérification réussie!")


#@pytest.mark.skip
############################################################################################################
#Scénario 2 Supprimer des lignes d'un tableau
############################################################################################################
@scenario('features/julienneDeLegume_demoQA.feature', 'The visitor can delete some table rows')
def test_input_presence2():
    #Vérifier que l'on est bien sur la bonne page
    #Vérifier que l'on a bien un tableau
    pass

@given('I am on the webtables page')
def open_webtables_page(browser):
    browser.maximize_window()
    browser.get(base() + url()['elements'][3])
    time.sleep(2)

@when('I delete some rows')
def delete_some_rows(browser):
    browser.find_element(By.XPATH, "//span[@id='delete-record-1']").click()
    time.sleep(2)
    browser.find_element(By.XPATH, "//span[@id='delete-record-2']").click()
    time.sleep(2)

@then('The concerned rows are deleted from the table') 
def confirm_resting_rows(browser):
    #Vérifier qu'il ne reste qu'une ligne dans le tableau'
    pass


#@pytest.mark.skip
############################################################################################################
#Scénario 3 Modifier des lignes d'un tableau
############################################################################################################
@scenario('features/julienneDeLegume_demoQA.feature', 'The visitor can modify some table rows')
def test_input_presence3():
    #Vérifier que l'on est bien sur la bonne page
    #Vérifier que l'on a bien un tableau
    pass

@given('I am on the webtables page')
def open_webtables_page(browser):
    browser.maximize_window()
    browser.get(base() + url()['elements'][3])
    time.sleep(2)

@when('I modify some rows contents')
def modify_some_rows(browser):
    #Ouvrir le formulaire d'édition de la ligne 1 du tableau
    browser.find_element(By.XPATH, "//span[@id='edit-record-1']").click()
    time.sleep(2)
    #Vider le champs Salaire du formulaire
    browser.find_element(By.XPATH, "//input[@id='salary']").clear()
    time.sleep(1)
    #Modifier le champs Salaire du formulaire
    browser.find_element(By.XPATH, "//input[@id='salary']").send_keys("2789")
    time.sleep(1)
    #Valider le formulaire
    browser.find_element(By.XPATH, "//button[@id='submit']").click()
    time.sleep(3)


@then('The concerned rows are visibly modified in the table')
def confirm_modification(browser):
    #Vérifier que la valeur du salaire a bien été modifiée sur la 1ère ligne
    pass

#@pytest.mark.skip
############################################################################################################
#Scénario 4 Ouvrir et fermer un nouvel onglet
############################################################################################################
@scenario('features/julienneDeLegume_demoQA.feature', 'The visitor can open and close a new tab')
def test_input_presence4():
    #Vérifier que l'on est bien sur la bonne page
    #Vérifier que l'on a bien un bouton pour ouvrir un nouvel onglet
    pass

@given('I am on the browser windows page')
def open_browser_windows_page(browser):
    browser.maximize_window()
    browser.get(base() + url()['alertsWindows'][0])
    time.sleep(2)

@when('I open a new tab')
def open_new_tab(browser):
    browser.find_element(By.XPATH, "//button[.='New Tab']").click()
    time.sleep(2)

@when('I navigate to it')
def navigate_to_new_tab(browser):
    #Récupérer les onglets ouverts
    tabs = browser.window_handles
    #Naviguer vers le nouvel onglet
    browser.switch_to.window(tabs[1])
    time.sleep(2)

@when('I close it')
def close_new_tab(browser):
    #Fermer l'onglet
    browser.close()
    time.sleep(2)

@then('I am on the browser windows page')
def confirm_back_to_browser_windows_page(browser):
    #Récupérer les onglets ouverts
    tabs = browser.window_handles
    #Naviguer vers le nouvel onglet
    browser.switch_to.window(tabs[0])
    time.sleep(2)

#@pytest.mark.skip
############################################################################################################
#Scénario 5 Ouvrir une boîte de dialogue spécifique
############################################################################################################
@scenario('features/julienneDeLegume_demoQA.feature', 'The visitor can open a specific modal dialog')
def test_input_presence5():
    #Vérifier que l'on est bien sur la bonne page
    #Vérifier que l'on a bien un bouton pour ouvrir une modal
    pass

@given('I am on the modal dialogs page')
def open_modal_dialogs_page(browser):
    browser.maximize_window()
    browser.get(base() + url()['alertsWindows'][4])
    time.sleep(2)

@when('I open the targeted modal panel')
def open_specific_modal_dialog(browser):
    browser.find_element(By.XPATH, "//button[@id='showLargeModal']").click()
    time.sleep(2)

@then('I can see the expected content in the modal dialog')
def confirm_modal_opened(browser):
    #Vérifier que la modal est ouverte
    pass

@then('I close the modal dialog')
def close_modal_dialog(browser):
    browser.find_element(By.XPATH, "//button[@id='closeLargeModal']").click()
    time.sleep(2)

#@pytest.mark.skip
############################################################################################################
#Scénario 6 Activation et animation d'une barre de progression
############################################################################################################
@scenario('features/julienneDeLegume_demoQA.feature', 'The visitor can start a progress bar and see it complete')
def test_input_presence6():
    #Vérifier que l'on est bien sur la bonne page
    #Vérifier que l'on a bien un bouton pour lancer la barre de progression
    pass

@given('I am on the progress bar page')
def open_progress_bar_page(browser):
    browser.maximize_window()
    browser.get(base() + url()['widgets'][4])
    time.sleep(2)

@when('I start the progress bar')
def start_progress_bar(browser):
    browser.find_element(By.XPATH, "//button[@id='startStopButton']").click()
    time.sleep(2)

@then('the progress bar reaching is completely green') 
def confirm_progress_bar_color(browser):
    #Vérifier que la barre de progression est complète
    pass

@then('the progress bar reaching text is 100%')
def confirm_progress_bar_text(browser):
    #Vérifier que le texte de progression est bien '100%'
    pass

#@pytest.mark.skip
############################################################################################################
#Scénario 7 Naviguer dans un menu déroulant
############################################################################################################
@scenario('features/julienneDeLegume_demoQA.feature', 'The visitor can navigate through a menu')
def test_input_presence7():
    #Vérifier que l'on est bien sur la bonne page
    #Vérifier que l'on a bien un menu déroulant 
    pass

@given('I am on the menu page')
def open_menu_page(browser):
    browser.maximize_window()
    browser.get(base() + url()['widgets'][7])
    time.sleep(2)

@when('I navigate through the menu')
def navigate_through_menu(browser):

    #Naviguer dans le menu en mode bandit (sans hover)
    browser.find_element(By.XPATH, "//a[text()='Main Item 2']").click()
    time.sleep(1)
    browser.find_element(By.XPATH, "//a[text()='SUB SUB LIST »']").click()
    time.sleep(2)
    browser.find_element(By.XPATH, "//a[text()='Sub Sub Item 2']").click()
    time.sleep(2)
@then('I can see the expected content in the menu')
def confirm_menu_navigation(browser):
    #Vérifier que le contenu attendu est bien affiché
    pass

#@pytest.mark.skip 
############################################################################################################
#Scénario 8 Sélectionner une option dans une liste déroulante
############################################################################################################
@scenario('features/julienneDeLegume_demoQA.feature', 'The visitor can select one option in a select menu')
def test_input_presence8():
    #Vérifier que l'on est bien sur la bonne page
    #Vérifier que l'on a bien les listes déroulantes visées
    pass

@given('I am on the select menu page')
def open_select_menu_page(browser):
    #browser.maximize_window()#fonctione sur le 7, mais pas là bizarrement
    browser.set_window_size(width=1400, height=1024)
    browser.get(base() + url()['widgets'][8])
    time.sleep(2)
    

@when('I select one option in the select menu \'Select Value\'')
def select_option_in_select_menu_1(browser):
    pass #Ne fonctionne pas correctement, il manque peut-être le bon sélécteur pour alimenter le champ

    #Sélectionner une liste déroulante
    ##select1 = browser.find_element(By.XPATH, "//input[@id='react-select-2-input']")
    #select1 = browser.find_element(By.XPATH, "//div[@id='withOptGroup']")
    #select1.click()
    #time.sleep(1)
    #Entrer l'option recherchée
    #select1.send_keys("Another root option")

    #Appuyer sur Entrée
    #select1.send_keys("\ue007")
    #time.sleep(2)

@when('I select one option in the select menu \'Select One\'')
def select_option_in_select_menu_2(browser):
    pass #Ne fonctionne pas correctement, il manque peut-être le bon sélécteur pour alimenter le champ

    #Sélectionner une liste déroulante
    ##select2 = browser.find_element(By.XPATH, "//input[@id='react-select-3-input']")
    #select2 = browser.find_element(By.XPATH, "//div[@id='selectOne']")
    #select2.click()

    #time.sleep(1)
    #browser.execute_script("window.scrollTo(0, 400);")
    #Entrer l'option recherchée
    #select2.send_keys("Other")
    #Appuyer sur Entrée
    #select2.send_keys("\ue007")
    #time.sleep(2)

@when('I select one option in the select menu \'Old Style Select Menu\'')
def select_option_in_select_menu_3(browser):
    #Sélectionner une liste déroulante
    select3 = browser.find_element(By.XPATH, "//select[@id='oldSelectMenu']")
    select3.click()
    time.sleep(1)
    select3.send_keys("ARROW_DOWN")
    #Entrer l'option recherchée
    #browser.find_element(By.XPATH, "//option[@value='Aqua']").click()
    #Appuyer sur Entrée
    select3.send_keys("\ue007")
    time.sleep(2)

@then('I can see the expected contents in the select menus selected items')
def confirm_select_menu_selection(browser):
    #Vérifier que les options sélectionnées sont bien affichées
    pass

@pytest.mark.skip
############################################################################################################
#Scénario 9 Sélectionner plusieurs options dans une liste déroulante
############################################################################################################
@scenario('features/julienneDeLegume_demoQA.feature', 'The visitor can select multiple options in a select menu')
def test_input_presence9():
    #Vérifier que l'on est bien sur la bonne page
    #Vérifier que l'on a bien une liste déroulante
    pass    

@given('I am on the select menu page')
def open_select_menu_page(browser):
    browser.get(base() + url()['widgets'][8])
    time.sleep(2)

@when('I select multiple options in the select menu \'Multi Select Drop Down\'')
def select_multiple_options_in_select_menu(browser):
    #Sélectionner plusieurs options
    browser.find_element(By.XPATH, "//div[.='Select Value']").click()
    time.sleep(2)
    browser.find_element(By.XPATH, "//div[.='Blue']").click()
    time.sleep(2)
    browser.find_element(By.XPATH, "//div[.='Green']").click()
    time.sleep(2)
    browser.find_element(By.XPATH, "//div[.='Yellow']").click()
    time.sleep(2)

@then('I can see the expected contents in the select menu selected items')
def confirm_select_menu_selection(browser):
    #Vérifier que les options sélectionnées sont bien affichées
    pass


@pytest.mark.skip
############################################################################################################
#Scénario 10 Chercher un livre sans son nom
############################################################################################################
@scenario('features/julienneDeLegume_demoQA.feature', 'The visitor can find a book with its Author name')
def test_input_presence10():
    #Vérifier que l'on est bien sur la bonne page
    #Vérifier que l'on a bien une barre de recherche
    pass    

@given('I am on the books store page')
def open_book_store_page(browser):
    browser.get(base() + url()['bookStoreApplication'][1])
    time.sleep(2)

@when('I search a book without its name')
def search_book_by_other(browser):
    pass

@then('I find the book i search')
def find_searched_book(browser):
    pass